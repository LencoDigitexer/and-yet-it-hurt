local DragonHill = File:extend()

function DragonHill:new()
	DragonHill.super.new(self, "dragonhill")
    Art.new(self, "dragonhill")

    self:setText("Наконец, [username] добралась до вершины холма. Там она увидел его. Дракона. Все это время [username] накапливала эмоции, ярость, и пришло время дать им волю.")
    self:setOptions({{
        text = "Сразиться с драконом.",
        func = F(self, "fight")
    }})
end


function DragonHill:fight()
	Game:replaceFile("dragonhill", require("dragon")("dragonhill", "dragon_defeat"))
end

return DragonHill