local language = {}
language.Name = "Russian"

language.Help = "\n!help - показывает это сообщение помощи\n!helptraitor - показывает все команды предателя\n!helpadmin - показывает все команды администратора\n!traitor - показывает информацию о предателе\n!pointshop - открывает магазин очков\n!points - показывает ваши очки и жизни\n!alive - показывает список живых игроков (только во время смерти)\n!suicide - убивает вашего персонажа\n!version - показывает текущую версию мода traitormod"
language.HelpTraitor = "\n!toggletraitor - переключает, может ли игрок быть выбран предателем\n!tc [msg] - посылает сообщение всем предателям\n!tdm [Имя] [msg] - посылает анонимное сообщение данному игроку"
language.HelpAdmin = "\n!traitoralive - проверить, все ли предатели умерли\n!roundinfo - показать информацию о раунде (спойлер!)\n!allpoints - показывает количество очков у всех подключенных клиентов\n!addpoint [Client] [+/-Amount] - добавить очки клиенту\n!addlife [Client] [+/-Amount] - добавить жизнь(и) клиенту\n!revive [Client] - оживить данного персонажа-клиента"

language.NoTraitor = "Вы не предатель."
language.TraitorOn = "Вы можете быть выбраны предателем."
language.TraitorOff = "Вы не можете быть выбраны предателем.\n\nИспользуйте !toggletraitor, чтобы изменить это."
language.RoundNotStarted = "Раунд не начался."

language.AllTraitorsDead = "Все предатели мертвы!"
language.TraitorsAlive = "Ещё есть живые предатели."

language.Alive = "Живой"
language.Dead = "Мертвый"

language.KilledByTraitor = "Ваша смерть могла быть вызвана предателем, выполняющим секретное задание."

language.TraitorWelcome = "Вы предатель!"
language.TraitorDeath = "Вы не справились с заданием. В результате миссия была отменена, и вы вернетесь как часть команды.\n\nВы больше не предатель, так что играйте хорошо!"
language.TraitorDirectMessage = "Вы получили сообщение от предателя:\n"
language.TraitorBroadcast = "[Предатель %s]: %s"

language.AgentNoticeCodewords = "На этой подводной лодке есть и другие агенты. Вы не знаете их имен, но у вас есть способ общения. Используйте кодовые слова для приветствия агента и кодовый ответ для ответа. Замаскируйте эти слова под обычную фразу, чтобы экипаж ничего не заподозрил."

language.AgentNoticeNoCodewords = "На этой подводной лодке есть и другие агенты. Вы знаете их имена, сотрудничайте с ними, так у вас будет больше шансов на успех."

language.AgentNoticeOnlyTraitor = "Вы единственный предатель на этом корабле, действуйте осторожно."

language.RoundSummary = "| Итоги раунда |"
language.Gamemode = "Режим игры: %s"
language.RandomEvents = "Случайные события: %s"
language.ObjectiveCompleted = "Задача выполнена: %s"

language.CrewWins = "Экипаж успешно выполнил свою миссию!"
language.TraitorHandcuffed = "Команда арестовала %s предателя(ей)!"
language.TraitorsWin = "Предателям удалось выполнить свои задачи!"

language.TraitorsRound = "Предатели раунда:"
language.NoTraitors = "Предателей нет."
language.TraitorAlive = "Вы выжили как предатель."

language.PointsInfo = "У вас %s очков и %s/%s жизней."
language.TraitorInfo = "Ваш шанс стать предателем составляет %s%%, по сравнению с остальными членами экипажа."

language.Points = " (%s Очков)"
language.Experience = " (%s XP)"

language.SkillsIncreased = "Хорошая работа по улучшению своих навыков."
language.PointsAwarded = "Вы получили %s очков."
language.PointsAwardedRound = "В этом раунде вы получили:\n%s очков"
language.ExperienceAwarded = "Вы получили %s XP."

language.LivesGained = "Вы получили %s. Теперь у вас %s/%s Жизней."
language.ALife = "одна жизнь"
language.Lives = " жизней"
language.Death = "Вы потеряли жизнь. У вас осталось % до потери очков."
language.NoLives = "Вы потеряли все свои жизни. В результате вы потеряли немного очков."
language.MaxLives = "Вы имеете максимальное количество жизней."

language.Codewords = "Кодовые слова: %s"
language.CodeResponses = "Кодовые ответы: %s"

language.OtherTraitors = "Все предатели: %s"

language.CommandTip = "(Введите !traitor в чате, чтобы показать это сообщение снова.)"
language.CommandNotActive = "Эта команда отключена."

language.Completed = " (Завершено)"

language.Objective = "Основные задачи:"
language.SubObjective = "Подцели (необязательные):"

language.NoObjectives = "Целей нет."
language.NoObjectivesYet = "Целей пока нет..."

language.ObjectiveAssassinate = "Убейте %s."

language.ObjectiveSurvive = "Убейте цели и выживите до конца смены."
language.ObjectiveStealCaptainID = "Украдите удостоверение капитана."
language.ObjectiveKidnap = "Наденьте наручники на %s на %s секунд"
language.ObjectivePoisonCaptain = "Отравите %s с помощью %s."
language.ObjectiveWreckGift = "Заполучите подарок"

language.ObjectiveText = "Убейте членов экипажа, чтобы выполнить свою миссию."

language.AssassinationNextTarget = "Не высовывайтесь до дальнейших указаний."
language.AssassinationNewObjective = "Ваша следующая цель для убийства - %s."
language.AssassinationEveryoneDead = "Хорошая работа, агент, вы сделали это!"

language.ItemsBought = "Товары, приобретенные в магазине"
language.CrewBoughtItem = "Игроки купили товары в магазине очков"
language.PointsGained = "Общее количество набранных очков"
language.PointsLost = "Общее количество потерянных очков"
language.Spawns = "Появившиеся человеческие персонажи"
language.Traitor = "Выбран предателем"
language.TraitorDeaths = "Погиб как предатель"
language.TraitorMainObjectives ="Основные цели успешны"
language.TraitorSubObjectives = "Подцели успешно выполнены"
language.CrewDeaths = "Смерти"
language.Rounds = "Общая статистика раунда"

return language