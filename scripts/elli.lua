local Elli = File:extend()

function Elli:new(text)
    Elli.super.new(self, "house")
    
    if Events.movedAnn then
        Art.new(self, "room3")
    elseif Events.postLament then
        Art.new(self, "room2_empty")
    else
        Art.new(self, "room2")
    end

    if Events.movedAnn then
        if text then
            self:setText(text)
        else
            self:setText([["Привет, [username]," сказала старушка. "Еще раз спасибо, что помогли мне переехать."]])
            self:setOptions({
                {
                    text = [["У тебя есть еще один ключ?"]],
                    condition = function () return Events.sawSecondGate end,
                    response = [[Еще один ключ? Боюсь, что нет. Но я уверена, что при некотором воображении один ключ-это все, что вам нужно."]],
                    remove = true
                }
            })
        end
    else
        if Events.postLament then
            self:setText([[[username] вошла в дом. Он пуст.]])
            self:setOptions({
                {
                    text = [["Кто-нибудь дома?"]],
                    default = true,
                    func = F(self, "checkRoom")
                }
            })
        elseif Events.bellRang then
            self:setText([[Когда [username] вошла в дом Элли явно запаниковала. "Что ты делаешь?! Беги! Беги так быстро, как только можешь."]])
            self:setOptions({
                {
                    text = [["Почему?"]],
                    response = [["Почему?! Потому что дракон! Он убьет нас всех!"]],
                    remove = true
                },
                {
                    text = [["А ты?"]],
                    response = [["Я уеду, как только соберу вещи. А теперь иди!"]],
                    remove = true
                }
            })
        else
            if text then
                self:setText(text)
            else
                self:setText([["О, привет [username]. Чем могу служить?", спросила Элли. Она была хорошей подругой с матерью [username].]])
            end

            self:setOptions({
                {
                    text = [["Могу я вам чем-нибудь помочь?"]],
                    func = F(self, "asking"),
                    condition = function () return not Events.cleanedWindow end
                },
                {
                    text = [["Вам нужна новая одежда?"]],
                    response = [["Нет, спасибо, дорогая. Моя одежда в порядке."]],
                    remove = true
                }
            })

            self:setOnItems({
            {
                request = "pantsEdbur",
                response = [["Прости, дорогая, но мне кажется, ты путаешь меня с кем-то другим. Это уж точно не мои штаны."]]
            }})
        end
    end
end


function Elli:asking()
    Art.new(self, "elli")
    self:setText([["Ну что ж, я рада, что вы спросили! Видите ли, я убиралась в доме, но слишком устала, чтобы мыть это последнее окно. Не могли бы вы сделать это за меня?"]])
    self:setOptions(
    {
        {
            text = [["Конечно."]],
            func = F(self, "window")
        },
        {
            text = [["Простите, но не сейчас."]],
            func = F(self, "new")
        }
    })
end


function Elli:window()
    Art.new(self, "windows")
    self:setText([["Замечательно! Ладно, это очень просто. Все, что вам нужно сделать, это удалить немного грязи. Убедитесь, что окно слева выглядит так же, как и окно справа. И если вы сделаете большую ошибку, вы всегда можете отменить через Ctrl + Z."]])
    self:setOptions({
        {
            text = [["Готово!"]],
            default = true,
            func = F(self, "checkWindows")
        },
        {
            text = [["Я передумала."]],
            func = F(self, "new", "Ну ладно. В любом случае спасибо.")
        }
    })
end

function Elli:checkWindows()
    local failed = false
    local i = 0
    for line in (self.rContent .. "\n"):gmatch("(.-)\n") do
        i = i + 1
        if i > 17 and i < 28 then
			if  (i == 18 and not line:find("|       | |       |        |       | |       |", 1, true)) or
				(i == 19 and not line:find("|       | |       |        |       | |       |", 1, true)) or
				(i == 20 and not line:find("|       | |       |        |       | |       |", 1, true)) or
				(i == 21 and not line:find("|_______| |_______|        |_______| |_______|", 1, true)) or
				(i == 22 and not line:find("|_______   _______|        |_______   _______|", 1, true)) or
				(i == 23 and not line:find("|       | |       |        |       | |       |", 1, true)) or
				(i == 24 and not line:find("|       | |       |        |       | |       |", 1, true)) or
				(i == 25 and not line:find("|       | |       |        |       | |       |", 1, true)) or
				(i == 26 and not line:find("|_______|_|_______|        |_______|_|_______|", 1, true))
			then
				failed = true
				break
			end
        end
    end

    if failed then
        self:setText([["О, ну, нет, я думаю, ты пропустила одно место. Попробуй снова."]])
    else
        Events.cleanedWindow = true
        self:setText([["Ах, большое вам спасибо! Вот, я дам тебе 10 золотых."]])
        self.player.gold = self.player.gold + 10
        Art.new(self, "elli")
        self:setOptions({
            {
                text = [["Пожалуйста."]],
                func =  F(self, "new", [["Пожалуйста," сказала [username].]])
            }
        })
        self:setOptions({
            {
                text = [["Без проблем."]],
                func =  F(self, "new", [["Без проблем," сказала [username].]])
            }
        })
    end
end

function Elli:checkRoom()
    self:setText([["Есть кто дома?" крикнула [username]. From the lack of response [he] got [his] answer.]])
    print(Events.postLament, Events.metAnn, Events.movedAnn)
    if Events.postLament and Events.metAnn and not Events.movedAnn then
        self.rContent = love.filesystem.read(self.file)
        print(self.rContent:find("|_____|||_.` `*                       `. |||", 1, true))
        if self.rContent:find("|_____|||_.` `*                       `. |||", 1, true) then
            print("?????")
            Art.new(self, "room3")
            self:setText([[Старуха выглянула наружу и увидела, что она в Восточном Городе. "Замечательно! Спасибо, дорогая." Она выхватила ключ из шкафа и передала его [username], вместе с двадцатью золотыми. "Удачи в победе над моим дедушкой", - сказала она с улыбкой.]])
            self.player.gold = self.player.gold + 20
            Events.movedAnn = true
            local t = lume.clone(Items["castleGateKey"])
            t.tag = "castleGateKey"
            table.insert(self.player.inventory, t)

            self:setOptions({
                {
                    text = [["Спасибо."]],
                    func = F(self, "new", [["Спасибо." сказала [username], чувствуя себя неуютно.]]),
                    remove = true
                }
            })
        end
    end
end

return Elli