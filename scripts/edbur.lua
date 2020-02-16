local Edbur = File:extend()

function Edbur:new()
	Edbur.super.new(self, "weapon shop")
	Art.new(self, "weapon_shop")

	self.anim:add("laughing", 2)
	self.anim:add("hand", 3)
	self.anim:add("idle", 1)

	if Events.gavePantsToEdbur then
		self:setText([["Куда же вы пошли?" сказал Эдбур. "Я же сказал тебе ждать здесь."]])
		self:setOptions({
				{
					text = [["Простите."]],
					response = [[Эдбур дал [username] кинжал. "Держи, твоё оружие."]],
					item = "dagger",
					func = function ()
						Game:removeFile("home")
						Game:removeFile("house")
						Game:removeFile("grocery store")
					end,
					options = {
						{
							text = [["Спасибо!"]],
							anim = "laughing",
							response = [[Блеск кинжала в руке [username] вызвал улыбку у неё на лице. Это заставляло её чувствовать себя сильной, как будто она могла завладеть всем миром. "Большое спасибо, Эдбур!" сказала [username]. "Ргархархарха", засмеялся Эдубр. "Нет проблем, малыш, но будь осторожен"]],
							options = {
								{
									text = "Продолжить.",
									func = F(self, "event", 1)
								}
							}
						}
					}
				}
			}
		)
		return
	end

	self:setText([["Ну здравствуй, [username]," сказал Эдбур, здоровый старик, который, несмотря на свой возраст, всё ещё был одним из самых сильных в городе. Эдбур был хорошим другом отца [username] "Что я могу для вас сделать?"]])

	self:setOnItems({
	{
		request = "pantsEdbur",
		response = [[[username] передала Эдбуру его штаны. "Очень хорошо, вот 30 золотых. И знаешь что? Я дам тебе кое-что еще! Подожди здесь."]],
		gold = 30,
		remove = true,
		anim = "idle",
		event = "gavePantsToEdbur",
		options = {
			{
				text = "Ждать.",
				response = [[Эдбур уходит в кладовку магазина и возвращается с кинжалом. "Держи, это твоё личное оружие."]],
				item = "dagger",
				func = function ()
					Game:removeFile("home")
					Game:removeFile("house")
					Game:removeFile("grocery store")
				end,
				options = {
					{
						text = [["Спасибо!"]],
						anim = "laughing",
						response = [[Блеск кинжала в руке [username] вызвал улыбку у неё на лице. Это заставляло её чувствовать себя сильной, как будто она могла завладеть всем миром. "Большое спасибо, Эдбур!" сказала [username]. "Ргархархарха", засмеялся Эдубр. "Нет проблем, малыш, но будь осторожен"]],
						options = {
							{
								text = "Продолжить.",
								func = F(self, "event", 1)
							}
						}
					}
				}
			}
		}
	}})

	self:setOptions({
		{
			text = [["Я хочу купить оружие."]],
			response = [["Ргархархарха", засмеялся Эдбур. "Зачем такому ребенку, как ты, оружие? У тебя всё равно не хватит золота."]],
			anim = "laughing",
			remove = true
		},
		{
			condition = F(self, "hasItem", "pantsEdbur"),
			text = [["Я принесла ваши штаны."]],
			response = [["Круто, давай их сюда"]],
			anim = "hand",
			options = {},
		}
	})
end


function Edbur:update(dt)
	Edbur.super.update(self, dt)
end


function Edbur:draw()
	Edbur.super.draw(self)
end


function Edbur:event(i)
	self:loadArt("edbur")
	self.anim:add("idle", 1)
	Events.bellRang = true
	self:setOptions({
		{
			text = "Продолжить.",
			default = true,
			func = F(self, "event", i + 1)
		}
	})

	if i == 1 then
		self:loadArt("weapon_shop")
		self.anim:add("idle", 1)
		self:setText([[Внезапно, Эдбур был прерван колокольным звоном на башне. Эдбур был испуганным, чего [username] никогда раньше не видела от сильного и храброго Эдбура. "30 лет...," сказал Эдбур, глядя в даль.]])
	elseif i == 2 then
		self:setText([["Что происходит?", спросила [username]. Эдбур схватил [username] за плечи. "Этот колокол означает, что дракон направляется в нашу сторону."]])
	elseif i == 3 then
		self:setText([[[username] никогда раньше не видела дракона. Но по рассказам она слышала об этих существах и по реакции Эдбура, она понимала, что город и жизнь каждого в опасности.]])
	elseif i == 4 then
		Game:addFile(require "dragon_burning_home")
		Game:addFile(require("elli")())
		self.deleteOnClose = true
		self:setText([["Слушай внимательно, [username], мне нужно, чтобы ты не боялась и убедилась в том, что твои родители в безопасности - их овци могут приманить дракона к ним. Я сейчас одену штаны и тоже пойду к ним."]])
		self:setOptions({})
	end

end


function Edbur:__tostring()
	return lume.tostring(self, "Edbur")
end

return Edbur