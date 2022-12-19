local category = {}

category.Name = "Техобслуживание"

category.Products = {
    {
        Name = "Отвертка",
        Price = 90,
        Limit = 1,
        Items = {"screwdriver"}
    },

    {
        Name = "Гаечный ключ",
        Price = 90,
        Limit = 1,
        Items = {"wrench"}
    },

    {
        Name = "Сварочный аппарат",
        Price = 160,
        Limit = 4,
        Items = {"weldingtool", "weldingfueltank"}
    },

    {
        Name = "Пенопластовая граната",
        Price = 190,
        Limit = 4,
        Items = {"fixfoamgrenade", "fixfoamgrenade"}
    },

    {
        Name = "Ремонтный комплект",
        Price = 140,
        Limit = 4,
        Items = {"repairpack", "repairpack", "repairpack", "repairpack"}
    },

    {
        Name = "Топливный стержень низкого качества",
        Price = 260,
        Limit = 10,

        Items = {{Identifier = "fuelrod", Condition = 9}},
    },
}

return category