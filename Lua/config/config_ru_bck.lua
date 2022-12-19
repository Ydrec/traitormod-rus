local config = {}
config.DebugLogs = true

----- USER FEEDBACK -----
config.Language = "Russian"
config.SendWelcomeMessage = true
config.ChatMessageType = ChatMessageType.Private    -- Error = red | Private = green | Dead = blue | Radio = yellow

----- GAMEPLAY -----
config.Codewords = {
    "корпус", "табак", "ерунда", "рыба", "клоун", "навигатор", "быстро", "возможность",
	"таламус", "голодный", "вода", "вид", "ренегат", "злой", "зеленый", "тонуть", "резина",
	"маска", "сладкий", "лед", "Харибда", "культ", "секрет", "частота",
	"шелуха", "ржавчина", "руины", "красный", "лодка", "кошки", "крысы", "взрыв",
	"шина", "ствол", "оружие", "костоломы", "груз", "метод", "обезьяна"
}

config.AmountCodeWords = 2

config.OptionalTraitors = true        -- игроки могут использовать !toggletraitor
config.TraitorBroadcast = true      -- предатели могут сообщать другим предателям, используя !tc
config.TraitorBroadcastHearable = false      -- если true, !tc будет слышен поблизости через локальный чат
config.TraitorDm = false            -- предатели могут отправлять прямые сообщения другим игрокам, используя !tdm

config.OptionalTraitors = true        -- игроки могут использовать !toggletraitor
config.RagdollOnDisconnect = false
config.EnableControlHusk = false     -- ЭКСПЕРИМЕНТАЛЬНО: возможность управлять хаском после смерти

-- Это переопределяет шаттл респауна в игре и использует его в качестве инжектора подводных лодок, чтобы легко спавнить подводные лодки в игре. Респаун будет работать, как и ожидается, но файл шаттла с подводными лодками должен быть добавлен сюда вручную.
-- Примечание: Если эта функция отключена, traitormod отключит все функции, связанные с спавном подводных лодок.
config.OverrideRespawnSubmarine = false
config.RespawnSubmarineFile = "Content/Submarines/Selkie.sub"

----- POINTS + LIVES -----
config.PermanentPoints = true      -- устанавливает, будут ли очки и жизни храниться в файле и загружаться из него
config.PermanentStatistics = true  -- устанавливает, следует ли хранить статистику в файле и загружать ее из файла
config.MaxLives = 5
config.MinRoundTimeToLooseLives = 180
config.RespawnedPlayersDontLooseLives = true
config.MaxExperienceFromPoints = 50000     -- если не ноль, то это количество - максимальный опыт, получаемый игроками за накопленные очки (30k = lvl 10 | 38400 = lvl 12).
config.RemoveSkillBooks = true

config.FreeExperience = 50         -- временный опыт, получаемый каждые ExperienceTimer секунд
config.ExperienceTimer = 120

config.DistanceToEndOutpostRequired = 5000
config.PointsGainedFromCrewMissionsCompleted = 1000
config.PointsGainedFromHandcuffedTraitors = 1000
config.LivesGainedFromCrewMissionsCompleted = 1
config.PointsGainedFromSkill = {
    medical = 30,
    weapons = 20,
    mechanical = 19,
    electrical = 19,
    helm = 9,
}

config.PointsLostAfterNoLives = function (x)
    return x * 0.75
end

config.AmountExperienceWithPoints = function (x)
    return x * 0.5
end

-- Придавать вес в зависимости от логарифма опыта
-- 100 опыта = 4 шанса
-- 1000 опыта = 6 шансов
config.AmountWeightWithPoints = function (x)
    return math.log(x + 10) -- добавьте 1, потому что логарифм 0 равен -бесконечности
end

----- OBJECTIVES -----
config.ObjectiveConfig = {
    Assassinate = {
        Enabled = true,
        AmountPoints = 600,
    },

    Survive = {
        Enabled = true,
        AlwaysActive = true,
        AmountPoints = 500,
        AmountLives = 1,
    },

    StealCaptainID = {
        Enabled = true,
        AmountPoints = 1300,
    },

    Kidnap = {
        Enabled = true,
        AmountPoints = 2500,
        Seconds = 100,
    },

    PoisonCaptain = {
        Enabled = true,
        AmountPoints = 1600,
    },
}

----- GAMEMODE -----
config.GamemodeConfig = {
    Assassination = {
        Enabled = true,
        WeightChance = 50,
        EndOnComplete = true,           -- завершить раунд, когда не останется ни одной цели для убийства.
        EndGameDelaySeconds = 5,

        StartDelayMin = 120,
        StartDelayMax = 150,
        NextDelayMin = 30,
        NextDelayMax = 60,

        SelectBotsAsTargets = true,
        SelectPiratesAsTargets = false,
        SelectUniqueTargets = true,     -- каждая цель предателя может быть выбрана только один раз для каждого предателя (респаун + ложь -> нет конца)
        PointsPerAssassination = 100,

        -- Codewords, Names, None
        TraitorMethodCommunication = "Names",

        MinSubObjectives = 1,
        MaxSubObjectives = 3,
        SubObjectives = {"StealCaptainID", "Survive", "Kidnap", "PoisonCaptain"},

        AmountTraitors = function (amountPlayers)
            config.TestMode = false
            if amountPlayers > 12 then return 3 end
            if amountPlayers > 7 then return 2 end            
            if amountPlayers > 3 then return 1 end
            if amountPlayers == 1 then 
                Traitormod.SendMessageEveryone("Режим тестирования 1 игрока - нет возможности набрать или потерять очки") 
                config.TestMode = true
                return 1
            end
            print("Недостаточно игроков для запуска режима предателя.")
            return 0
        end,

        TraitorFilter = function (client)
            if not client.Character.IsHuman then return false end
            if client.Character.HasJob("captain") then return false end
            if client.Character.HasJob("securityofficer") then return false end

            return true
        end
    }
}

----- EVENTS -----
config.RandomEventConfig = {
    Enabled = true,

    Events = {
        dofile(Traitormod.Path .. "/Lua/config/randomevents/communicationsoffline.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/superballastflora.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/maintenancetoolsdelivery.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/medicaldelivery.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/hiddenpirate.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/electricalfixdischarge.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/wreckpirate.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/beaconpirate.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/abysshelp.lua"),
        dofile(Traitormod.Path .. "/Lua/config/randomevents/lightsoff.lua"),
    }
}

config.PointShopConfig = {
    Enabled = true,
    DeathTimeoutTime = 120,
    ItemCategories = {
        dofile(Traitormod.Path .. "/Lua/config/pointshop/traitor.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/security.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/maintenance.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/materials.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/medical.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/ores.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/other.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/experimental.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/deathspawn.lua"),
        dofile(Traitormod.Path .. "/Lua/config/pointshop/ships.lua"),
    }
}

return config