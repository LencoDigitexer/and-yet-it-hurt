local Castle = File:extend()

function Castle:new(notfirst)
    Castle.super.new(self, "castle")
    if Events.skeletonKingDefeated then
        if type(notfirst) == "string" then
            self:setText(notfirst)
        end
        Art.new(self, "castle_no_castle")
        self:setOptions({
            {
                text = "Вернуться в Западный Город",
                func = F(self, "back")
            }
        })
    else
        Art.new(self, "castle")
        self.anim:add("door", 2)
        self.anim:add("unlocked", 3)
        self.anim:add("key", 4)
        self.anim:add("hill", 1)
        if not notfirst then
            self:setText("[username] увидела впереди замок.")
        end

        self:setOptions({
            {
                text = "Идти до замка",
                func = F(self, "door")
            },
            {
                text = "Вернуться в Западный Город.",
                func = F(self, "back")
            }
        })
    end
end

function Castle:door()
    Events.sawSecondGate = true
    self:setText("[username] стояла перед огромной дверью.")
    if Events.castleUnlocked then
        self.anim:set("unlocked")
        self:setOptions({
            {
                text = "Войти внутрь.",
                func = F(self, "inside")
            },
            {
                text = "Вернуться",
                func = F(self, "new", true)
            }
        })
    else
        self.anim:set("door")
        self:setOptions({
            {
                text = "Войти внутрь.",
                response = "[username] попыталась открыть дверь, но она была заперта."
            },
            {
                text = "Вернуться",
                func = F(self, "new", true)
            }
        })

		self:setOnItems({
		{
            request = "castleGateKey",
            func = F(self, "enter")
		}})
    end
end


function Castle:enter()
    local fail = true
    self.rContent = love.filesystem.read(self.file)
    if self.rContent:lower():find("||===||===||===||===| (x) |===||===||===||===||", 1, true) then
        fail = false
    end

    if not fail then
        Events.castleUnlocked = true
        self:setText("[username] попыталась отпереть дверь ключом, и она открылась.")
        self.anim:set("unlocked")
        self:setOptions({
            {
                text = "Войти внутрь",
                func = F(self, "inside")
            },
            {
                text = "Вернуться.",
                func = F(self, "new", true)
            }
        })
    else
        self:setText("[username] попыталась отпереть дверь ключом, но тот не подошел.")
        self.anim:set("key")
        self:setOptions({
            {
                text = "Назад.",
                func = F(self, "door")
            }
        })
    end
end


function Castle:inside()
    self.dead = true
    Game:replaceFile("castle", require("castle_inside")())
end


function Castle:back()
    self:setText("[username] решила вернуться через ворота замка.")
    self:setOptions({})
    self.deleteOnClose = true
    Game:addFile(require("eastown_gate")())
    Game:addFile(require("armor_shop")())
    Game:addFile(require("castle_gate")())
    Game:addFile(require("smith")())
end

return Castle