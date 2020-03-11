local Spider = Fight:extend()

function Spider:new(...)
	Spider.super.new(self, ...)
	Art.new(self, "spider")

	self.enemyName = "creature"

	self.anim:add("attacking", 2);
	self.anim:add("defending", 1);
	self.anim:add("prepareAttack", 2);
	self.anim:add("prepareDefense", 1);

	self.health = 100

	self.attack = 3
	self.timeAttacking = 4
	self.timeDefending = 3

	self.strength = 20

	self.description = "Внезапно, [username] столкнулась с паукообразным существом. Его клыки были остры как бритва, и он не спускал глаз с врага."
	self.attackDescription = "Существо нацелило свои клыки на [username]"
	self.prepareAttackDescription = "Значит, существо готовилось к нападению!"
end


function Spider:update(dt)
	Spider.super.update(self, dt)
end


function Spider:draw()
	Spider.super.draw(self)
end


function Spider:__tostring()
	return lume.tostring(self, "Forest")
end

return Spider