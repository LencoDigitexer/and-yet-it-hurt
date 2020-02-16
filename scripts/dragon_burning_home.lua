local scene = {
	isScene = true,
	name = "home",
	art = "dragon_burning_home",
	anims = function (self)
		self.anim:add("eye", 2)
		self.anim:add("charge", 3)
		self.anim:add("stopped", 4)
		self.anim:add("Edbur", 5)
		self.anim:add("dragon", 6)
		self.anim:add("dragon_burning", 1)
	end,
	scenes = {
		{
			anim = "dragon_burning",
			text = "В суматохе города, [username] бежит к своему дому. По прибытию, её страх стал реальностью. Дракон, страшнее, чем [username] могла себе представить, извергал свое пылающее пламя прямо на её дом.",
			func = function () Game:removeFile("house") end
		},
		{
			anim = "eye",
			text = "[username] наблюдала, как пламя уничтожало всё, чем она владела, всё, что она любила. Она слышала, как крики её родителей проникают сквозь горящие стены.",
		},
		{
			anim = "charge",
			text = "[username] посмотрела на свой кинжал в руке. [username] не могла мыслить разумно, потому что её переполняли эмоции. Она сжала кинжал покрепче и бросилась на дракона.",
		},
		{
			anim = "stopped",
			text = "Но прежде чем она смогла приблизиться к дракону, её схватили за руку.",
		},
		{
			anim = "Edbur",
			text = [[Это был Эдбур. "Что ты делаешь?! Ты хочешь умереть?!", он закричал на [username].]],
		},
		{
			anim = "dragon",
			text = [[[username] потребовалась секунда, чтобы собраться с мыслями. Все смешаные эмоции превратились в горе, когда она обняла Эдубра. "Пошли," сказал Эдбур, когда дракон улетел, "ты можешь отдохнуть у меня дома."]],
			func = function ()
				Game:addFile(require("scenes.players_lament"))
			end
		}
	}
}

return Scene(scene)