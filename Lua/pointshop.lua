local ps = {}

local config = Traitormod.Config
local textPromptUtils = require("textpromptutils")

local defaultLimit = 999

ps.GlobalProductLimits = {}
ps.LocalProductLimits = {}

ps.ResetProductLimits = function()
    ps.GlobalProductLimits = {}
    ps.LocalProductLimits = {}
end

ps.GetProductLimit = function (client, product)
    if product.IsLimitGlobal then
        if ps.GlobalProductLimits[product.Name] == nil then
            ps.GlobalProductLimits[product.Name] = product.Limit or defaultLimit
        end

        return ps.GlobalProductLimits[product.Name]
    else
        if ps.LocalProductLimits[client.SteamID] == nil then
            ps.LocalProductLimits[client.SteamID] = {}
        end

        local localProductLimit = ps.LocalProductLimits[client.SteamID]

        if localProductLimit[product.Name] == nil then
            localProductLimit[product.Name] = product.Limit or defaultLimit
        end

        return localProductLimit[product.Name]
    end
end

ps.UseProductLimit = function (client, product)
    if product.IsLimitGlobal then
        if ps.GlobalProductLimits[product.Name] == nil then
            ps.GlobalProductLimits[product.Name] = product.Limit or defaultLimit
        end

        if ps.GlobalProductLimits[product.Name] > 0 then
            ps.GlobalProductLimits[product.Name] = ps.GlobalProductLimits[product.Name] - 1
            return true
        else
            return false
        end
    else
        if ps.LocalProductLimits[client.SteamID] == nil then
            ps.LocalProductLimits[client.SteamID] = {}
        end

        local localProductLimit = ps.LocalProductLimits[client.SteamID]

        if localProductLimit[product.Name] == nil then
            localProductLimit[product.Name] = product.Limit or defaultLimit
        end

        if localProductLimit[product.Name] > 0 then
            localProductLimit[product.Name] = localProductLimit[product.Name] - 1
            return true
        else
            return false
        end
    end
end

ps.CanClientAccessCategory = function(client, category)
    local isDead = client.Character == nil or client.Character.IsDead or not client.Character.IsHuman

    if isDead and not category.IsDeadOnly then
        return false
    end

    if not isDead and category.IsDeadOnly then
        return false
    end

    -- FIXME: Is this correct?
    if category.IsTraitorOnly and not client.Character.IsTraitor then
        return false
    end

    return true
end

ps.ValidateClient = function(client)
    if not config.PointShopConfig.Enabled then
        Traitormod.SendMessage(client, "Pointshop is not enabled.")
        return false
    end

    if not client.InGame then
        Traitormod.SendMessage(client, "You must be in game to use the Pointshop.")
        return false
    end

    return true
end

ps.SpawnItem = function(client, item, onSpawned)
    local prefab = ItemPrefab.GetItemPrefab(item.Identifier)
    local condition = item.Condition or 100

    if prefab == nil then
        Traitormod.SendMessage(client, "PointShop Error: Could not find item with identifier " .. item.Identifier .. " please report this error.")
        Traitormod.Error("PointShop Error: Could not find item with identifier " .. item.Identifier)
        return
    end

    local function OnSpawn(item)
        local powerContainer = item.GetComponentString("PowerContainer")
        if powerContainer then
            powerContainer.Charge = powerContainer.Capacity
        end

        if onSpawned then onSpawned(item) end
    end

    if item.IsInstallation then
        if client.Character.Submarine == nil then
            Entity.Spawner.AddItemToSpawnQueue(prefab, client.Character.WorldPosition, condition, nil, OnSpawn)
        else
            Entity.Spawner.AddItemToSpawnQueue(prefab, client.Character.WorldPosition - client.Character.Submarine.Position, client.Character.Submarine, condition, nil, OnSpawn)
        end
    else
        Entity.Spawner.AddItemToSpawnQueue(prefab, client.Character.Inventory, condition, nil, OnSpawn)
    end
end

