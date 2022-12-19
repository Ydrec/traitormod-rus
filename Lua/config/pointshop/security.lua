local category = {}

category.Name = "Служба безопасности"
category.Decoration = "security"

category.CanAccess = function(client)
    return client.Character and not client.Character.IsDead and 
    (client.Character.HasJob("securityofficer") or client.Character.HasJob("captain"))
end

category.Products = {

    {
        Name = "Наручники",
        Price = 100,
        Limit = 5,
        IsLimitGlobal = false,
        Items = {"handcuffs"},
    },

    {
        Name = "Шоковая дубинка",
        Price = 200,
        Limit = 2,
        IsLimitGlobal = false,
        Items = {"stunbaton", "batterycell"},
    },

    {
        Name = "Электрошокер",
        Price = 500,
        Limit = 1,
        IsLimitGlobal = false,
        Items = {"stungun", "stungundart", "stungundart", "stungundart", "stungundart"},
    },

    {
        Name = "Дротик для электрошокера",
        Price = 100,
        Limit = 1,
        IsLimitGlobal = false,
        Items = {"stungundart", "stungundart", "stungundart", "stungundart"},
    },

    {
        Name = "Патроны для револьвера (x6)",
        Price = 250,
        Limit = 1,
        IsLimitGlobal = false,
        Items = {"revolverround", "revolverround","revolverround", "revolverround", "revolverround", "revolverround"},
    },

    {
        Name = "Магазин для SMG (x2)",
        Price = 350,
        Limit = 5,
        IsLimitGlobal = false,
        Items = {"smgmagazine", "smgmagazine"},
    },

    {
        Name = "Патроны для дробовика (x8)",
        Price = 300,
        Limit = 5,
        IsLimitGlobal = false,
        Items = {"shotgunshell", "shotgunshell", "shotgunshell", "shotgunshell", "shotgunshell", "shotgunshell", "shotgunshell", "shotgunshell"},
    },

    {
        Name = "Светошумовая граната",
        Price = 400,
        Limit = 3,
        IsLimitGlobal = false,
        Items = {"stungrenade"},
    },

    {
        Name = "Огнемет",
        Price = 800,
        Limit = 1,
        IsLimitGlobal = false,
        Items = {"flamer", "incendiumfueltank"},
    },

}

return category