local category = {}

category.Name = "Возрождение"
category.Decoration = "huskinvite"

category.CanAccess = function(client)
    return client.Character == nil or client.Character.IsDead or not client.Character.IsHuman
end

local function SpawnCreature(species, client, insideHuman)
    local waypoints = Submarine.MainSub.GetWaypoints(true)
    local spawnPositions = {}

    if insideHuman then
        for key, value in pairs(Character.CharacterList) do
            if value.IsHuman and not value.IsDead then
                table.insert(spawnPositions, value.WorldPosition)
            end
        end
    else
        for key, value in pairs(waypoints) do
            if value.CurrentHull == nil then
                table.insert(spawnPositions, value.WorldPosition)
            end
        end
    end

    local spawnPosition

    if #spawnPositions == 0 then
        -- no waypoints? https://c.tenor.com/RgExaLgYIScAAAAC/megamind-megamind-meme.gif
        spawnPosition = Submarine.MainSub.WorldPosition -- spawn it in the middle of the sub

        Traitormod.Log("Couldnt find any good waypoints, spawning in the middle of the sub.")
    else
        spawnPosition = spawnPositions[math.random(#spawnPositions)]
    end

    Entity.Spawner.AddCharacterToSpawnQueue(species, spawnPosition, function (character)
        client.SetClientCharacter(character)
    end)
end

category.Products = {
    {
        Name = "Появиться как Ползун",
        Price = 450,
        Limit = 4,
        IsLimitGlobal = true,
        PricePerLimit = 100,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("crawler", client)
        end
    },

    {
        Name = "Появиться как Ползун(старая модель)",
        Price = 400,
        Limit = 4,
        IsLimitGlobal = true,
        PricePerLimit = 100,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("legacycrawler", client)
        end
    },

    {
        Name = "Появиться как детеныш Ползуна",
        Price = 250,
        Limit = 5,
        IsLimitGlobal = true,
        PricePerLimit = 50,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("crawler_hatchling", client)
        end
    },

    {
        Name = "Появиться как детеныш Грязевого раптора",
        Price = 400,
        Limit = 5,
        IsLimitGlobal = true,
        PricePerLimit = 150,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("mudraptor_hatchling", client)
        end
    },

    {
        Name = "Появиться как детеныш Акульего тигра",
        Price = 800,
        Limit = 5,
        IsLimitGlobal = true,
        PricePerLimit = 250,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("tigerthresher_hatchling", client)
        end
    },

    {
        Name = "Появиться как Шипостай",
        Price = 400,
        Limit = 4,
        IsLimitGlobal = true,
        PricePerLimit = 250,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("spineling", client)
        end
    },

    {
        Name = "Появиться как Грязевой раптор",
        Price = 1200,
        Limit = 3,
        IsLimitGlobal = true,
        PricePerLimit = 400,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("mudraptor", client)
        end
    },

    {
        Name = "Появиться как Креветка",
        Price = 1600,
        Limit = 2,
        IsLimitGlobal = true,
        PricePerLimit = 400,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("mantis", client)
        end
    },

    {
        Name = "Появится как Хаск",
        Price = 2300,
        Limit = 2,
        IsLimitGlobal = true,
        PricePerLimit = 400,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("husk", client)
        end
    },

    {
        Name = "Появиться как Костолом",
        Price = 2400,
        Limit = 2,
        IsLimitGlobal = true,
        PricePerLimit = 500,
        Enabled = true,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("Bonethresher", client)
        end
    },

    {
        Name = "Появиться как Акулий тигр",
        Price = 3000,
        Limit = 2,
        IsLimitGlobal = true,
        PricePerLimit = 500,
        Enabled = true,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("Tigerthresher", client)
        end
    },

    {
        Name = "Появиться как Молотоглав",
        Price = 5000,
        Limit = 2,
        IsLimitGlobal = true,
        PricePerLimit = 1000,
        Enabled = true,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("hammerhead", client)
        end
    },

    {
        Name = "Появиться как Фрактальный Страж",
        Price = 6500,
        Limit = 1,
        IsLimitGlobal = true,
        PricePerLimit = 3000,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("fractalguardian", client)
        end
    },

    {
        Name = "Появиться как Ветеран мудраптор",
        Price = 10000,
        Limit = 2,
        IsLimitGlobal = true,
        PricePerLimit = 1000,
        Enabled = true,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("Mudraptor_veteran", client)
        end
    },

    {
        Name = "Появиться как Харибда",
        Price = 150000,
        Limit = 1,
        IsLimitGlobal = true,
        PricePerLimit = 50000,
        Timeout = 120,

        Action = function (client, product, items)
            SpawnCreature("charybdis", client)
        end
    },

    {
        Name = "Появиться как Арахис(Питомец)",
        Price = 50,
        Limit = 2,
        IsLimitGlobal = false,

        Action = function (client, product, items)
            SpawnCreature("peanut", client, true)
        end
    },

    {
        Name = "Появиться как Оранжевый парень(Питомец)",
        Price = 50,
        Limit = 2,
        IsLimitGlobal = false,

        Action = function (client, product, items)
            SpawnCreature("orangeboy", client, true)
        end
    },

    {
        Name = "Появиться как Ктулху(Питомец)",
        Price = 50,
        Limit = 2,
        IsLimitGlobal = false,

        Action = function (client, product, items)
            SpawnCreature("balloon", client, true)
        end
    },

    {
        Name = "Появиться как Псилотоад(Питомец)",
        Price = 50,
        Limit = 2,
        IsLimitGlobal = false,

        Action = function (client, product, items)
            SpawnCreature("psilotoad", client, true)
        end
    },
}

return category