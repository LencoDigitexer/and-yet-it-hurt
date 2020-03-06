local EdburFighting = Fight:extend()

local huge = math.huge
function EdburFighting:new()
	EdburFighting.super.new(self, "weapon shop")
	Art.new(self, "edbur_fighting")

	self.anim:add("attacking", 3);
	self.anim:add("prepareAttack", 2);
	self.anim:add("defending", 1);
	self.anim:add("prepareDefense", 1);

	self.state = "defending"

	self.attack = 2

	self.health = 100
	self.strength = 1

	self.timeAttacking = huge
	self.timeDefending = huge
	self.pauseTimer = huge

	self.learnedDefending1 = false
	self.learnedAttacking1 = false
	self.learnedDefending2 = false
	self.learnedAttacking2 = false

	self.learningState = 1

	self.description = [["Всякий раз, когда вы вступаете в бой, это поле будет содержать описание противника."]]
end


function EdburFighting:update(dt)
	EdburFighting.super.update(self, dt)
end


function EdburFighting:draw()
	EdburFighting.super.draw(self)
end


function EdburFighting:updateDescription(state, damage)
	if self.learningState == 3 then return end
	self.player.health = 100
	self.health = 100
	print(state)
	print(self.learningState)
	if state == "prepareDefense" then
		if self.learningState == 1 then
			if damage > 0 then
				self:setText([["Отлично. Количество атак, которые вы можете сделать, и сколько урона наносит каждая атака, зависит от оружия. Обычно у вас будет ограниченное время, чтобы блокировать и атаковать."
(Сохранить, чтобы продолжить CTRL + S)]])
				self.learnedAttacking1 = true
				if self.learnedAttacking1 and self.learnedDefending1 then
					self.learningState = 2
				end
			else
				self:setText([["Ты промахнулся! Убедись, что в метках есть символы, кроме пробела: <{ a }>"
(Сохранить, чтобы продолжить)]])
			end
		elseif self.learningState == 2 then
			if damage > 0 then
				-- self.timeAttacking = huge
				-- self.timeDefending = huge
				self.learnedAttacking2 = true
				if self.learnedDefending2 and self.learnedAttacking2 then
					self:setText([["Молодец! Последний совет: Вместо того, чтобы нажимать рядом с " x " и нажимать backspace, вы можете выбрать " x " и заменить его пробелом." 
(Сохранить, чтобы продолжить)]])
					self.learningState = 3
				else
					self:setText([["Очень хорошо! Ты смог напасть на меня.
(Сохранить, чтобы продолжить)]])
				end
			else
				self:setText([["Ты промахнулся! Убедитесь, что в метках стоит любой символ, кроме пробела: < { a }"
(Сохранить, чтобы продолжить)]])
			end
		end
	elseif state == "defending" then
		if self.learningState == 1 then
			self:setText([["Когда на вас нападают, появляется одна или несколько таких меток: <{ x }>. Каждый знак считается за 1 атаку. Удалите " x " из метки, чтобы заблокировать атаку, или замените его пробелом. Как только все " х " будут удалены, сохраните файл. Не пытайтесь удалить саму метку, это не сработает."]])
		elseif self.learningState == 2 then
			self:setText([["Попытайтесь заблокировать мою атаку за ограниченное время. Внизу написано, сколько у вас времени."]])
			self.timeAttacking = 10
		end
	elseif state == "prepareAttack" then
		if damage > 0 then
			self:setText([["Это никуда не годится. Убедитесь в том, чтобы удалить "x" из меток."
(Сохранить, чтобы продолжить)]])
		else
			if self.learningState == 2 then
				self.learnedDefending2 = true
				if self.learnedDefending2 and self.learnedAttacking2 then
					self:setText([["WМолодец! Последний совет: Вместо того, чтобы нажимать рядом с " x " и нажимать backspace, вы можете выбрать " x " и заменить его пробелом." 
	(Сохранить, чтобы продолжить)]])
					self.learningState = 3
				else
					self:setText([["Очень хорошо! Ты смог блокировать мою атаку."
	(Сохранить, чтобы продолжить)]])
				end
			else
				self:setText([["Очень хорошо! Вы смогли блокировать мою атаку. Но помните, если вы не сохраните до истечения времени, ни один из ваших блоков не будет зарегистрирован. Иногда, возможно, было бы лучше отпустить некоторые атаки."
(Сохранить, чтобы продолжить)]])
				self.learnedDefending1 = true
				if self.learnedAttacking1 and self.learnedDefending1 then
					self.learningState = 2
				end
			end
		end
	elseif state == "attacking" then
		if self.learningState == 1 then
			-- self:setText([["When you're being attacked, these marks will pop up: <{ x }>. Remove the 'x' to block the attacks. Once all the 'x's are removed, save the file."]])
			self:setText([["Когда настанет ваша очередь атаковать, появятся следующие метки: <{ }>. Заполните метки любым символом, кроме пробела, и сохраните файл. Например: <{ a }> или <{h}>. Не пытайтесь добавить свои собственные отметки, это не сработает."]])
		elseif self.learningState == 2 then
			self.timeDefending = 10
			self:setText([["Попробуй напасть на меня за ограниченное время. Внизу написано, сколько у вас времени."]])
		end
		-- self:setText([["When you're being attacked, these marks will pop up: <{ x }>. Remove the 'x' to block the attacks.]])
	end
end


function EdburFighting:onEdit()
	if self.learningState == 3 then
		Game:replaceFile("weapon shop", require("edbur_post_fight")())
	end
	EdburFighting.super.onEdit(self)
end

function EdburFighting:__tostring()
	return lume.tostring(self, "EdburFighting")
end

return EdburFighting