local Boar = Fight:extend()

function Boar:new(...)
	Boar.super.new(self, ...)
	Art.new(self, "boar")

	self.enemyName = "boar"

	self.anim:add("attacking", 1);
	self.anim:add("defending", 1);
	self.anim:add("prepareAttack", 2);
	self.anim:add("prepareDefense", 1);

	self.health = 20

	self.attack = 1
	self.timeAttacking = 3
	self.timeDefending = 6

	self.strength = 25

	self.description = "Внезапно, [username] столкнулась с кабаном. Им требуется время для подготовке к аттаке, но как только они будут готовы, все закончится прежде, чем вы это заметите."
	self.attackDescription = "Кабан бросился на [username]"
	self.prepareAttackDescription = "Значит, кабан готовится к нападению!"
end


function Boar:update(dt)
	Boar.super.update(self, dt)
end


function Boar:draw()
	Boar.super.draw(self)
end


function Boar:__tostring()
	return lume.tostring(self, "Boar")
end

return Boar