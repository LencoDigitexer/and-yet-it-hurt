local Dragon = Fight:extend()

function Dragon:new(...)
	Dragon.super.new(self, ...)
	Art.new(self, "dragon")

	self.enemyName = "dragon"

	self.anim:add("attacking", 3);
	self.anim:add("defending", 1);
	self.anim:add("prepareAttack", 2);
	self.anim:add("prepareDefense", 1);

	self.health = 750

	self.attack = 7
	self.timeAttacking = 8
	self.timeDefending = 3

	self.strength = 20

	self.description = "[username] подошла к дракону, который заметил её присутствие и зарычал. Битва продолжалась."
	self.attackDescription = "Дракон изрыгает своё пламя на [username]"
	self.prepareAttackDescription = "Затем дракон открыл свою пасть."
end

return Dragon