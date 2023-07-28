BuffLib = {
    Summoners = {
        Teleport = function(self, Target)
            local teleport = Target.BuffData:GetBuff("teleport_target")
            return teleport and teleport.Count_Alt > 0
        end
    },
    Runes ={
        PressTheAttack = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("assets/perks/styles/precision/presstheattack/presstheattackdamageamp.lua")
            return buff.Valid
        end
    },
    Items = {
        Zhonyas = function(self, Hero)
            local Zhonyas = Hero.BuffData:GetBuff("zhonyasringshield")
            return Zhonyas.Valid
        end,
        GuardianAngel = function(self, Hero)
            local GA = Hero.BuffData:GetBuff("willrevive")
            return GA and GA.EndTime > 0 and GA.Count_Alt <= 0 
        end,
        KrakenSlayer = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("6672buff")
            return buff and buff.Count_Alt > 0
        end,
    },
    Caitlyn = {
        Trapped = function(self, Hero)
            local TrapDebuff = Hero.BuffData:GetBuff("caitlynyordletrapinternal") 
            return TrapDebuff and TrapDebuff.Count_Alt > 0
        end,
        Netted = function(self, Hero)
            local NetDebuff = Hero.BuffData:GetBuff("CaitlynEntrapmentMissile")
            return NetDebuff and NetDebuff.Count_Alt > 0
        end,
        Headshot = function(self, Hero)
            local HsDebuff = Hero.BuffData:GetBuff("caitlynheadshot")
            return HsDebuff and HsDebuff.Count_Alt > 0
        end
    },
    Twitch = {
        RBuff = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("twitchfullautomatic")
            return buff and buff.Count_Alt > 0
        end,
        Cammouflage = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("globalcamouflage")
            return buff and buff.Count_Alt > 0
        end,
        Passive = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("twitchdeadlyvenom")
            return buff and buff.Count_Alt > 0
        end,
        AmountOfPassiveStacks = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("twitchdeadlyvenom")
            return buff.Count_Int
        end
    },
    Tristana = {
        ChargeBuff = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("tristanaecharge")
            return buff.Valid and buff.Count_Alt > 0
        end,
        AmountOfChargeStacks = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("tristanaecharge")
            local count = buff.Count_Alt

            if count == 0 and buff.Valid then
                return 4
            end

            return count
        end,
    },
    KogMaw = {
        Artillery = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("kogmawlivingartillerycost")
            return buff and buff.Count_Alt > 0
        end,
        ArtilleryStacks = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("kogmawlivingartillerycost")
            return buff.Count_Alt
        end,
        BioArcaneBarage = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("KogMawBioArcaneBarrage")
            return buff and buff.Count_Alt > 0
        end,
        CausticSpittle = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("kogmawcausticspittlecharged")
            return buff and buff.Count_Alt > 0
        end
    },
    Kindred = {
        MarkCounter = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("kindredmarkofthekindredstackcounter")

            if buff.Valid then
                return buff.Count_Int
            end

            return 0
        end,
        HitlistMonsterActiveTracker = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("kindredhitlistmonsteractivetracker")
            return buff.Valid
        end,
        RNoDeath = function(self, Hero)
            local buff = Hero.BuffData:GetBuff("KindredRNoDeathBuff")
            return buff.Valid
        end,
    }
}

function BuffLib:HasNoBuffOfType(Target, BuffTypes)
    for _,bufftype in pairs(BuffTypes) do
        if Target.BuffData:HasBuffOfType(bufftype) then
            return false
        end
    end
    return true
end

function BuffLib:HasOneBuffOfType(Target, BuffTypes)
    for _,bufftype in pairs(BuffTypes) do
        if Target.BuffData:HasBuffOfType(bufftype) then
            return true
        end
    end
    return false
end