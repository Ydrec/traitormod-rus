local category = {}

category.Name = "Другое"

category.Products = {
    {
        Name = "Фрагмент панциря молоха",
        Price = 340,
        Limit = 1,
        Items = {"shellshield"}
    },

    {
        Name = "Одноразовый водолазный скафандр",
        Price = 400,
        Limit = 1,
        Items = {"respawndivingsuit"}
    },

    {
        Name = "Водолазная маска",
        Price = 280,
        Limit = 1,
        Items = {"divingmask"}
    },

    {
        Name = "Велосипедный гудок",
        Price = 350,
        Limit = 10,
        Items = {"bikehorn"}
    },

    {
        Name = "Гитара",
        Price = 50,
        Limit = 2,
        Items = {"guitar"}
    },

    {
        Name = "Губная гармошка",
        Price = 50,
        Limit = 2,
        Items = {"harmonica"}
    },

    {
        Name = "Аккордеон",
        Price = 50,
        Limit = 2,
        Items = {"accordion"}
    },

    {
        Name = "Жетон с именем питомнца",
        Price = 30,
        Limit = 5,
        Items = {"petnametag"}
    },

    {
        Name = "Рандомное яйцо",
        Price = 50,
        Limit = 5,
        Items = {"smallmudraptoregg", "tigerthresheregg", "crawleregg", "peanutegg", "psilotoadegg", "orangeboyegg", "balloonegg"},
        ItemRandom = true
    },

    {
        Name = "Бот Ассистент",
        Price = 400,
        Limit = 5,
        Action = function (client, product, items)
            local info = CharacterInfo(Identifier("human"))
            info.Job = Job(JobPrefab.Get("assistant"))
            local character = Character.Create(info, client.Character.WorldPosition, info.Name, 0, false, true)
            character.TeamID = CharacterTeamType.Team1
            character.GiveJobItems(nil)
        end
    },
}

return category