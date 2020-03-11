local Troll = File:extend()

function Troll:new()
	Troll.super.new(self, "dragonhill")
    -- self:init()
	Art.new(self, "troll")
	self.anim:add("may", 3)
    self.anim:add("none", 1)
	self.anim:add("not", 2)

    self:setText([[Когда [username] шла вверх по холму, она столкнулась с троллем, блокирующим мост. "Вы НЕ МОЖЕТЕ пройти!" - сказал тролль.]])
    self:setOptions({
        {
            text = [["Могу я пройти?"]],
            func = F(self, "ask"),
            default = true
        },
        {
            text = [["А почему бы и нет?"]],
            response = "Because that is what I said!",
            remove = true
        },
        {
            text = "Назад.",
            func = F(self, "back")
        }
    })

end

function Troll:ask()
    self.rContent = love.filesystem.read(self.file)
    if self.rContent:find("   |     | # /``-.    | Вы можете пройти!", 1, true) or self.rContent:find("   |     | # /``-.    | Вы можете  пройти!", 1, true) then
        self:setText([["Разве ты не слышал, что я сказал? Вы можете пройти! Подожди, нет, я не это хотел сказать!"]])
        self.anim:set("may")
        self:setOptions({
            {
                text = [["Спасибо!"]],
                response = [["Спасибо!" сказала [username], и она пересекла мост.]],
                options = {
                    {
                        text = "Продолжать идти.",
                        func = F(self, "cross")
                    }
                }
            }
        })
    else
        self:setText([["Разве ты не слышал, что я сказал? Вы не можете пройти!"]])
        self:setOptions({
            {
                text = [["Могу я пройти?"]],
                func = F(self, "ask")
            },
            {
                text = [["А почему бы и нет?"]],
                response = "Because that is what I said!"
            },
            {
                text = "Назад."
            }
        })
    end
end


function Troll:cross()
    self.dead = true
    Game:replaceFile("dragonhill", require("dragonhill")())
end

function Troll:back()
    self:setText("[username] решила вернуться пешком.")
	self.deleteOnClose = true
	self:setOptions({})
	Game:addFile(require("westown_gate")())
	Game:addFile(require("dragonhill_gate")())
	Game:addFile(require("edbur_post_lament")())
	Game:addFile(require("elli")())
end

return Troll