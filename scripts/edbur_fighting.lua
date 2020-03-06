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

	self.description = [["������ ���, ����� �� ��������� � ���, ��� ���� ����� ��������� �������� ����������."]]
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
				self:setText([["�������. ���������� ����, ������� �� ������ �������, � ������� ����� ������� ������ �����, ������� �� ������. ������ � ��� ����� ������������ �����, ����� ����������� � ���������."
(���������, ����� ���������� CTRL + S)]])
				self.learnedAttacking1 = true
				if self.learnedAttacking1 and self.learnedDefending1 then
					self.learningState = 2
				end
			else
				self:setText([["�� �����������! �������, ��� � ������ ���� �������, ����� �������: <{ a }>"
(���������, ����� ����������)]])
			end
		elseif self.learningState == 2 then
			if damage > 0 then
				-- self.timeAttacking = huge
				-- self.timeDefending = huge
				self.learnedAttacking2 = true
				if self.learnedDefending2 and self.learnedAttacking2 then
					self:setText([["�������! ��������� �����: ������ ����, ����� �������� ����� � " x " � �������� backspace, �� ������ ������� " x " � �������� ��� ��������." 
(���������, ����� ����������)]])
					self.learningState = 3
				else
					self:setText([["����� ������! �� ���� ������� �� ����.
(���������, ����� ����������)]])
				end
			else
				self:setText([["�� �����������! ���������, ��� � ������ ����� ����� ������, ����� �������: < { a }"
(���������, ����� ����������)]])
			end
		end
	elseif state == "defending" then
		if self.learningState == 1 then
			self:setText([["����� �� ��� ��������, ���������� ���� ��� ��������� ����� �����: <{ x }>. ������ ���� ��������� �� 1 �����. ������� " x " �� �����, ����� ������������� �����, ��� �������� ��� ��������. ��� ������ ��� " � " ����� �������, ��������� ����. �� ��������� ������� ���� �����, ��� �� ���������."]])
		elseif self.learningState == 2 then
			self:setText([["����������� ������������� ��� ����� �� ������������ �����. ����� ��������, ������� � ��� �������."]])
			self.timeAttacking = 10
		end
	elseif state == "prepareAttack" then
		if damage > 0 then
			self:setText([["��� ������ �� �������. ��������� � ���, ����� ������� "x" �� �����."
(���������, ����� ����������)]])
		else
			if self.learningState == 2 then
				self.learnedDefending2 = true
				if self.learnedDefending2 and self.learnedAttacking2 then
					self:setText([["W�������! ��������� �����: ������ ����, ����� �������� ����� � " x " � �������� backspace, �� ������ ������� " x " � �������� ��� ��������." 
	(���������, ����� ����������)]])
					self.learningState = 3
				else
					self:setText([["����� ������! �� ���� ����������� ��� �����."
	(���������, ����� ����������)]])
				end
			else
				self:setText([["����� ������! �� ������ ����������� ��� �����. �� �������, ���� �� �� ��������� �� ��������� �������, �� ���� �� ����� ������ �� ����� ���������������. ������, ��������, ���� �� ����� ��������� ��������� �����."
(���������, ����� ����������)]])
				self.learnedDefending1 = true
				if self.learnedAttacking1 and self.learnedDefending1 then
					self.learningState = 2
				end
			end
		end
	elseif state == "attacking" then
		if self.learningState == 1 then
			-- self:setText([["When you're being attacked, these marks will pop up: <{ x }>. Remove the 'x' to block the attacks. Once all the 'x's are removed, save the file."]])
			self:setText([["����� �������� ���� ������� ���������, �������� ��������� �����: <{ }>. ��������� ����� ����� ��������, ����� �������, � ��������� ����. ��������: <{ a }> ��� <{h}>. �� ��������� �������� ���� ����������� �������, ��� �� ���������."]])
		elseif self.learningState == 2 then
			self.timeDefending = 10
			self:setText([["�������� ������� �� ���� �� ������������ �����. ����� ��������, ������� � ��� �������."]])
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