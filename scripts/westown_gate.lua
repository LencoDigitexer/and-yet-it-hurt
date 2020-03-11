local WestownGate = File:extend()

function WestownGate:new(text)
	WestownGate.super.new(self, "westown gate")
	if Events.fixedGuardsSigil then
		Art.new(self, "guard")
	else
		Art.new(self, "guard_no_serpent")
	end

	if not text then
		self:setText([[Ворота охранял рыцарь. "Приветствую вас," - сказал рыцарь. "Это ворота в Западный Город. Вы не можете войти, если у вас нет оружия, чтобы защитить себя. Дикие животные живут в высокой траве!"]])
	elseif type(text) == "string" then
		self:setText(text)
	end

	self:setOptions({
		{
            text = [["Впустите меня."]],
			response = [["Я вижу, у тебя есть оружие. Ну что ж, хорошо. Будь там осторожна."]],
			options = {},
			func = F(self, "enter"),
		},
		{
            text = [["Кто ты"]],
            response = [["Меня зовут Лефф. Я один из трех братьев рыцаря дракона."]]
		},
		{
			text = [["Что случилось?"]],
			condition = function () return not Events.fixedGuardsSigil end,
			response = [["Что ж, я рад, что вы спросили. Видите ли, знак на моем нагруднике не совсем правильный. В кинжале нет змеи. Не могли бы вы починить его для меня?"]],
			options = {
				{
					text = [["Я все исправлю"]],
					func = F(self, "fixSigil"),
					default = true
				},
				{
					text = [["Не сейчас."]],
					func = F(self, "new", [["Не сейчас."]])
				}
			}
		}
	})

end


function WestownGate:enter()
	self:setOptions({})
	self.deleteOnClose = true
	Game:removeFile("dragonhill gate")
	Game:removeFile("weapon shop")
	Game:removeFile("house")
	Game:addFile(require("forest")("west"))
end

function WestownGate:fixSigil()
    local fail = false
    local i = 0
    for line in (self.rContent .. "\n"):gmatch("(.-)\n") do
        i = i + 1
        if i > 21 and i < 26 then
			line = line:sub(65, 68)
			print(line)
			if (i == 22 and not line:find(" ||O", 1, true)) or
				(i == 23 and not line:find("((| ", 1, true)) or
				(i == 24 and not line:find(" |))", 1, true)) or
				(i == 25 and not line:find("<|| ", 1, true))
			then
				fail = true
				break
			end
        end
	end

	if not fail then
		Events.fixedGuardsSigil = true
		self.player.gold = self.player.gold + 25
		Art.new(self, "guard")
		self:setText([["Это прекрасно! Большое спасибо! Вот, возьми немного золота." Рыцарь вручил нам 25 золотых.]])
		self:setOptions({
			{
				text = [["Пожалуйста"]],
				func = F(self, "new", [["Пожалуйста," сказала [username].]])
			},
			{
				text = [["Без проблем."]],
				func = F(self, "new", [["Без проблем," сказала [username].]])
			}
		})
	else
		self:setText([["Нет, это кажется неправильно. Попробуй еще раз, ладно??"]])
	end
end

return WestownGate