ps.ActivateProduct = function (client, product)
    local spawnedItems = {}
    local spawnedItemCount = 0

    local function OnSpawned(item)
        table.insert(spawnedItems, item)

        spawnedItemCount = spawnedItemCount + 1

        if spawnedItemCount == #product.Items and product.Action then
            product.Action(client, product, spawnedItems)
        end
    end

    if product.Items then
        if product.ItemRandom then
            local randomIndex = math.random(1, #product.Items)
            local item = product.Items[randomIndex]

            if type(product.Items[randomIndex]) == "string" then
                item = {Identifier = product.Items[randomIndex]}
            end

            ps.SpawnItem(client, item, OnSpawned)
        else
            for key, value in pairs(product.Items) do
                if type(value) == "string" then
                    value = {Identifier = value}
                end

                ps.SpawnItem(client, value, OnSpawned)
            end
        end
    end

    if product.Items == nil or #product.Items == 0 and product.Action then
        product.Action(client, product)
    end
end

ps.BuyProduct = function(client, product)
    local points = Traitormod.GetData(client, "Points") or 0

    if product.Price > points then
        textPromptUtils.Prompt("You do not have enough points to buy this item.", {}, client, function (id, client) end, "gambler")
        return
    end

    if not ps.UseProductLimit(client, product) then
        textPromptUtils.Prompt("This product is out of stock.", {}, client, function (id, client) end, "gambler")
        return
    end

    Traitormod.Log(string.format("PointShop: %s bought \"%s\".", client.Name, product.Name))

    Traitormod.SetData(client, "Points", points - product.Price)

    points = Traitormod.GetData(client, "Points") or 0

    textPromptUtils.Prompt(string.format("Purchased \"%s\" for %s points\n\nNew point balance is: %s points.", product.Name, product.Price, math.floor(points)), {}, client, function (id, client) end, "gambler")

    -- Activate the product
    ps.ActivateProduct(client, product)
end

ps.ShowCategoryItems = function(client, category)
    local options = {}
    local productsLookup = {}

    table.insert(options, ">> Go Back <<")
    table.insert(options, ">> Cancel <<")

    for key, product in pairs(category.Products) do
        local text = string.format("%s - %spt (%s/%s)",
            product.Name, product.Price, ps.GetProductLimit(client, product), product.Limit or defaultLimit)

        table.insert(options, text)
        productsLookup[#options] = product
    end

    table.insert(options, "") -- FIXME: for some reason when the bar is full, the last item is never shown?

    local points = Traitormod.GetData(client, "Points") or 0

    textPromptUtils.Prompt(
        "Your current balance: " .. math.floor(points) .." points\nWhat do you wish to buy?", 
        options, client, function (id, client2)
        if id == 1 then
            ps.ShowCategory(client2)
        end

        local product = productsLookup[id]
        if product == nil then return end

        local productHasInstallation = false

        if product.Items ~= nil then
            for key, value in pairs(product.Items) do
                if type(value) == "table" and value.IsInstallation then
                    productHasInstallation = true
                end
            end
        end
        
        if productHasInstallation then
            textPromptUtils.Prompt(
            "The product that you are about to buy will spawn an installation in your exact location, you won't be able to move it else where, do you wish to continue?\n",
            {"Yes", "No"}, client2, function (id, client3)
                if id == 1 then
                    if not ps.ValidateClient(client3) or not ps.CanClientAccessCategory(client2, category) then
                        return
                    end

                    ps.BuyProduct(client3, product)
                end
            end, category.IsTraitorOnly and "clown" or "gambler", category.IsTraitorOnly)
        else
            if not ps.ValidateClient(client2) or not ps.CanClientAccessCategory(client2, category) then
                return
            end

            ps.BuyProduct(client2, product)
        end
    end, category.IsTraitorOnly and "clown" or "gambler", category.IsTraitorOnly)
end

ps.ShowCategory = function(client)
    local options = {}
    local categoryLookup = {}

    table.insert(options, ">> Cancel <<")

    for key, value in pairs(config.PointShopConfig.ItemCategories) do
        if ps.CanClientAccessCategory(client, value) then
            table.insert(options, value.Name)
            categoryLookup[#options] = value
        end
    end

    if #options == 1 then
        textPromptUtils.Prompt("Point Shop not available.", {}, client, function (id, client) end, "gambler")
        return
    end

    table.insert(options, "") -- FIXME: for some reason when the bar is full, the last item is never shown?

    local points = Traitormod.GetData(client, "Points") or 0

    -- note: we have two different client variables here to prevent cheating
    textPromptUtils.Prompt("Your current balance: " .. math.floor(points) .." points\nChoose a category.", options, client, function (id, client2)
        if categoryLookup[id] == nil then return end

        ps.ShowCategoryItems(client2, categoryLookup[id])
    end, "officeinside")
end

Traitormod.AddCommand("!pointshop", function (client, args)
    if not ps.ValidateClient(client) then
        return true
    end

    ps.ShowCategory(client)

    return true
end)

Hook.Add("roundEnd", "TraitorMod.PointShop.RoundEnd", function ()
    ps.ResetProductLimits()
end)