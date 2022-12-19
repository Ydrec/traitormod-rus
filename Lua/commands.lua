----- USER COMMANDS -----
Traitormod.AddCommand("!help", function (client, args)
    Traitormod.SendMessage(client, Traitormod.Language.Help)

    return true
end)

Traitormod.AddCommand("!helpadmin", function (client, args)
    Traitormod.SendMessage(client, Traitormod.Language.HelpAdmin)

    return true
end)

Traitormod.AddCommand("!helptraitor", function (client, args)
    Traitormod.SendMessage(client, Traitormod.Language.HelpTraitor)

    return true
end)

Traitormod.AddCommand("!version", function (client, args)
    Traitormod.SendMessage(client, "Работает Traitor Mod - RU от Evil Factory v" .. Traitormod.VERSION)

    return true
end)

Traitormod.AddCommand("!traitor", function (client, args)
    if Traitormod.Config.OptionalTraitors and Traitormod.GetData(client, "NonTraitor") == true then
        Traitormod.SendMessage(client, Traitormod.Language.TraitorOff)
    elseif Game.ServerSettings.TraitorsEnabled == 0 then
        Traitormod.SendMessage(client, Traitormod.Language.NoTraitors)
    elseif Game.RoundStarted and Traitormod.SelectedGamemode and Traitormod.SelectedGamemode.GetTraitorObjectiveSummary then
        local summary = Traitormod.SelectedGamemode.GetTraitorObjectiveSummary(client.Character)
        Traitormod.SendMessage(client, summary)
    elseif Game.RoundStarted then
        Traitormod.SendMessage(client, Traitormod.Language.NoTraitor)
    else
        Traitormod.SendMessage(client, Traitormod.Language.RoundNotStarted)
    end

    return true
end)

Traitormod.AddCommand("!toggletraitor", function (client, args)
    local text = Traitormod.Language.CommandNotActive

    if Traitormod.Config.OptionalTraitors then
        local toggle = false
        if #args > 0 then
            toggle = string.lower(args[1]) == "on"
        else
            toggle = Traitormod.GetData(client, "NonTraitor") == true
        end
    
        if toggle then
            text = Traitormod.Language.TraitorOn
        else
            text = Traitormod.Language.TraitorOff
        end
        Traitormod.SetData(client, "NonTraitor", not toggle)
        Traitormod.SaveData() -- move this to player disconnect someday...
        
        Traitormod.Log(Traitormod.ClientLogName(client) .. " может стать предателем: " .. tostring(toggle))
    end

    Traitormod.SendMessage(client, text)

    return true
end)

Traitormod.AddCommand({"!point", "!points"}, function (client, args)
    Traitormod.SendMessage(client, Traitormod.GetDataInfo(client, true))

    return true
end)

Traitormod.AddCommand("!info", function (client, args)
    Traitormod.SendWelcome(client)
    
    return true
end)

Traitormod.AddCommand({"!suicide", "!kill", "!death"}, function (client, args)
    if client.Character == nil or client.Character.IsDead then
        Traitormod.SendMessage(client, "Ты уже мертв!")
        return true
    end

    client.Character.Kill(CauseOfDeathType.Unknown)
end)

----- TRAITOR COMMANDS -----
Traitormod.AddCommand("!tc", function (client, args)
    local feedback = Traitormod.Language.CommandNotActive
    
    if not Traitormod.Config.TraitorBroadcast then
        feedback = Traitormod.Language.CommandNotActive
    elseif not client.InGame or not client.Character or not client.Character.IsTraitor then
        feedback = Traitormod.Language.NoTraitor
    elseif Traitormod.SelectedGamemode and Traitormod.SelectedGamemode.Traitors then
        if #args > 0 then
            local msg = ""
            for word in args do
                msg = msg .. " " .. word
            end

            for character, traitor in pairs(Traitormod.SelectedGamemode.Traitors) do
                local traitorClient = Traitormod.FindClientCharacter(character)
                if traitorClient then
                    Game.SendDirectChatMessage("", string.format(Traitormod.Language.TraitorBroadcast, Traitormod.ClientLogName(client), msg), nil, ChatMessageType.Error, traitorClient)
                end
            end
        
            return (not Traitormod.Config.TraitorBroadcastHearable)
        else
            feedback = "Использование: !tc [Сообщение]"
        end
    end

    Game.SendDirectChatMessage("", feedback, nil, Traitormod.Config.ChatMessageType, client)

    return true
end)

