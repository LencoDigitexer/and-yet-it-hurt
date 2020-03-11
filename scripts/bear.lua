local Bear = Fight:extend()

function Bear:new(...)
	Bear.super.new(self, ...)
	Art.new(self, "bear")

	self.enemyName = "bear"

	self.anim:add("attacking", 1);
	self.anim:add("defending", 1);
	self.anim:add("prepareAttack", 1);
	self.anim:add("prepareDefense", 1);

	self.health = 100

	self.attack = 2
	self.timeAttacking = 4
	self.timeDefending = 4

	self.strength = 20

	self.description = "Внезапно, [username] встрнетилась с медведем. Передние лапы с большими когтями запросто могут разрезать плоть."
	self.attackDescription = "Медведь поднял лапы на [username]"
	self.prepareAttackDescription = "Значит, медведь готовится к нападению!"
end


function Bear:update(dt)
	Bear.super.update(self, dt)
end


function Bear:draw()
	Bear.super.draw(self)
end


function Bear:__tostring()
	return lume.tostring(self, "Boar")
end

return Bear