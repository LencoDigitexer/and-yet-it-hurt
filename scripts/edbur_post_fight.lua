local EdburPost = File:extend()

function EdburPost:new()
	EdburPost.super.new(self, "weapon shop")
	Art.new(self, "weapon_shop")
	self.anim:add("blush", 6)
	self.anim:add("idle", 4)
	self.cutscene = true
	self:setText([["Теперь ты знаешь, как сражаться. Но скажи мне, [username], ты уверена, что хочешь этого? Ты уверена, что хочешь сразиться с драконом?"]])
	local destiny = F(self, "destiny")
	self:setOptions({
		{
			text = [["Я должна это сделать."]],
			func = destiny
		},
		{
			text = [["Это моя судьба."]],
			func = destiny
		},
		{
			text = [["Это единственный выход."]],
			func = destiny
		},
		{
			text = [["Я не чувствую, что у меня есть выбор."]],
			response = [["Конечно, у тебя есть выбор! Ты можешь остаться здесь со мной. Живите мирной жизнью под моей защитой. Что скажешь, [username]?"]],
			options = {
				{
					text = [["Я должна отомстить за своих родителей."]],
					func = destiny
				},
				{
					text = [["Я не найду счастья в своей жизни, пока бьется сердце этого дракона."]],
					func = destiny
				},
				{
					text = [["Я лучше умру пытаясь что-то делать, чем буду жить мирной жизнью сожаления."]],
					func = destiny
				},
				{
					text = [["Нет, я серьезно, Эдбур. Нет такого варианта, где я не сражалась бы с драконом."]],
					func = destiny
				}
			}
		}
	})

	self:setOnItems({
	{
		request =  Player.pronoun .. "NoteEdbur",
		response = [[Едбур покраснел. "Н-не читай его! Просто отдай Фердану"]],
		anim = "blush",
	}})
end


function EdburPost:destiny()
	self:setText([["Хорошо, я понимаю," сказал Эдбур, который не совсем понимал. "В любом случае, вы не сможете победить его простым кинжалом."]])
	self:setOptions({
		{
			text = [["Ты не можешь дать мне свое оружие?"]],
			response = [["Я бы так и сделал, если бы мог, но пока ты лежала в постели, я продал всё своё оружие. Люди хотят защищать себя, когда дракон вернётся."]],
			options = {
				{
					text = [["Что же мне теперь делать?"]],
					response = [["У меня есть старый друг, который работает кузнецом в Западном Городе. Возможно, он сумеет вам помочь. Его зовут Фердан. Дайте ему эту записку, он поймет." Эдбур написал что-то на листке бумаги и передал его [username].]],
					item = Player.pronoun .. "NoteEdbur",
					options = {
						{
							text = [["Спасибо!"]],
							anim = "idle",
							remove = true,
							options = {},
							func = F(self, "endCutscene")
						},
						{
							text = [["Что говорится в записке?"]],
							response = [[Эдбур покраснел. "Это секрет! Так что не читай его! Просто отдать Фернаду."]],
							anim = "blush",
							remove = true
						}
					}
				},
			}
		}
	})
end


function EdburPost:endCutscene()
	Events.postLament = true
	local text = [["Спасибо, Эдбур!" сказала [username] обнимая Эдбура. "Без проблем, дитё," сказал Эдбур. "Будь там осторожна."
(Отныне ваш прогресс будет сохраняться автоматически)]]
	self:setText(text)
	Game:replaceFile("weapon shop", require("edbur_post_lament")(text))
	Game:addFile(require("westown_gate")())
	Game:addFile(require("dragonhill_gate")())
	Game:addFile(require("elli")())
end


function EdburPost:update(dt)
	EdburPost.super.update(self, dt)
end


function EdburPost:draw()
	EdburPost.super.draw(self)
end


function EdburPost:__tostring()
	return lume.tostring(self, "EdburPost")
end

return EdburPost