Traitormod.AddCommand("!tdm", function (client, args)
    local feedback = ""
    if not Traitormod.Config.TraitorDm then
        feedback = Traitormod.Language.CommandNotActive
    elseif client.Character.IsTraitor then
        print(#args)
        if #args > 1 then
            local found = Traitormod.FindClient(table.remove(args, 1))
            local msg = ""
            for word in args do
                msg = msg .. " " .. word
            end
            if found then
                Traitormod.SendMessage(found, Traitormod.Language.TraitorDirectMessage .. msg)
                feedback = string.format("[To %s]: %s", Traitormod.ClientLogName(found), msg)
                return true
            else
                feedback = "Имя не найдено."
            end
        else
            feedback = "Использование: !tdm [Имя] [Сообщение]"
        end
    else
        feedback = Traitormod.Language.NoTraitor
        Traitormod.SendMessage(client, Traitormod.Language.NoTraitor)
        return true
    end

    Game.SendDirectChatMessage("", feedback, nil, Traitormod.Config.ChatMessageType, client)
    return true
end)

----- ADMIN COMMANDS -----
Traitormod.AddCommand("!alive", function (client, args)
    if not (client.Character == nil or client.Character.IsDead) and not client.HasPermission(ClientPermissions.ConsoleCommands) then return end

    if not Game.RoundStarted or Traitormod.SelectedGamemode == nil then
        Traitormod.SendMessage(client, Traitormod.Language.RoundNotStarted)

        return true
    end

    local msg = ""
    for index, value in pairs(Character.CharacterList) do
        if value.IsHuman and not value.IsBot then
            if value.IsDead then
                msg = msg .. value.Name .. " ---- " .. Traitormod.Language.Dead .. "\n"
            else
                msg = msg .. value.Name .. " ++++ " .. Traitormod.Language.Alive .. "\n"
            end
        end
    end

    Traitormod.SendMessage(client, msg)

    return true
end)

Traitormod.AddCommand("!roundinfo", function (client, args)
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return end

    if Game.RoundStarted and Traitormod.SelectedGamemode and Traitormod.SelectedGamemode.GetRoundSummary then
        Traitormod.SendMessage(client, Traitormod.SelectedGamemode.GetRoundSummary())
    elseif Traitormod.LastRoundSummary ~= nil then
        Traitormod.SendMessage(client, Traitormod.LastRoundSummary)
    else
        Traitormod.SendMessage(client, Traitormod.Language.RoundNotStarted)
    end

    return true
end)

Traitormod.AddCommand({"!allpoint", "!allpoints"}, function (client, args)
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return end
    
    local messageToSend = ""

    for index, value in pairs(Client.ClientList) do
        messageToSend = messageToSend .. "\n" .. value.Name .. ": " .. math.floor(Traitormod.GetData(value, "Points") or 0) .. " Очки - " .. math.floor(Traitormod.GetData(value, "Weight") or 0) .. " Вес"
    end

    Traitormod.SendMessage(client, messageToSend)

    return true
end)

Traitormod.AddCommand({"!addpoint", "!addpoints"}, function (client, args)
    if not client.HasPermission(ClientPermissions.All) then
        Traitormod.SendMessage(client, "У вас нет прав на добавление очков.")
        return
    end
    
    if #args < 2 then
        Traitormod.SendMessage(client, "Неправильное количество аргументов. использование: !addpoint \"Имя клиента\" 500")

        return true
    end

    local name = table.remove(args, 1)
    local amount = tonumber(table.remove(args, 1))

    if amount == nil or amount ~= amount then
        Traitormod.SendMessage(client, "Недопустимое значение числа.")
        return true
    end

    local found = Traitormod.FindClient(name)

    if found == nil then
        Traitormod.SendMessage(client, "Не удалось найти клиента с именем / steamID " .. name)
        return true
    end

    Traitormod.AddData(found, "Points", amount)

    Traitormod.SendMessage(client, string.format(Traitormod.Language.PointsAwarded, amount), "InfoFrameTabButton.Mission")

    local msg = string.format("Администратор добавил %s очков к %s.", amount, Traitormod.ClientLogName(found))
    Traitormod.SendMessageEveryone(msg)
    msg = Traitormod.ClientLogName(client) .. ": " .. msg
    Traitormod.Log(msg)

    return true
end)

Traitormod.AddCommand({"!addlife", "!addlive", "!addlifes", "!addlives"}, function (client, args)
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return end

    if #args < 1 then
        Traitormod.SendMessage(client, "Неправильное количество аргументов. использование: !addlife \"Имя клиента\" 1")

        return true
    end

    local name = table.remove(args, 1)

    local amount = 1
    if #args > 0 then
        amount = tonumber(table.remove(args, 1))
    end

    if amount == nil or amount ~= amount then
        Traitormod.SendMessage(client, "Недопустимое значение числа.")
        return true
    end

    local gainLifeClients = {}
    if string.lower(name) == "all" then
        gainLifeClients = Client.ClientList
    else
        local found = Traitormod.FindClient(name)

        if found == nil then
            Traitormod.SendMessage(client, "Не удалось найти клиента с именем / steamID " .. name)
            return true
        end
        table.insert(gainLifeClients, found)
    end

    for lifeClient in gainLifeClients do
        local lifeMsg, lifeIcon = Traitormod.AdjustLives(lifeClient, amount)
        local msg = string.format("Администратор добавил %s жизней к %s"., amount, Traitormod.ClientLogName(lifeClient))

        if lifeMsg then
            Traitormod.SendMessage(lifeClient, lifeMsg, lifeIcon)
            Traitormod.SendMessageEveryone(msg)
        else
            Game.SendDirectChatMessage("", Traitormod.ClientLogName(lifeClient) .. " уже имеет максимальное количество жизней.", nil, Traitormod.Config.Error, client)
        end
    end

    return true
end)

Traitormod.AddCommand("!revive", function (client, args)
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return end

    local reviveClient = client

    if #args > 0 then
        -- if client name is given, revive related character
        local name = table.remove(args, 1)
        -- find character by client name
        for player in Client.ClientList do
            if player.Name == name or player.SteamID == name then
                reviveClient = player
            end
        end
    end

    if reviveClient.Character and reviveClient.Character.IsDead then
        reviveClient.Character.Revive()
        reviveClient.SetClientCharacter(reviveClient.Character);
        local lifeMsg, lifeIcon = Traitormod.AdjustLives(reviveClient, 1)

        if lifeMsg then
            Traitormod.SendMessage(reviveClient, lifeMsg, lifeIcon)
        end

        Game.SendDirectChatMessage("", "Персонаж " .. Traitormod.ClientLogName(reviveClient) .. " возрождается и возвращается 1 жизнь.", nil, ChatMessageType.Error, client)
        Traitormod.SendMessageEveryone(string.format("Администратор возрождил %s", Traitormod.ClientLogName(reviveClient)))

    elseif reviveClient.Character then
        Game.SendDirectChatMessage("", "Персонаж " .. Traitormod.ClientLogName(reviveClient) .. " не мертв.", nil, ChatMessageType.Error, client)
    else
        Game.SendDirectChatMessage("", "Персонаж " .. Traitormod.ClientLogName(reviveClient) .. " не найден.", nil, ChatMessageType.Error, client)
    end

    return true
end)

Traitormod.AddCommand("!ongoingevents", function (client, args)
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return end

    local text = "Текущие события: "
    for key, value in pairs(Traitormod.RoundEvents.OnGoingEvents) do
        text = text .. "\"" .. value.Name .. "\" "
    end

    Traitormod.SendMessage(client, text)

    return true
end)

Traitormod.AddCommand("!triggerevent", function (client, args)
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return end

    if #args < 1 then
        Traitormod.SendMessage(client, "Использование: !triggerevent <имя события>")
        return true
    end

    local event = nil
    for _, value in pairs(Traitormod.RoundEvents.EventConfigs.Events) do
        if value.Name == args[1] then
            event = value
        end
    end

    if event == nil then
        Traitormod.SendMessage(client, "Событие " .. args[1] .. " doesnt exist.")
        return true
    end

    Traitormod.RoundEvents.TriggerEvent(event.Name)
    Traitormod.SendMessage(client, "Запущенно событие " .. event.Name)

    return true
end)


local preventSpam = {}
Traitormod.AddCommand({"!droppoints", "!droppoint", "!dropoint", "!dropoints"}, function (client, args)
    if preventSpam[client] ~= nil and Timer.GetTime() < preventSpam[client] then
        Traitormod.SendMessage(client, "Пожалуйста, подождите немного, прежде чем снова использовать эту команду.")
        return true
    end

    if client.Character == nil or client.Character.IsDead or client.Character.Inventory == nil then
        Traitormod.SendMessage(client, "Вы должны быть живы, чтобы использовать эту команду.")
        return true
    end

    if #args < 1 then
        Traitormod.SendMessage(client, "Использование:  !droppoints количество")
        return true
    end

    local amount = tonumber(args[1])

    if amount == nil or amount ~= amount or amount < 100 or amount > 100000 then
        Traitormod.SendMessage(client, "Пожалуйста, укажите действительное число в диапазоне от 100 до 100000.")
        return true
    end

    local availablePoints = Traitormod.GetData(client, "Points") or 0

    if amount > availablePoints then
        Traitormod.SendMessage(client, "У вас недостаточно очков для сброса.")
        return true
    end

    Traitormod.SpawnPointItem(client.Character.Inventory, tonumber(amount))
    Traitormod.SetData(client, "Points", availablePoints - amount)

    preventSpam[client] = Timer.GetTime() + 5

    return true
end)