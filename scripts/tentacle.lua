local Tentacle = Fight:extend()

function Tentacle:new(...)
	Tentacle.super.new(self, ...)
	Art.new(self, "tentacle")

	self.enemyName = "tentacle monster"

	self.anim:add("attacking", 1);
	self.anim:add("defending", 1);
	self.anim:add("prepareAttack", 1);
	self.anim:add("prepareDefense", 1);

	self.health = 90

	self.attack = 2
	self.timeAttacking = 4
	self.timeDefending = 3

	self.strength = 15

	self.description = "Внезапно, из земли выскочило тентакли."
	self.attackDescription = "Тентакли бросилось на [username]"
	self.prepareAttackDescription = "А потом тентакли приготовилось к нападению! (53u*ch45 600D37 53K5)"
end

return Tentacle