local category = {}

category.Name = "Экспериментальные"

category.Products = {
    {
        Name = "Дверь",
        Price = 400,
        Limit = 4,
        Items = {
            {Identifier = "door", IsInstallation = true}
        }
    },

    {
        Name = "Люк",
        Price = 400,
        Limit = 4,
        Items = {
            {Identifier = "hatch", IsInstallation = true}
        }
    },

    {
        Name = "Шкаф для хранения припасов",
        Price = 100,
        Limit = 6,
        Items = {
            {Identifier = "suppliescabinet", IsInstallation = true}
        }
    },

    {
        Name = "Генератор кислорода",
        Price = 200,
        Limit = 6,
        Items = {
            {Identifier = "shuttleoxygenerator", IsInstallation = true}
        }
    },

    {
        Name = "Фабрикатор",
        Price = 230,
        Limit = 4,
        Items = {
            {Identifier = "fabricator", IsInstallation = true}
        }
    },

    {
        Name = "Деконструктор",
        Price = 235,
        Limit = 4,
        Items = {
            {Identifier = "deconstructor", IsInstallation = true}
        }
    },

    {
        Name = "Медицинский фабрикатор",
        Price = 300,
        Limit = 4,
        Items = {
            {Identifier = "medicalfabricator", IsInstallation = true}
        }
    },

    {
        Name = "Исследовательская станция",
        Price = 290,
        Limit = 4,
        Items = {
            {Identifier = "op_researchterminal", IsInstallation = true}
        }
    },

    {
        Name = "Распределительная коробка",
        Price = 180,
        Limit = 8,
        Items = {
            {Identifier = "junctionbox", IsInstallation = true}
        }
    },

    {
        Name = "Аккумулятор",
        Price = 300,
        Limit = 6,
        Items = {
            {Identifier = "battery", IsInstallation = true}
        }
    },

    {
        Name = "Суперконденсатор",
        Price = 300,
        Limit = 4,
        Items = {
            {Identifier = "supercapacitor", IsInstallation = true}
        }
    },

    {
        Name = "Двигатель шаттла",
        Price = 400,
        Limit = 3,
        Items = {
            {Identifier = "shuttleengine", IsInstallation = true}
        }
    },

    {
        Name = "Небольшой насос",
        Price = 300,
        Limit = 3,
        Items = {
            {Identifier = "smallpump", IsInstallation = true}
        }
    },

    {
        Name = "Ядерный реактор",
        Price = 1500,
        Limit = 1,
        Items = {
            {Identifier = "reactor1", IsInstallation = true}
        }
    },

    {
        Name = "Навигационный терминал",
        Price = 370,
        Limit = 2,
        Items = {
            {Identifier = "navterminal", IsInstallation = true}
        }
    },

    {
        Name = "Камера",
        Price = 110,
        Limit = 5,
        Items = {
            {Identifier = "camera", IsInstallation = true}
        }
    },

    {
        Name = "Перископ",
        Price = 180,
        Limit = 5,
        Items = {
            {Identifier = "periscope", IsInstallation = true}
        }
    },

    {
        Name = "Лампа",
        Price = 50,
        Limit = 5,
        Items = {
            {Identifier = "lamp", IsInstallation = true}
        },
        Action = function (client, product, items)
            for key, value in pairs(items) do
                value.GetComponentString("LightComponent").IsOn = true
            end
        end
    },

    {
        Name = "Кресло",
        Price = 25,
        Limit = 5,
        Items = {
            {Identifier = "opdeco_officechair", IsInstallation = true}
        },
    },

    {
        Name = "Двухъярусная кровать",
        Price = 50,
        Limit = 5,
        Items = {
            {Identifier = "opdeco_bunkbeds", IsInstallation = true}
        },
    },

    {
        Name = "Провод",
        Price = 40,
        Limit = 8,
        Items = {
            {Identifier = "wire"}
        },
    },
}

return category