local event = {}

event.Enabled = true
event.Name = "BeaconPirate"
event.MinRoundTime = 5
event.MaxRoundTime = 20
event.MinIntensity = 0
event.MaxIntensity = 1
event.ChancePerMinute = 0.10
event.OnlyOncePerRound = true

event.AmountPoints = 2000

event.Start = function ()
    local beacon = Level.Loaded.BeaconStation

    if beacon == nil then
        return
    end

    Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.Prefabs["sonarbeacon"], beacon.WorldPosition, nil, nil, function(item)
        Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.Prefabs["batterycell"], item.OwnInventory, nil, nil, function(bat)
            bat.Indestructible = true

            local interface = item.GetComponentString("CustomInterface")

            interface.customInterfaceElementList[1].State = true
            interface.customInterfaceElementList[2].Signal = "Последняя известная позиция пирата"

            item.CreateServerEvent(interface, interface)

        end)
    end)

    local info = CharacterInfo(Identifier("human"))
    info.Job = Job(JobPrefab.Get("securityofficer"))

    local character = Character.Create(info, beacon.WorldPosition, info.Name, 0, false, true)

    character.TeamID = CharacterTeamType.Team2
    character.GiveJobItems(nil)

    for i = 1, 4, 1 do
        Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("shotgun"), character.Inventory, nil, nil, function (item)
            for i = 1, 6, 1 do
                Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("shotgunshell"), item.OwnInventory)
            end
        end)
    end

    local oldClothes = character.Inventory.GetItemInLimbSlot(InvSlotType.InnerClothes)
    oldClothes.Drop()
    Entity.Spawner.AddEntityToRemoveQueue(oldClothes)

    Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("pirateclothes"), character.Inventory, nil, nil, function (item)
        character.Inventory.TryPutItem(item, character.Inventory.FindLimbSlot(InvSlotType.InnerClothes), true, false, character)
    end)

    Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("pucs"), character.Inventory, nil, nil, function (item)
        Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("combatstimulantsyringe"), item.OwnInventory)
        Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("oxygenitetank"), item.OwnInventory)
    end)

    event.ItemReward = character.Inventory.GetItemInLimbSlot(InvSlotType.Card)

    local text = "Поступали сообщения о печально известном пирате в костюме PUCS, терроризирующем эти воды. Недавно пират был обнаружен на станции маяка - уничтожьте пирата и заберите его идентификационную карту, чтобы получить вознаграждение в размере " .. event.AmountPoints .. " очков."
    Traitormod.RoundEvents.SendEventMessage(text, "CrewWalletIconLarge")

    Hook.Add("think", "BeaconPirate.Think", function ()
        if event.ItemReward.ParentInventory == nil then return end

        local owner = event.ItemReward.ParentInventory.Owner

        if tostring(owner) == "Human" then
            local client = Traitormod.FindClientCharacter(owner)

            if client ~= nil then
                Traitormod.AwardPoints(client, event.AmountPoints)
                Traitormod.SendMessage(client, "Вы получили " .. event.AmountPoints .. " очков.", "InfoFrameTabButton.Mission")

                event.End()
            end
        end
    end)
end


event.End = function (isEndRound)
    Hook.Remove("think", "BeaconPirate.Think")

    if isEndRound then return end

    local text = "Пират в PUCS был убит, храбрый член экипажа, убивший пирата, был награжден " .. event.AmountPoints .. " очков."
    Traitormod.RoundEvents.SendEventMessage(text, "CrewWalletIconLarge")
end

return event