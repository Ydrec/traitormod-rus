local category = {}

category.Name = "Подводные лодки"
category.CanAccess = function(client)
    return client.Character and not client.Character.IsDead and client.Character.IsHuman and Traitormod.SubmarineBuilder ~= nil
end

category.Init = function ()
    if Traitormod.SubmarineBuilder then
        category.StreamChalkId = Traitormod.SubmarineBuilder.AddSubmarine(Traitormod.Path .. "/Submarines/Stream Chalk.sub", "[P]Stream Chalk")
        category.BarsukId = Traitormod.SubmarineBuilder.AddSubmarine("Content/Submarines/Barsuk.sub", "[P]Barsuk")
    end
end

local function CanBuy(id, client)
    local submarine = Traitormod.SubmarineBuilder.FindSubmarine(id)
    local position = client.Character.WorldPosition + Vector2(0, -submarine.Borders.Height)

    local levelWalls = Level.Loaded.GetTooCloseCells(position, submarine.Borders.Width)
    if #levelWalls > 0 then
        return false, "Невозможно разместить подлодку, позиция находится слишком близко к стене уровня."
    end

    for key, value in pairs(Submarine.Loaded) do
        if submarine ~= value then
            local maxDistance = (value.Borders.Width + submarine.Borders.Width) / 2
            if Vector2.Distance(value.WorldPosition, position) < maxDistance then
                return false, "Невозможно разместить подлодку, позиция находится слишком близко к другой подлодке."
            end
        end
    end

    return true
end

local function SpawnSubmarine(id, client)
    local submarine = Traitormod.SubmarineBuilder.FindSubmarine(id)
    local position = client.Character.WorldPosition + Vector2(0, -submarine.Borders.Height)

    submarine.SetPosition(position)
    submarine.GodMode = false

    Traitormod.SubmarineBuilder.ResetSubmarineSteering(submarine)
    return submarine
end

category.Products = {
    {
        Name = "Stream Chalk",
        Price = 300,
        Limit = 1,
        IsLimitGlobal = true,

        Action = function (client, product, items)
            SpawnSubmarine(category.StreamChalkId, client)
        end,

        CanBuy = function (client, product)
            return CanBuy(category.StreamChalkId, client)
        end
    },

    {
        Name = "Barsuk",
        Price = 3000,
        Limit = 1,
        IsLimitGlobal = true,

        Action = function (client, product, items)
            local submarine = SpawnSubmarine(category.BarsukId, client)
            AutoItemPlacer.RegenerateLoot(submarine, nil)
        end,

        CanBuy = function (client, product)
            return CanBuy(category.BarsukId, client)
        end
    },
}

return category