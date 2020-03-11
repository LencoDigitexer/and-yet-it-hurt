local Smith = File:extend()

function Smith:new(text)
	Smith.super.new(self, "smith")
	Art.new(self, "smith")
	self.anim:add("idle", 1)

	self.gaveNote = false

	if Events.gaveNoteToFerdanStart and not Events.gaveNoteToFerdan then
		Art.new(self, "ferdan")
		self.anim:add("idle", 1)
		self.anim:add("opening", 1)
		self.anim:add("angry", 3)
		self.anim:set("angry")
		self:setText([["Как ты думаешь, это нормально - уйти посреди разговора?" - сердито сказал Фердан .]])
		self:setOptions({
			{
				text = [["Простите."]],
				func = F(self, "note")
			}
		})
		return
	end

	if text then
		self:setText(text)
		self:setOptions({})
	elseif Events.gaveNoteToFerdan then
		self:setText([["Привет [username]," сказал Фердан. "Ты ещё не передумала, глупышка?"]])
		if not Events.movedAnn then
			self:setOptions({
				{
					text = [["У вас есть ключ от ворот замка?"]],
					response = [["Нет, а что? Они заперты? Хорошо! Это мешает таким людям, как Вы, принимать глупые решения. У кого бы они ни были, я надеюсь, что они их сохранят."]],
					condition = function () return not Events.metAnn end,
					options = {}
				},
				{
					text = [["Нет."]],
					response = [["Нет," сказала [username]. "Идиотка," сказал Фердан.]],
					remove = true
				}
			})
		end
	else
		self:setText([[Когда [username] вошла, она увидела большого и сильного мужчину, колотящего по мечу. "Что я могу для тебя сделать?", спросил мужчина..]])

		self:setOptions({
			{
				text = [["Я друг Эдбура"]],
				response = [["Эдбур? Что этот старик задумал? Как бы то ни было, ты можешь дружить с королем, мне все равно. Если у вас нет денег, тогда уходите."]],
				remove = true
			},
			{
				text = [["Можно мне купить меч?"]],
				response = [["Это зависит от того, есть ли у вас 200 золотых? Если нет то уходите."]],
				remove = true
			}
		})

		if not Events.gaveNoteToFerdan and not self.gaveNote then
			self:setOnItems({
			{
				request = Player.pronoun .. "NoteEdbur",
				response = [[[username] передала записку Эдбура Фердану. "Эдбур попросил меня передать это тебе. Он сказал, что ты поймешь."]],
				func = function ()
					self.inCutscene = true
					self.gaveNote = true
					Events.gaveNoteToFerdanStart = true
					self:setOnItems({})
				end,
				options = {
					{
						text = "Продолжить.",
						func = F(self, "note")
					},
				}
			}})
		end
	end
end


function Smith:update(dt)
	Smith.super.update(self, dt)
end


function Smith:draw()
	Smith.super.draw(self)
end


function Smith:note()
	Art.new(self, "ferdan")
	self.anim:add("idle", 1)
	self.anim:add("angry", 3)
	self.anim:add("opening", 1)
	self:setText([["Давайте посмотрим, что все это значит", - сказал Фердан, читая записку. "Граграграгра!" - Фердан рассмеялся. "Ты стал мягким, Эдбур."]])
	self:setOptions({
		{
			text = "Продолжить.",
			default = true,
			response = [["А ты, какая же ты дура." - Раздраженно спросил фердан. "Убить дракона из мести. По словам Эдбура, я не могу убедить вас в обратном."]],
			anim = "angry",
			options = {
				{
					text = "Продолжить.",
					response = [[Фердан вздохнул. "Ты не можешь убить его, малыш. Ни с этим кинжалом, ни с любым из моих мечей."]],
					default = true,
					anim = "idle",
					options = {
						{
							text = [["Что ты имеешь в виду?"]],
							response = [["Легенда гласит, что дракона можно убить только Кровавым Мечом, мечом, выкованным из крови демонов. Он настолько острый, что может прорезать чешую дракона."]],
							options = {
								{
									text = [["Где же он?"]],
									response = [["Говорят, что Кровавым Мечом, если он вообще существует, владеет Король скелетов, живущий в соседнем замке."]],
									options = {
										{
											text = [["Спасибо, теперь я знаю, что делать."]],
											anim = "angry",
											response = [["Не делай этого, малыш. Король скелетов, если он вообще существует, остался непобежденным. Если ты веришь во все это, то ты дура, а если это правда, то ты еще больше дура!"]],
											options = {
												{
													text = [["Мне очень жаль, Фердан. У меня нет выбора."]],
													response = [["Ну, если ты собираешься это сделать, сделай это как следует!" Фердан вышел в другую комнату и вернулся с мечом. "Вот, возьми," сказал Фердан, сунув меч в руки [username]. "Лучше бы Эдбур не плакал у моих ног, когда ты умрешь!"]],
													func = function ()
														Events.gaveNoteToFerdan = true
														Player.inventory.note = nil
													end,
													item = "sword",
													options = {
														{
															text = [["Спасибо."]],
															func = F(self, "new", [["Спасибо, Фердан," сказала [username]. Фердан покачал головой и продолжил свою работу.]])
														}
													}
												}
											}
										},
										{
											text = [["Король Скелетов?"]],
											response = [["Не отставай от легенд, малыш. 138 лет назад король скелетов использовал запрещенную магию, чтобы обрести вечную жизнь. Он потерял всю свою плоть, но его душа и кости продолжают жить. Не то чтобы я верил во все эти сказки."]],
											remove = true
										}
									}
								}
							}
						}
					}
				}
			}
		}
	})
end


function Smith:__tostring()
	return lume.tostring(self, "Smith")
end

return Smith