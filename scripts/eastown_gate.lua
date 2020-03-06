local EastownGate = File:extend()

function EastownGate:new(text)
	EastownGate.super.new(self, "eastown gate")
	if Events.gaveGuardLongerSword then
		Art.new(self, "guard_long_sword")
	else
		Art.new(self, "guard_short_sword")
	end

	if not text then
		self:setText([[Ворота охранял рыцарь. "Приветствую вас", - сказал рыцарь. "Это ворота в Восточный Город. Вы не можете войти, если у вас нет оружия, чтобы защитить себя. Дикие животные живут в высокой траве!"]])
	elseif type(text) == "string" then
		self:setText(text)
	end
	self:setOptions({
		{
            text = [["Впустите меня."]],
			response = [["Я вижу, у тебя есть оружие. Ну что ж, хорошо. Будь там осторожна."]],
            func = F(self, "enter")
		},
		{
            text = [["Кто вы?"]],
            response = [["Моё имя - Райт. Я один из трех братьев рыцарей дракона."]]
		},
		{
			text = [["Что случилось?"]],
			condition = function () return not Events.gaveGuardLongerSword end,
			response = [["Что ж, я рад, что вы спросили. Видите ли , по сравнению с моими братьями мой меч самый короткий. Не могли бы вы сделать так, чтобы мой меч был самым длинным? Пусть он поднимется так высоко, как мои глаза."]],
			options = {
				{
					text = [["Я исправлю."]],
					default = true,
					func = F(self, "extendSword")
				},
				{
					text = [["Не сейчас."]],
					func = F(self, "new", [["Не сейчас."]])
				}
			}
		}
	})
end


function EastownGate:enter()
	self:setOptions({})
	self.deleteOnClose = true
	Game:removeFile("castle gate")
	Game:removeFile("armor shop")
	Game:removeFile("smith")
	if not Events.movedAnn then
		Game:removeFile("house")
	end
	Game:addFile(require("forest")("east"))
end


function EastownGate:extendSword()
    local fail = false
    local i = 0
    for line in (self.rContent .. "\n"):gmatch("(.-)\n") do
        i = i + 1
        if i >= 12 and i <= 25 then
			line = line:sub(83, 84)
            if line ~= "||" then
                fail = true
                break
            end
        end
	end

	if not fail then
		Events.gaveGuardLongerSword = true
		self.player.gold = self.player.gold + 25
		Art.new(self, "guard_long_sword")
		self:setText([["Это прекрасно! Большое спасибо! Вот, возьми немного золота." Рыцарь дал [username] 25 золотых.]])
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
		self:setText([["Не совсем то, что я имел в виду. Может быть, попробовать еще раз? Пусть он поднимется так высоко, как мои глаза.."]])
	end
end

return EastownGate