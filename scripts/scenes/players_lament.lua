local scene = {
	isScene = true,
	name = "weapon shop",
	art = "players_lament",
	anims = function (self)
		self.anim:add("bed", 2)
		self.anim:add("food", 3)
		self.anim:add("edbur_sad", 4)
		self.anim:add("sun", 5)
		self.anim:add("edbur_smiling", 6)
		self.anim:add("edbur_angry", 7)
		self.anim:add("eye", 8)
		self.anim:add("edbur_neutral", 9)
		self.anim:add("door", 1)
	end,
	
	onOpen = function ()
		Game:removeFile("home")
	end,

	scenes = {
		{
			anim = "door",
			text = [[Эдбур медленно закрыл дверь. "[username], ты спишь?". Как обычно, [username] не ответила.]]
		},
		{
			anim = "bed",
			text = [["Прошло 3 дня. Я знаю, что это должно быть тяжело для тебя, но ты не можешь просто лежать в постели весь день." Ответа по-прежнему не было.]],
		},
		{
			anim = "food",
			text = [["Хотя бы поешь. Я знаю, что я не лучший повар, но делаю это с любовью. Разве это не самое главное? Рхахаха.. ха..," Эдбур неловко засмеялся. [username] промолчала.]],
		},
		{
			anim = "edbur_sad",
			text = [["Хорошо, я оставлю тарелку рядом с твоей кроватью, как обычно." Он поставил тарелку и взял другую, с уже остывшей едой.]],
		},
		{
			anim = "door",
			text = [["Хотел бы я быть хорошим специалистом в таких делах", - подумал он, закрывая за собой дверь.]]
		},
		{
			anim = "sun",
			text = [[Прошло еще 2 дня, когда [username], наконец, решила покинуть кровать.]]
		},
		{
			anim = "edbur_smiling",
			text = [["[username]! Э.. Ты в порядке?" Осторожно спросил Эдбур]],
			option = [["Я хочу убить дракона."]]
		},
		{
			anim = "edbur_angry",
			text = [["Я хочу убить дракона," сказала [username]. Эдбуру нужен был момент, чтобы понять, какие слова слетели с губ [username]. "Ты что, с ума сошла? Разве ты не видела?"]],
			option = "Продолжить."
		},
		{
			anim = "eye",
			text = [[Эдбур затих, глядя прямо в глаза [username]. Они были полны чистой ненависти. Эдбуру нечего было возразить мнению [username]. ]]
		},
		{
			anim = "edbur_neutral",
			text = [[Эдбур вздохнул. "Ладно. Следуй за мной. Я научу тебя сражаться."]]
		},
		{
			func = function () Game:replaceFile("weapon shop", require("edbur_fighting")()) end
		}
	}
}

return Scene(scene)