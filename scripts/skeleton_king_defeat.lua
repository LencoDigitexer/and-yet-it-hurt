local SkeletonKingDefeat = File:extend()

function SkeletonKingDefeat:new(text)
	SkeletonKingDefeat.super.new(self, "castle")

	Art.new(self, "dead_skeleton_king")
	self.anim:add("nosword", 2)
	self.anim:add("shake", {3, 4, 3, 4, 3, 4, 2}, 12, "once")
	self.anim:add("idle", 1)

	Events.skeletonKingDefeated = true

	self.player:regainHealth()

	self:setText([["С-спасибо", - сказал череп, и в тронном зале воцарилась полная тишина.]])
	self:setOptions({
		{
			text = [[Схватиться за меч.]],
			anim = "nosword",
			item = "nightblood",
			response = "[username] схватилась за меч. Когда она держала Кровавый Меч в своей руке, она немедленно почувствовал его невероятную силу.",
			options = {
				{
					text = [[Вернуться.]],
					response = [[Внезапно весь замок затрясся. Крыша разваливалась на части. [username] знала, что у неё было мало времени.]],
					anim = "shake",
					options = {
						{
							text = "Бежать.",
							func = F(self, "run")
						}
					}
				}
			}
		}
	})
end

function SkeletonKingDefeat:run()
	Game:replaceFile("castle", require("castle")("[username] бежала по коридорам, уворачиваясь от упавших с крыши кирпичей. И как только [username] покинула замок, он рухнул в руины."))
end

return SkeletonKingDefeat