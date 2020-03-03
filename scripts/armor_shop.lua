local ArmorShop = File:extend()

function ArmorShop:new(text)
	ArmorShop.super.new(self, "armor shop")
    Art.new(self, "armor_shop")

    self.player:regainHealth()
    
    self.costs = {
        helmet = 50,
        breastplate = 20,
        shield = 40,
        gauntlets = 40
    }

    if not Events.hasBeenInArmorShopBefore then
        self:setText([[[username] вошла в оружейный магазин и увидела парня примерно её возраста, стоящего за прилавком. - "О, привет", - сказал парень.  "Добро пожаловать в нашу оружейную лавку. Мы продаем доспехи, я полагаю. Могу я вам чем-нибудь помочь, например, купить что-нибудь?"]])
    else
        self:setText([["О, привет", - сказал парень. "Добро пожаловать в наш магазин. Мы продаем доспехи, я полагаю. Хочешь что- нибудь купить?"]])
    end
    
    if text then
        self:setText([["Ох. Ну, видите ли, если у вас недостаточно золота, вы не можете его купить. Вот как это работает, я полагаю. Так что, извини."]])
    end

    self:setOptions({
        {
            text = [["Я бы хотела кое-что купить."]],
            response = [["Хорошо, хорошо, просто отметьте товар, который вы хотите купить. Но, пожалуйста, по очереди."]]
        },
        {
            text = [["Где твои родители?"]],
            response = [["Ну, моя мама сбежала давным-давно, а мой папа на небесах. Немного перебрал со своим "особым зельем", как он его называл."]],
        }
    })

end

function ArmorShop:onEdit()
    self.rContent = love.filesystem.read(self.file)
    local items = {
        "helmet",
        "breastplate",
        "shield",
        "gauntlets"
    }

    local str = "%[([^%]%s]+)%]%s%-%s"
    for i,v in ipairs(items) do
        if self.rContent:lower():find(str .. v) then
            if Events[v .. "Bought"] then
                if v == "gauntlets" then
                    self:setText([["Перчатки, верно. Дело в том, что у тебя уже есть перчатки. Так что , на самом деле , нет смысла покупать еще одну пару перчаток, я полагаю."]])
                else
                    self:setText([["Это ]] .. v .. [[, верно. Дело в том, что у тебя уже есть ]] .. v .. [[. Так что , на самом деле , нет смысла покупать еще ]] ..v .. [[, я полагаю."]])
                end
            else
                self:setText([["Это ]] .. v.. [[, верно. Стоимость:  ]] .. self.costs[v] .. [[ золотых. Так что, да, пожалуйста, дай мне ]] .. self.costs[v] ..  [[золотых, я полагаю.]])
                if self.player.gold < self.costs[v] then
                    self:setOptions({
                        {
                            text = [["Мне не хватает золота."]],
                            func = F(self, "new", [["Ох. Ну, видите ли, если у вас недостаточно золота, вы не можете его купить. Вот как это работает, я полагаю. Так что, извини."]])
                        }
                    })
                else
                    self:setOptions({
                        {
                            text = [[Дать ]] .. self.costs[v] .. [[ золотых.]] ,
                            response = [["Спасибо. Вы приобрели ]] .. v .. [[. Веселитесь, я полагаю."]],
                            item = v,
                            gold = -self.costs[v],
                            event = v .. "Bought",
                            func = F(self, "new", [["Спасибо. Вы приобрели ]] .. v .. [[. Веселитесь, я полагаю."]])
                        },
                        {
                            text = [["Я передумала."]],
                            func = F(self, "new", [["А. Ну, это нормально."]])
                        }
                    })
                end
            end
        end
    end

    ArmorShop.super.onEdit(self)
end

return ArmorShop