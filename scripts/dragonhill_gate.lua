local DragonhillGate = File:extend()

function DragonhillGate:new(text)
	DragonhillGate.super.new(self, "dragonhill gate")
	Art.new(self, "guard_hill")
	self.anim:add("leaves", 2)
	self.anim:add("guard", 1)

	if not text then
		self:setText([[Ворота охранял рыцарь. - "Приветствую вас", - сказал рыцарь. - "Никому не позволено входить. Там, наверху, живет дракон."]])
	elseif type(text) == "string" then
		self:setText(text)
	end

	self:setOptions({
		{
			text = [["Впустите меня."]],
			condition = function () return not Events.skeletonKingDefeated end,
			response = [["Что ты задумал, малыш? Невозможно убить дракона. Я имею в виду, если только... но это всего лишь легенда. А теперь уходи."]],
			options = {
				{
					text = [["Если только что?"]],
					response = [["Ничего! Не обращай внимания на то, что я сказал!"]],
					remove = true
				},
				{
					text = [["Как скажете..."]],
					func = F(self, "new", [["Как скажете...," сказала [username].]])
				}
			}
		},
		{
			text = [["Впустите меня."]],
			condition = function () return Events.skeletonKingDefeated end,
			response = [["Что ты задумал, малыш? Невозможно убить дракона. Я имею в виду, если только..." Рыцарь остановился, глядя на меч в руке [username]. "Неужели это легендарный Кровавый Меч?"]],
			options = {
				{
					text = [["Да, это так"]],
					func = F(self, "enter"),
					response = [["Я не могу в это поверить. Очень хорошо. Тогда вы можете войти. Удачи тебе."]],
				},
				{
					text = [["Это верно."]],
					func = F(self, "enter"),
				}
			}
		},
		{
			text = [["А ты кто?"]],
			response = [["Меня зовут Норд. Я один из трех братьев рыцаря дракона."]]
		},
		{
			text = [["-Что случилось?"]],
			anim = "leaves",
			condition = function () return not Events.foundGuardsRing end,
			response = [["Я рад, что вы спросили. Видите ли, я потерял свое кольцо в этой горе листьев. Оно выглядит как '9'. Вы можете найти его для меня?
Когда вы найдете его, замените на '0'."]],
			options = {
				{
					text = [["Я найду его!"]],
					default = true,
					func = F(self, "findRing")
				},
				{
					text = [["Не сейчас."]],
					anim = "guard",
					func = F(self, "new", [["Не сейчас."]])
				}
			}
		}
	})

	self.inited = true
end


function DragonhillGate:findRing()
    self.rContent = love.filesystem.read(self.file)
	if self.rContent:find("566556565056565656565") then
		Events.foundGuardsRing = true
		self.player.gold = self.player.gold + 25
		self.anim:set("guard")
		self:setText([["Вы действительно нашли его! Большое спасибо!" Рыцарь вручил [username] 25 золотых.]])
		self:setOptions({
			{
				text = [["Пожалуйста."]],
				func = F(self, "new", [["Пожалуйста," сказала [username].]])
			},
			{
				text = [["Без проблем."]],
				func = F(self, "new", [["Без проблем," сказала [username].]])
			}
		})
	else
		self:setText([["Ну, не совсем так. Вы уверены, что нашли моё кольцо, которое выглядит как "9" и заменили его на "0"?"]])
	end
end

function DragonhillGate:enter()
	self:setText([["Я не могу в это поверить. Очень хорошо, тогда вы можете войти. Удачи тебе."]])
	self:setOptions({})
	self.deleteOnClose = true
	Game:removeFile("weapon shop")
	Game:removeFile("house")
	Game:removeFile("westown gate")
	Game:addFile(require("troll")())
end

return DragonhillGate