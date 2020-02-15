local Home = File:extend()

function Home:new()
	Home.super.new(self, "home")
	self:init()
end

function Home:init()
	Art.new(self, "clothing_shop")
	print(self.isOpen)
	if not self.isOpen then return end

	if Events.hasBeenAtHomeBefore then
		self:setText("")
	else
		Events.hasBeenAtHomeBefore = true
		self:setText("Родители [username] были портными. У каждого в городе была своя одежда, сшитая ими. Сегодня все овцы были приведены в дом, чтобы их стриг отец [username], в то время как её мать шила новую одежду.")
	end

	self:setOptions({
		{
			text = "Поговорить с мамой.",
			func = F(self, "mom")
		},
		{
			text = "Поговорить с папой.",
			func = F(self, "dad")
		}
	})
end


function Home:mom()
	self:loadArt("mom")

	if Events.gotPantsFromMom then
		self:setText([["Привет, солнышко. Ты отдала Эдбуру его штаны?" сказала мама [username].]])
		self:setOptions({
			{
				text = [["Да, сделано"]],
				condition = function () print(Events.gavePantsToEdbur) return Events.gavePantsToEdbur end,
				response = [["Спасибо, солнышко, передай, пожалуйста, мне... -" Внезапно речь мамы [username] была прервана громким звонком. Улыбка матери мгновенно исчезла. "Этого не может быть! Что нам делать, Гарольд?". [username] смутилась и спросила, что происходит.]],
				func = function () Game:removeFile("house") Game:removeFile("weapon shop") end,
				options = {
					{
						text = "Продолжить.",
						func = F(self, "event", 1)
					}
				}
			},
			{
				text = [["Я не..."]],
				response = [["Ну, пожалуйста, поторопись, у Эдбура, наверное, ноги мерзнут."]],
				options = {
					{
						text = "Назад.",
						func = F(self, "init")
					}
				}
			}	
		})
	else
		self:setText([["Привет, милая. Ты можешь отнести эти штаны Эдбуру?", спросила мама [username] ]])
		self:setOptions({
			{
				text = [["Хорошо."]],
				response = [["Хорошо," сказала [username] с явным отсутствием энтузиазма в её голосе. Её мать поблагодарила её и вручила ей штаны Эдбура.]],
				item = "pantsEdbur",
				event = "gotPantsFromMom",
				options = {
					{
						text = "Назад.",
						func = F(self, "init")
					}
				}
			},
			{
				text = [["Не сейчас."]],
				func = F(self, "init")
			}	
		})
	end
end


function Home:dad()
	self:loadArt("dad")

	if Events.goldTakenByDad then
		self:setText([["Я ненавижу обедать без бокала молока," сказал папа [username].]])
		self:setOptions({
			{
				text = [[Назад.]],
				func = F(self, "init")
			}
		})
	elseif Events.gotGoldFromDad then
		self:setText([["Привет [username]," сказал папа [username], который всё ещё стриг овец. "Ты нашла молоко?"]])
		self:setOptions({
			{
				text = [["Магазин закрыт сегодня."]],
				condition = function () return Events.sawStore end,
				response = [["Вот как? Чёрт." выругался папа [username] забирая у нее 5 золотых монет. "Тогда никакого молока на обед."]],
				gold = -5,
				event = "goldTakenByDad",
				options = {
					{
						text = "Назад.",
						func = F(self, "init")
					}
				}
			},
			{
				text = [["Еще нет."]],
				response = [["Тогда чего ждёшь?" спросил папа [username], "Хочешь чтобы мы обедали без молока?."]],
				options = {
					{
						text = "Назад.",
						func = F(self, "init")
					}
				}
			}	
		})
	else
		self:setText([["Приветствую, [username]," сказал папа [username], который всё ещё стриг овец. "Можешь сходить в магазин за молоком?"]])
		self:setOptions({
			{
				text = [["Хорошо."]],
				response = [["Хорошо.", неохотно согласилась [username]. Её отец поблагодарил её и дал 5 золотых монет на молоко]],
				gold = 5,
				event = "gotGoldFromDad",
				options = {
					{
						text = "Назад.",
						func = F(self, "init")
					}
				}
			},
			{
				text = [["Не сейчас."]],
				func = F(self, "init")
			}
		})
	end
end


function Home:event(i)
	self:loadArt("dad")

	self:setOptions({
		{
			text = "Дальше.",
			func = F(self, "event", i + 1)
		}
	})

	if i == 1 then
		self:setText([["Успокойся," сказал папа [username]. " Если мы останемся внутри и будем сидеть тихо, мы будем в безопасности." [username] ещё раз спросила, что происходит.]])
	elseif i == 2 then
		self:setText([["Тихо!" яростно, но шепотом сказал отец [username], всё ещё растерянный, он не осмеливался сказать больше ни слова.]])
	elseif i == 3 then
		-- self.visible = false
		self:setText([[Внезапно земля задрожала, и овцы истерически заблеяли.]])
	elseif i == 4 then
		-- self.visible = true
		self:setText([["БЛЯТЬ!" крикнул папа [username]. "Помогите мне их успокоить - они слишком громкие!"]])
	elseif i == 5 then
		self.visible = false
		Art.new(self, "the_end_qm")
		self:setText([[В следующий раз, [username] Была окружена пламенем. Жара была невыносимой, и она кричала от боли, когда она была сожжена заживо. Это был её конец.]])
		self:setOptions({
			{
				text = "Перезапустить.",
				func = F(self, "restart")
			}
		})
	end
end


function Home:restart()
	love.event.quit("restart")
end

return Home