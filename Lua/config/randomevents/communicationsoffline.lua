local event = {}

-- Intense (интенсивность), может изменяться от 0 до 1, определяет, насколько интенсивным должен быть раунд, чтобы событие сработало, 0 означает, что раунд очень холодный и спокойный, 1 означает, что все, что могло пойти не так, пошло не так.
-- MinRoundTime, минимальное количество времени, которое должно пройти, чтобы событие могло быть запущено.
-- MaxRoundTime, то же самое, что и выше, но для максимального значения.
-- ChancePerMinute, каждую минуту бросается случайное число, чтобы проверить, должно ли сработать событие.


event.Enabled = true
event.Name = "CommunicationsOffline"
event.MinRoundTime = 10
event.MinIntensity = 0
event.MaxIntensity = 0.2
event.ChancePerMinute = 0.03
event.OnlyOncePerRound = true

event.AmountTime = 5 -- Communications are offline for 5 minutes


event.Start = function ()

    local text = "Что-то вмешивается во все наши системы связи. По оценкам, связь будет отключена как минимум на " .. event.AmountTime .. " минут."

    Traitormod.RoundEvents.SendEventMessage(text, "GameModeIcon.multiplayercampaign")

    for key, item in pairs(Item.ItemList) do
        if item ~= nil and item.Prefab.Identifier == "headset" then
            item.GetComponentString("WifiComponent").Range = 0;
        end
    end

    Hook.Add("item.created", "CommunicationsOffline.Item.Created", function (item)
        if item ~= nil and item.Prefab.Identifier == "headset" then
            item.GetComponentString("WifiComponent").Range = 10;
        end
    end)

    Timer.Wait(event.End, event.AmountTime * 57 * 1000)
end

event.End = function (isEndRound)
    Hook.Remove("item.created", "CommunicationsOffline.Item.Created")

    for key, item in pairs(Item.ItemList) do
        if item ~= nil and item.Prefab.Identifier == "headset" then
            item.GetComponentString("WifiComponent").Range = 35000;
        end
    end

    if not isEndRound then
        local text = "Communications are back online."

        Traitormod.RoundEvents.SendEventMessage(text, "GameModeIcon.multiplayercampaign")
    end
end

return event