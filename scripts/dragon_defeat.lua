local DragonDefeat = File:extend()

function DragonDefeat:new()
	DragonDefeat.super.new(self, "dragonhill")

    Art.new(self, "starry_night")
    self.anim:add("end", "2>13", 18, "once")
    self.anim:add("idle", 1)

	Events.dragonDefeated = true

	self:setText([[[username] упала на колени рядом с обезглавленным драконом и Кровавым Мечём в руках. Это было сделано.]])
	self:setOptions({
		{
			text = [[Посмотреть.]],
            response = [[[username] уставилась в звездное небо. Это выглядело очень мило. Из глаз [username] медленно потекли слезы.]],
			options = {
				{
					text = [[Горевать.]],
                    response = [["Я скучаю по тебе, Мама, Папа," сказала [username].
И все же было больно.]],
                    func = F(self, "ending")
				}
			}
		}
	})
end

function DragonDefeat:ending()
    self:setOptions({})
    self.tick:delay(4, function ()
		self.deleteOnClose = true
		local credits = love.filesystem.read("assets/art/credits.txt")
		love.filesystem.write("Game/credits.txt", credits)
        self.anim:set("end")
	end)
end

return DragonDefeat