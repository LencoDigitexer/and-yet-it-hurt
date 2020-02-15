local ReadMe = File:extend()

function ReadMe:new()
    ReadMe.super.new(self, "readme")
    if self.isOpen then
        Art.new(self, "logo")
    else
        Art.new(self, "readme_noadmin")
        return
    end

    if SAVE.exists then
        self:setText([[Эй, добро пожаловать сново. Я вижу, ты уже играл в эту игру раньше. Хотите продолжить с того места, на котором остановились?]])
        self:setOptions({
            {
                text = "Да, загрузи сохранение.",
                func = F(self, "load")
            },
            {
                text = "Нет, давай начнем сначала.",
                func = F(self, "tips")
            },
        })
    else
        self:setText([[Как играть: внизу вы увидите варианты. Вы можете выбрать опцию, заполнив [] одним или несколькими символами. 
Например: [s] - Я понимаю, как работают опции. 
После заполнения вашего выбора вы можете сохранить файл с помощью Ctrl + S. попробуйте!]])
        self:setOptions({
            {
                text = "Я понимаю, как выбрать тот или иной вариант.",
                func = F(self, "tips")
            }
        })
    end
end


function ReadMe:tips()
    self:setText([[Хорошо! Прежде чем мы начнем игру, у меня есть несколько советов для вас.
С помощью клавиши Windows + клавиши со стрелками влево/вправо вы можете поместить окна красиво рядом друг с другом.
И знаете ли вы, что вы можете изменять масштаб с помощью Ctrl + колесо прокрутки?]])
    self:setOptions({
        {
            text = "Спасибо за советы.",
            func = F(self, "continue", 1)
        },
        {
            text = "Я этого не знал!",
            func = F(self, "continue", 2)
        },
        {
            text = "Я уже знал это!",
            func = F(self, "continue", 3)
        }
    })
end

function ReadMe:continue(n)
    local start = ""
    if n == 1 then
        start = "Всегда пожалуйста!"
    elseif n == 2 then
        start = "Ну вот теперь ты знаешь!"
    elseif n == 3 then
        start = "Очень хорошо!"
    end

    self:setText(start .. [[ Вы почти готовы отправиться в приключение. Почти.
Во-первых, заполните скобки ([]) именем вашего персонажа. Имя не может быть длиннее 15 символов.
Например: [Иван] или [Мария] - так зовут моего персонажа.]])

    if n == 4 then
        self:setText([[Вы передумали насчет названия? Это нормально.
Заполните скобки ([]) именем вашего персонажа. Имя не может быть длиннее 15 символов.
Например: [Иван] или [Мария] - так зовут моего персонажа.]])
    end

	self:setOptions({
        {
            text = "Это имя моего персонажа",
            func = F(self, "setName")
        },
        {
            text = "Я никак не могу определиться с именем.",
            func = F(self, "setName", true)
        }
    })
end

function ReadMe:setName(pick)
    print(pick)
    local name
    if pick then
        local names = {"Арахна", "Лилия", "Бэтти", "Орфей", "Миднайт", "Анубис"}
        name = lume.randomchoice(names)
        self:setText("Ладно, тогда я сам выберу... " .. name .. "! Теперь, как мы должны говорить об этом персонаже?")
    else
        local match = self.rContent:sub(1000, #self.rContent):match("%[([^%]]+)%]%s%-%s" .. Utils.litString("Это имя моего персонажа."))

        if match then
            if #match > 15 then
                self:setText("Это имя слишком длинное! Пожалуйста, не используйте более 15 символов.")
                return
            end
            self:setText([[Итак, имя вашего персонажа ]] .. match .. [[? Мне нравится это!
Как мы должны говорить об этом персонаже?]])
            name = match
        else
            return
        end
    end

    Player.name = name

    self:setOptions({
        {
            text = "he/him/his",
            func = F(self, "pronouns", "he")
        },
        {
            text = "she/her/her",
            func = F(self, "pronouns", "she")
        },
        {
            text = "they/their/them",
            func = F(self, "pronouns", "they")
        },
        {
            text = "Я хочу сменить имя.",
            func = F(self, "continue", 4)
        }
    })
end

function ReadMe:pronouns(p)
    Player.pronoun = p

    self:setText([[Ура. Давай начнем.И все же было больно.  
Эта история о [username], ребёнке из Восточного Города, который жил счастливой и мирной жизнью с его родителями.
(Откройте один из файлов в папке.)]])
    self:setOptions({})

    self.deleteOnClose = true
    Game:addFile(require("edbur")())
    Game:addFile(require("home")())
    Game:addFile(require("elli")())
    Game:addFile(require("grocery_store")())
end

function ReadMe:load()
    print(SAVE.Events)
    Events = SAVE.Events
    print(Events)
    Player.name = SAVE.name
    Player.pronoun = SAVE.pronoun
    Player.inventory = SAVE.inventory
    Player.gold = SAVE.gold
    local w = 0
    for i,v in ipairs(Player.inventory) do
        if v.tag == "nightblood" then
            self.player.weapon = v
            w = 3
        elseif w < 3 and v.tag == "sword" then
            self.player.weapon = v
            w = 2
        elseif w < 2 and v.tag == "dagger" then
            self.player.weapon = v
            w = 1
        end
    end
    self:setText("Очень хорошо. Давайте продолжим наше приключение" .. Player.name .. ".")
    self:setOptions({})
    self.deleteOnClose = true
    Game:addFile(require("edbur_post_lament")(nil, 9))
end

return ReadMe