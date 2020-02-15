local ReadMe = File:extend()

function ReadMe:new()
    ReadMe.super.new(self, "readme")
    if self.isOpen then
        Art.new(self, "logo")
    else
        Art.new(self, "readme_noadmin")
        return
    end

    if SAVE.exists then
        self:setText([[��, ����� ���������� �����. � ����, �� ��� ����� � ��� ���� ������. ������ ���������� � ���� �����, �� ������� ������������?]])
        self:setOptions({
            {
                text = "��, ������� ����������.",
                func = F(self, "load")
            },
            {
                text = "���, ����� ������ �������.",
                func = F(self, "tips")
            },
        })
    else
        self:setText([[��� ������: ����� �� ������� ��������. �� ������ ������� �����, �������� [] ����� ��� ����������� ���������. 
��������: [s] - � �������, ��� �������� �����. 
����� ���������� ������ ������ �� ������ ��������� ���� � ������� Ctrl + S. ����������!]])
        self:setOptions({
            {
                text = "� �������, ��� ������� ��� ��� ���� �������.",
                func = F(self, "tips")
            }
        })
    end
end


function ReadMe:tips()
    self:setText([[������! ������ ��� �� ������ ����, � ���� ���� ��������� ������� ��� ���.
� ������� ������� Windows + ������� �� ��������� �����/������ �� ������ ��������� ���� ������� ����� ���� � ������.
� ������ �� ��, ��� �� ������ �������� ������� � ������� Ctrl + ������ ���������?]])
    self:setOptions({
        {
            text = "������� �� ������.",
            func = F(self, "continue", 1)
        },
        {
            text = "� ����� �� ����!",
            func = F(self, "continue", 2)
        },
        {
            text = "� ��� ���� ���!",
            func = F(self, "continue", 3)
        }
    })
end

function ReadMe:continue(n)
    local start = ""
    if n == 1 then
        start = "������ ����������!"
    elseif n == 2 then
        start = "�� ��� ������ �� ������!"
    elseif n == 3 then
        start = "����� ������!"
    end

    self:setText(start .. [[ �� ����� ������ ����������� � �����������. �����.
��-������, ��������� ������ ([]) ������ ������ ���������. ��� �� ����� ���� ������� 15 ��������.
��������: [����] ��� [�����] - ��� ����� ����� ���������.]])

    if n == 4 then
        self:setText([[�� ���������� ������ ��������? ��� ���������.
��������� ������ ([]) ������ ������ ���������. ��� �� ����� ���� ������� 15 ��������.
��������: [����] ��� [�����] - ��� ����� ����� ���������.]])
    end

	self:setOptions({
        {
            text = "��� ��� ����� ���������",
            func = F(self, "setName")
        },
        {
            text = "� ����� �� ���� ������������ � ������.",
            func = F(self, "setName", true)
        }
    })
end

function ReadMe:setName(pick)
    print(pick)
    local name
    if pick then
        local names = {"������", "�����", "�����", "�����", "�������", "������"}
        name = lume.randomchoice(names)
        self:setText("�����, ����� � ��� ������... " .. name .. "! ������, ��� �� ������ �������� �� ���� ���������?")
    else
        local match = self.rContent:sub(1000, #self.rContent):match("%[([^%]]+)%]%s%-%s" .. Utils.litString("��� ��� ����� ���������."))

        if match then
            if #match > 15 then
                self:setText("��� ��� ������� �������! ����������, �� ����������� ����� 15 ��������.")
                return
            end
            self:setText([[����, ��� ������ ��������� ]] .. match .. [[? ��� �������� ���!
��� �� ������ �������� �� ���� ���������?]])
            name = match
        else
            return
        end
    end

    Player.name = name

    self:setOptions({
        {
            text = "he/him/his",
            func = F(self, "pronouns", "he")
        },
        {
            text = "she/her/her",
            func = F(self, "pronouns", "she")
        },
        {
            text = "they/their/them",
            func = F(self, "pronouns", "they")
        },
        {
            text = "� ���� ������� ���.",
            func = F(self, "continue", 4)
        }
    })
end

function ReadMe:pronouns(p)
    Player.pronoun = p

    self:setText([[���. ����� ������.� ��� �� ���� ������. 
��� ������� � [username], ������ �� ���������� ������, ������� ��� ���������� � ������ ������ � ��� ����������.
(�������� ���� �� ������ � �����.)]])
    self:setOptions({})

    self.deleteOnClose = true
    Game:addFile(require("edbur")())
    Game:addFile(require("home")())
    Game:addFile(require("elli")())
    Game:addFile(require("grocery_store")())
end

function ReadMe:load()
    print(SAVE.Events)
    Events = SAVE.Events
    print(Events)
    Player.name = SAVE.name
    Player.pronoun = SAVE.pronoun
    Player.inventory = SAVE.inventory
    Player.gold = SAVE.gold
    local w = 0
    for i,v in ipairs(Player.inventory) do
        if v.tag == "nightblood" then
            self.player.weapon = v
            w = 3
        elseif w < 3 and v.tag == "sword" then
            self.player.weapon = v
            w = 2
        elseif w < 2 and v.tag == "dagger" then
            self.player.weapon = v
            w = 1
        end
    end
    self:setText("����� ������. ������� ��������� ���� �����������" .. Player.name .. ".")
    self:setOptions({})
    self.deleteOnClose = true
    Game:addFile(require("edbur_post_lament")(nil, 9))
end

return ReadMe