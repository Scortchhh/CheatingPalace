require("Enums")

local KeyNames = {}
KeyNames[4] 		= "HK_SUMMONER1"
KeyNames[5] 		= "HK_SUMMONER2"
KeyNames[6] 		= "HK_ITEM1"
KeyNames[7] 		= "HK_ITEM2"
KeyNames[8] 		= "HK_ITEM3"
KeyNames[9] 		= "HK_ITEM4"
KeyNames[10] 		= "HK_ITEM5"
KeyNames[11]		= "HK_ITEM6"

local function GetItemKey(ItemName)
    for i = 6 , 11 do
		if myHero:GetSpellSlot(i).Info.Name == ItemName then
			return KeyNames[i]
		end
	end
	return nil
end

ItemLib = {
    InfinityEdge = {
        CritDmgMod      = function() 
            if myHero.CritMod >= 0.6 then
                return 0.35 
            end

            return 0
        end,
        DamageType      = DamageType.PHYSICALDAMAGE,
    },
    Galeforce = {
        Range           = function() return 750 end,
        ItemName        = "6671Cast",
        Dmg             = function() 
            local dmg = {180, 195, 210, 225, 240, 255, 270, 285, 300, 315}
            if HeroLvl() < 10 then
                return dmg[1]
            end 
                
            return dmg[HeroLvl()-9]
        end,
        DmgModAD        = function() return 0.45 end,
        DmgModADBase    = function() return myHero.BonusAttack end,
        DmgModHP        = function(self, Target) return (((1 - (Target.Health / Target.MaxHealth))/7) * 5) end,
        DmgModHPBase    = function(self) return self:Dmg() + (self:DmgModAD() * self:DmgModADBase()) end,
        InInventory     = function(self) return GetItemKey(self.ItemName) ~= nil end,
        ItemKey         = function(self) return GetItemKey(self.ItemName) end,
        DamageType      = DamageType.MAGICALDAMAGE
    },
    KrakenSlayer = {
        Dmg             = function() return 60 end,
        DmgModAD        = function() return 0.45 end,
        DmgModADBase    = function() return myHero.BonusAttack end,
        DamageType      = DamageType.TRUEDAMAGE
    },
    Sheen = {
        DmgModAD        = function() return 1 end,
        DmgModADBase    = function() return myHero.BaseAttack end,
        DamageType      = DamageType.PHYSICALDAMAGE
    }
}

function ItemLib:GetAllItemNames()
	for i = 6 , 11 do
		print(myHero:GetSpellSlot(i).Info.Name)
	end
end