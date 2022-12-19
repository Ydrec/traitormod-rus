local category = {}

category.Name = "Медицина"

-- this is just so i don't need to type out all the 34 different unresearched genetic materials
local geneticMaterials = {}
for prefab in ItemPrefab.Prefabs do
    if string.find(prefab.Identifier.Value, "_unresearched") then
        table.insert(geneticMaterials, prefab.Identifier.Value)
    end
end

category.Products = {
    {
        Name = "Бинт",
        Price = 130,
        Limit = 4,
        Items = {"bandage", "bandage"}
    },

    {
        Name = "Опий",
        Price = 130,
        Limit = 3,
        Items = {"opium", "opium"}
    },

    {
        Name = "Физраствор",
        Price = 125,
        Limit = 2,
        Items = {"saline"}
    },

    {
        Name = "Этанол",
        Price = 80,
        Limit = 4,
        Items = {"ethanol"}
    },

    {
        Name = "Хлорин",
        Price = 70,
        Limit = 4,
        Items = {"chlorine"}
    },

    {
        Name = "Серная кислота",
        Price = 60,
        Limit = 4,
        Items = {"sulphuricacid"}
    },

    {
        Name = "Инопланетная кровь",
        Price = 105,
        Limit = 4,
        Items = {"alienblood"}
    },

    {
        Name = "Адреналиновая железа",
        Price = 60,
        Limit = 5,
        Items = {"adrenalinegland"}
    },

    {
        Name = "Водяной мак",
        Price = 70,
        Limit = 5,
        Items = {"aquaticpoppy"}
    },

    {
        Name = "Эластиновое растение",
        Price = 50,
        Limit = 5,
        Items = {"elastinplant"}
    },

    {
        Name = "Прядильное растение",
        Price = 60,
        Limit = 5,
        Items = {"fiberplant"}
    },

    {
        Name = "Морские дрожжи",
        Price = 65,
        Limit = 5,
        Items = {"yeastshroom"}
    },

    {
        Name = "Слизистые бактерии",
        Price = 80,
        Limit = 5,
        Items = {"slimebacteria"}
    },

    {
        Name = "Плавательный пузырь",
        Price = 250,
        Limit = 5,
        Items = {"swimbladder"}
    },

    {
        Name = "Набор для садоводства",
        Price = 100,
        Limit = 2,
        Items = {"raptorbaneseed", "creepingorangevineseed", "saltvineseed", "tobaccovineseed", "smallplanter", "fertilizer", "wateringcan"}
    },

    {
        Name = "Усовершенствованный сплайсер генов",
        Price = 1800,
        Limit = 2,
        Items = {"advancedgenesplicer"}
    },

    {
        Name = "Неисследованный генетический материал",
        Price = 250,
        Limit = 10,
        ItemRandom = true,
        Items = geneticMaterials
    },
}

return category