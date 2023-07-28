Evade = {

}
-- Evade version 2.3
-- Dmg: 0 == ad, 1 == ap, 3 == mixed, 4 == true, 5 == none
function Evade:__init()
	self.Spells 			={}
	self.Spells['AatroxQWrapperCast'] = { Type = 0, Range = 625, ChampionName = "Aatrox", SpellName = "AatroxQWrapperCast", DisplayName = "Q", Radius = 180, Speed = math.huge, Delay = 0.35, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['AatroxW'] = { Type = 0, Range = 825, ChampionName = "Aatrox", SpellName = "AatroxW", DisplayName = "W", Radius = 80, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['AhriOrbMissile'] = { Type = 0, Range = 880, ChampionName = "Ahri", SpellName = "AhriOrbMissile", DisplayName = "QMissile", Radius = 120, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AhriOrbofDeception'] = { Type = 0, Range = 880, ChampionName = "Ahri", SpellName = "AhriOrbofDeception", DisplayName = "Q", Radius = 120, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AhriSeduce'] = { Type = 0, Range = 975, ChampionName = "Ahri", SpellName = "AhriSeduce", DisplayName = "E", Radius = 60, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AhriSeduceMissile'] = { Type = 0, Range = 975, ChampionName = "Ahri", SpellName = "AhriSeduceMissile", DisplayName = "EMissile", Radius = 60, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AkaliE'] = { Type = 0, Range = 825, ChampionName = "Akali", SpellName = "AkaliE", DisplayName = "E", Radius = 70, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AkaliEMis'] = { Type = 0, Range = 825, ChampionName = "Akali", SpellName = "AkaliEMis", DisplayName = "EMissile", Radius = 70, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AkaliQ'] = { Type = 1, Range = 550, ChampionName = "Akali", SpellName = "AkaliQ", DisplayName = "Q", Radius = 60, Speed = 3200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AkaliQMis'] = { Type = 1, Range = 550, ChampionName = "Akali", SpellName = "AkaliQMis", DisplayName = "QMissile", Radius = 60, Speed = 3200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AkaliR'] = { Type = 0, Range = 525, ChampionName = "Akali", SpellName = "AkaliR", DisplayName = "R", Radius = 65, Speed = 1800, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AkaliRb'] = { Type = 0, Range = 525, ChampionName = "Akali", SpellName = "AkaliRb", DisplayName = "R2", Radius = 65, Speed = 3600, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
    self.Spells['AkshanQMissile'] = { Type = 0, Range = 850,ChampionName ="Akshan", SpellName = "AkshanQMissile", DisplayName = "QMissile", Radius = 65, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
    self.Spells['AkshanQMissileReturn'] = { Type = 0, Range = 850,ChampionName ="Akshan", SpellName = "AkshanQMissileReturn", DisplayName = "QMissileReturn", Radius = 65, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AnnieR'] = { Type = 2, Range = 600, ChampionName = "Annie", SpellName = "AnnieR", DisplayName = "R", Radius = 0, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AnnieW'] = { Type = 0, Range = 600, ChampionName = "Annie", SpellName = "AnnieW", DisplayName = "W", Radius = 120, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ApheliosCalibrumQ'] = { Type = 0, Range = 1450, ChampionName = "Aphelios", SpellName = "ApheliosCalibrumQ", DisplayName = "Q", Radius = 70, Speed = 1850, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['ApheliosRMis'] = { Type = 0, Range = 1300, ChampionName = "Aphelios", SpellName = "ApheliosRMis", DisplayName = "RMis", Radius = 155, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['AurelionSolR'] = { Type = 0, Range = 1300, ChampionName = "AurelionSol", SpellName = "AurelionSolR", DisplayName = "R", Radius = 140, Speed = 2200, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AurelionSolQMissile'] = { Type = 0, Range = 25000, ChampionName = "AurelionSol", SpellName = "AurelionSolQMissile", DisplayName = "QMissile", Radius = 220, Speed = 1000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	-- self.Spells['AurelionSolStarMissile'] = { Type = 1, Range = 50, ChampionName = "AurelionSol", SpellName = "AurelionSolStarMissile", DisplayName = "AurelionSolStarMissile", Radius = 50, Speed = 600, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AzirR'] = { Type = 0, Range = 500, ChampionName = "Azir", SpellName = "AzirR", DisplayName = "R", Radius = 250, Speed = 1400, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AzirQ'] = { Type = 0, Range = 740, ChampionName = "Azir", SpellName = "AzirQ", DisplayName = "Q", Radius = 300, Speed = 1400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BandageToss'] = { Type = 0, Range = 1100, ChampionName = "Amumu", SpellName = "BandageToss", DisplayName = "Q", Radius = 90, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SadMummyBandageToss'] = { Type = 0, Range = 1100, ChampionName = "Amumu", SpellName = "SadMummyBandageToss", DisplayName = "Q", Radius = 90, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BardQ'] = { Type = 0, Range = 950, ChampionName = "Bard", SpellName = "BardQ", DisplayName = "Q", Radius = 60, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BardQMissile'] = { Type = 0, Range = 950, ChampionName = "Bard", SpellName = "BardQMissile", DisplayName = "QMissile", Radius = 60, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BardR'] = { Type = 2, Range = 3400, ChampionName = "Bard", SpellName = "BardR", DisplayName = "R", Radius = 350, Speed = 2100, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['BardRMissile'] = { Type = 2, Range = 3400, ChampionName = "Bard", SpellName = "BardRMissile", DisplayName = "RMissile", Radius = 350, Speed = 2100, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['BlindMonkQOne'] = { Type = 0, Range = 1100, ChampionName = "LeeSin", SpellName = "BlindMonkQOne", DisplayName = "Q", Radius = 60, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['BrandQ'] = { Type = 0, Range = 1050, ChampionName = "Brand", SpellName = "BrandQ", DisplayName = "Q", Radius = 60, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BrandQMissile'] = { Type = 0, Range = 1050, ChampionName = "Brand", SpellName = "BrandQMissile", DisplayName = "QMissile", Radius = 60, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BrandW'] = { Type = 2, Range = 900, ChampionName = "Brand", SpellName = "BrandW", DisplayName = "W", Radius = 250, Speed = math.huge, Delay = 0.85, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['BraumQ'] = { Type = 0, Range = 1000, ChampionName = "Braum", SpellName = "BraumQ", DisplayName = "Q", Radius = 70, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BraumQMissile'] = { Type = 0, Range = 1000, ChampionName = "Braum", SpellName = "BraumQMissile", DisplayName = "QMissile", Radius = 70, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BraumR'] = { Type = 0, Range = 1250, ChampionName = "Braum", SpellName = "BraumR", DisplayName = "R", Radius = 115, Speed = 1400, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BraumRMissile'] = { Type = 0, Range = 1250, ChampionName = "Braum", SpellName = "BraumRMissile", DisplayName = "RMissile", Radius = 115, Speed = 1400, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['CaitlynEntrapment'] = { Type = 0, Range = 750, ChampionName = "Caitlyn", SpellName = "CaitlynEntrapment", DisplayName = "E", Radius = 70, Speed = 1600, Delay = 0.15, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['CaitlynE'] = { Type = 0, Range = 900, ChampionName = "Caitlyn", SpellName = "CaitlynE", DisplayName = "E", Radius = 140, Speed = 1600, Delay = 0.15, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['CaitlynPiltoverPeacemaker'] = { Type = 0, Range = 1250, ChampionName = "Caitlyn", SpellName = "CaitlynPiltoverPeacemaker", DisplayName = "Q", Radius = 120, Speed = 2200, Delay = 0.625, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['CaitlynQ'] = { Type = 0, Range = 1250, ChampionName = "Caitlyn", SpellName = "CaitlynQ", DisplayName = "Q", Radius = 100, Speed = 2200, Delay = 0.625, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['CaitlynYordleTrap'] = { Type = 2, Range = 800, ChampionName = "Caitlyn", SpellName = "CaitlynYordleTrap", DisplayName = "W", Radius = 75, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['CaitlynW'] = { Type = 2, Range = 800, ChampionName = "Caitlyn", SpellName = "CaitlynW", DisplayName = "W", Radius = 125, Speed = math.huge, Delay = 0.25, DangerLevel = 3, TTL = 40, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['CamilleEMissile'] = { Type = 0, Range = 925, ChampionName = "Camille", SpellName = "CamilleEMissile", DisplayName = "EMissile", Radius = 60, Speed = 1900, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['CassiopeiaQ'] = { Type = 2, Range = 850, ChampionName = "Cassiopeia", SpellName = "CassiopeiaQ", DisplayName = "Q", Radius = 185, Speed = math.huge, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['CassiopeiaR'] = { Type = 1, Range = 825, ChampionName = "Cassiopeia", SpellName = "CassiopeiaR", DisplayName = "R", Radius = 0, Speed = math.huge, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['CassiopeiaW'] = { Type = 2, Range = 800, ChampionName = "Cassiopeia", SpellName = "CassiopeiaW", DisplayName = "W", Radius = 170, Speed = 2500, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['DariusAxeGrabCone'] = { Type = 0, Range = 550, ChampionName = "Darius", SpellName = "DariusAxeGrabCone", DisplayName = "E", Radius = 150, Speed = 2500, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['CurseoftheSadMummy'] = { Type = 2, Range = 0, ChampionName = "Amumu", SpellName = "CurseoftheSadMummy", DisplayName = "R", Radius = 550, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['DianaQInnerMissile'] = { Type = 2, Range = 900, ChampionName = "Diana", SpellName = "DianaQInnerMissile", DisplayName = "QMissile", Radius = 200, Speed = 2400, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['DianaQ'] = { Type = 2, Range = 900, ChampionName = "Diana", SpellName = "DianaQ", DisplayName = "Q", Radius = 200, Speed = 2400, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['DravenDoubleShot'] = { Type = 0, Range = 1050, ChampionName = "Draven", SpellName = "DravenDoubleShot", DisplayName = "E", Radius = 150, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['DravenDoubleShotMissile'] = { Type = 0, Range = 1050, ChampionName = "Draven", SpellName = "DravenDoubleShotMissile", DisplayName = "EMissile", Radius = 150, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['DravenR'] = { Type = 0, Range = 25000, ChampionName = "Draven", SpellName = "DravenR", DisplayName = "R", Radius = 160, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['DravenRCast'] = { Type = 0, Range = 25000, ChampionName = "Draven", SpellName = "DravenRCast", DisplayName = "RCast", Radius = 160, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['DrMundoQ'] = { Type = 0, Range = 900, ChampionName = "DrMundo", SpellName = "DrMundoQ", DisplayName = "Q", Radius = 80, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['DrMundoQMis'] = { Type = 0, Range = 900, ChampionName = "DrMundo", SpellName = "DrMundoQMis", DisplayName = "QMis", Radius = 80, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['DrMundoEAttack'] = { Type = 0, Range = 900, ChampionName = "DrMundo", SpellName = "DrMundoEAttack", DisplayName = "EAttack", Radius = 100, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['EkkoQ'] = { Type = 0, Range = 1175, ChampionName = "Ekko", SpellName = "EkkoQ", DisplayName = "Q", Radius = 110, Speed = 1650, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['EkkoQMis'] = { Type = 0, Range = 1175, ChampionName = "Ekko", SpellName = "EkkoQMis", DisplayName = "QMis", Radius = 110, Speed = 1650, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['EkkoW'] = { Type = 2, Range = 1600, ChampionName = "Ekko", SpellName = "EkkoW", DisplayName = "W", Radius = 400, Speed = math.huge, Delay = 3.35, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['EkkoWMis'] = { Type = 2, Range = 1600, ChampionName = "Ekko", SpellName = "EkkoWMis", DisplayName = "WMis", Radius = 400, Speed = math.huge, Delay = 3.35, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['EliseHumanE'] = { Type = 0, Range = 1075, ChampionName = "Elise", SpellName = "EliseHumanE", DisplayName = "HumanE", Radius = 55, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['EliseHumanW'] = { Type = 0, Range = 1000, ChampionName = "Elise", SpellName = "EliseHumanW", DisplayName = "HumanW", Radius = 220, Speed = 1300, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['EnchantedCrystalArrow'] = { Type = 0, Range = 25000, ChampionName = "Ashe", SpellName = "EnchantedCrystalArrow", DisplayName = "R", Radius = 130, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['EvelynnQ'] = { Type = 0, Range = 800, ChampionName = "Evelynn", SpellName = "EvelynnQ", DisplayName = "Q", Radius = 60, Speed = 2400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['EvelynnR'] = { Type = 1, Range = 450, ChampionName = "Evelynn", SpellName = "EvelynnR", DisplayName = "R", Radius = 180, Speed = math.huge, Delay = 0.35, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['EzrealQ'] = { Type = 0, Range = 1150,  ChampionName = "Ezreal", SpellName = "EzrealQ", DisplayName = "Q", Radius = 60, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['EzrealR'] = { Type = 0, Range = 25000, ChampionName = "Ezreal", SpellName = "EzrealR", DisplayName = "R", Radius = 160, Speed = 2000, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['EzrealW'] = { Type = 0, Range = 1150,  ChampionName = "Ezreal", SpellName = "EzrealW", DisplayName = "W", Radius = 120, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['FeralScream'] = { Type = 1, Range = 650, ChampionName = "Chogath", SpellName = "FeralScream", DisplayName = "W", Radius = 0, Speed = math.huge, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['FizzR'] = { Type = 0, Range = 1300, ChampionName = "Fizz", SpellName = "FizzR", DisplayName = "R", Radius = 150, Speed = 1300, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['FizzRMissile'] = { Type = 0, Range = 1300, ChampionName = "Fizz", SpellName = "FizzRMissile", DisplayName = "RMissile", Radius = 150, Speed = 1300, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['FlashFrostSpell'] = { Type = 0, Range = 1100, ChampionName = "Anivia", SpellName = "FlashFrostSpell", DisplayName = "Q", Radius = 150, Speed = 850, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ForcePulse'] = { Type = 1, Range = 600, ChampionName = "Kassadin", SpellName = "ForcePulse", DisplayName = "E", Radius = 0, Speed = math.huge, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GalioE'] = { Type = 0, Range = 650, ChampionName = "Galio", SpellName = "GalioE", DisplayName = "E", Radius = 150, Speed = 1700, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GalioQ'] = { Type = 2, Range = 825, ChampionName = "Galio", SpellName = "GalioQ", DisplayName = "Q", Radius = 235, Speed = 1150, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['GalioQMissileR'] = { Type = 2, Range = 825, ChampionName = "Galio", SpellName = "GalioQMissileR", DisplayName = "QMissileR", Radius = 235, Speed = 1150, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['GnarBigQMissile'] = { Type = 0, Range = 1125, ChampionName = "Gnar", SpellName = "GnarBigQMissile", DisplayName = "BigQMissile", Radius = 90, Speed = 2100, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['GnarBigW'] = { Type = 0, Range = 575, ChampionName = "Gnar", SpellName = "GnarBigW", DisplayName = "BigW", Radius = 100, Speed = math.huge, Delay = 0.6, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['GnarQMissile'] = { Type = 0, Range = 1125, ChampionName = "Gnar", SpellName = "GnarQMissile", DisplayName = "QMissile", Radius = 65, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['GnarQMissileReturn'] = { Type = 0, Range = 1125, ChampionName = "Gnar", SpellName = "GnarQMissileReturn", DisplayName = "QMissileReturn", Radius = 65, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['GnarR'] = { Type = 2, Range = 500, ChampionName = "Gnar", SpellName = "GnarR", DisplayName = "R", Radius = 475, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['GragasQ'] = { Type = 2, Range = 850, ChampionName = "Gragas", SpellName = "GragasQ", DisplayName = "Q", Radius = 275, Speed = 1000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GragasQMissile'] = { Type = 2, Range = 850, ChampionName = "Gragas", SpellName = "GragasQMissile", DisplayName = "QMissile", Radius = 275, Speed = 1000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GragasR'] = { Type = 2, Range = 1000, ChampionName = "Gragas", SpellName = "GragasR", DisplayName = "R", Radius = 400, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GragasRBoom'] = { Type = 2, Range = 1000, ChampionName = "Gragas", SpellName = "GragasRBoom", DisplayName = "RBoom", Radius = 400, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GravesChargeShot'] = { Type = 0, Range = 1000, ChampionName = "Graves", SpellName = "GravesChargeShot", DisplayName = "R", Radius = 100, Speed = 2100, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['GravesChargeShotShot'] = { Type = 0, Range = 1000, ChampionName = "Graves", SpellName = "GravesChargeShotShot", DisplayName = "R", Radius = 100, Speed = 2100, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['GravesClusterShotSoundMissile'] = { Type = 0, Range = 700, ChampionName = "Graves", SpellName = "GravesClusterShotSoundMissile", DisplayName = "RMissile", Radius = 20, Speed = 2000, Delay = 0.095, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['GravesQLineSpell'] = { Type = 0, Range = 700, DisplayName = "GravesQLineSpell", Radius = 20, ChampionName = "Graves", SpellName = "Q", Speed = 2000, Delay = 0.095, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['GravesSmokeGrenade'] = { Type = 2, Range = 950, ChampionName = "Graves", SpellName = "GravesSmokeGrenade", DisplayName = "W", Radius = 250, Speed = 1500, Delay = 0.15, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GravesSmokeGrenadeBoom'] = { Type = 2, Range = 950, ChampionName = "Graves", SpellName = "GravesSmokeGrenadeBoom", DisplayName = "WBoom", Radius = 250, Speed = 1500, Delay = 0.15, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['GwenQ'] = { Type = 0, Range = 450, ChampionName = "Gwen", SpellName = "GwenQ", DisplayName = "Q", Radius = 120, Speed = math.huge, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 4}
	self.Spells['GwenRMis'] = { Type = 0, Range = 1450, ChampionName = "Gwen", SpellName = "GwenRMis", DisplayName = "RMis", Radius = 120, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HecarimUltMissile'] = { Type = 0, Range = 1650, ChampionName = "Hecarim", SpellName = "HecarimUltMissile", DisplayName = "RMissile", Radius = 280, Speed = 1100, Delay = 0.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HeimerdingerE'] = { Type = 2, Range = 970, ChampionName = "Heimerdinger", SpellName = "HeimerdingerE", DisplayName = "E", Radius = 250, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HeimerdingerESpell'] = { Type = 2, Range = 970, ChampionName = "Heimerdinger", SpellName = "HeimerdingerESpell", DisplayName = "ESpell", Radius = 250, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HeimerdingerESpell_ult'] = { Type = 2, Range = 970, ChampionName = "Heimerdinger", SpellName = "HeimerdingerESpell_ult", DisplayName = "ESpell_ult", Radius = 250, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HeimerdingerEUlt'] = { Type = 2, Range = 970, ChampionName = "Heimerdinger", SpellName = "HeimerdingerEUlt", DisplayName = "EUlt", Radius = 250, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HeimerdingerW'] = { Type = 0, Range = 1325, ChampionName = "Heimerdinger", SpellName = "HeimerdingerW", DisplayName = "W", Radius = 100, Speed = 2050, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['HeimerdingerWAttack2'] = { Type = 0, Range = 1325, ChampionName = "Heimerdinger", SpellName = "HeimerdingerWAttack2", DisplayName = "WAttack2", Radius = 100, Speed = 2050, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['HowlingGaleSpell'] = { Type = 0, Range = 995, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 667, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1} --(janna??)
	self.Spells['HowlingGaleSpell10'] = { Type = 0, Range = 1445, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 967, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell11'] = { Type = 0, Range = 1495, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 1000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell12'] = { Type = 0, Range = 1545, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 1033, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell13'] = { Type = 0, Range = 1595, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 1067, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell14'] = { Type = 0, Range = 1645, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 1100, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell15'] = { Type = 0, Range = 1695, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 1133, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell16'] = { Type = 0, Range = 1745, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 1167, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell2'] = { Type = 0, Range = 1045, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 700, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell3'] = { Type = 0, Range = 1095, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 733, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell4'] = { Type = 0, Range = 1145, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 767, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell5'] = { Type = 0, Range = 1195, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 800, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell6'] = { Type = 0, Range = 1245, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 833, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell7'] = { Type = 0, Range = 1295, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 867, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell8'] = { Type = 0, Range = 1345, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 900, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell9'] = { Type = 0, Range = 1395, ChampionName = "Janna", SpellName = "HowlingGaleSpell", DisplayName = "HowlingGaleSpell", Radius = 120, Speed = 933, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['IllaoiE'] = { Type = 0, Range = 900, ChampionName = "Illaoi", SpellName = "IllaoiE", DisplayName = "E", Radius = 50, Speed = 1900, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 5}
	self.Spells['IllaoiEMis'] = { Type = 0, Range = 900, ChampionName = "Illaoi", SpellName = "IllaoiEMis", DisplayName = "EMis", Radius = 50, Speed = 1900, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 5}
	self.Spells['IllaoiQ'] = { Type = 0, Range = 850, ChampionName = "Illaoi", SpellName = "IllaoiQ", DisplayName = "Q", Radius = 100, Speed = math.huge, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['InfectedCleaverMissile'] = { Type = 0, Range = 975, ChampionName = "DrMundo", SpellName = "InfectedCleaverMissile", DisplayName = "Q", Radius = 60, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['IreliaR'] = { Type = 0, Range = 950, ChampionName = "Irelia", SpellName = "IreliaR", DisplayName = "R", Radius = 160, Speed = 2000, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['IreliaW2'] = { Type = 0, Range = 775, ChampionName = "Irelia", SpellName = "IreliaW2", DisplayName = "W2", Radius = 120, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['IvernQ'] = { Type = 0, Range = 1075, ChampionName = "Ivern", SpellName = "IvernQ", DisplayName = "Q", Radius = 80, Speed = 1300, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['JarvanIVDragonStrike'] = { Type = 0, Range = 770, ChampionName = "JarvanIV", SpellName = "JarvanIVDragonStrike", DisplayName = "Q", Radius = 70, Speed = math.huge, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['JavelinToss'] = { Type = 0, Range = 1500, ChampionName = "Nidalee", SpellName = "JavelinToss", DisplayName = "E", Radius = 40, Speed = 1300, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['JayceShockBlast'] = { Type = 0, Range = 1050, ChampionName = "Jayce", SpellName = "JayceShockBlast", DisplayName = "Q", Radius = 70, Speed = 1450, Delay = 0.214, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['JayceShockBlastMis'] = { Type = 0, Range = 1050, ChampionName = "Jayce", SpellName = "JayceShockBlastMis", DisplayName = "Q", Radius = 70, Speed = 1450, Delay = 0.214, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['JhinE'] = { Type = 2, Range = 750, ChampionName = "Jhin", SpellName = "JhinE", DisplayName = "E", Radius = 130, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['JhinETrap'] = { Type = 2, Range = 750, ChampionName = "Jhin", SpellName = "JhinETrap", DisplayName = "ETrap", Radius = 130, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['JhinRShotMis'] = { Type = 0, Range = 3500, ChampionName = "Jhin", SpellName = "JhinRShotMis", DisplayName = "RShotMis", Radius = 80, Speed = 5000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['JhinRShotMis4'] = { Type = 0, Range = 3500, ChampionName = "Jhin", SpellName = "JhinRShotMis4", DisplayName = "RShotMis4", Radius = 80, Speed = 5000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['JhinW'] = { Type = 0, Range = 2550, ChampionName = "Jhin", SpellName = "JhinW", DisplayName = "W", Radius = 40, Speed = 5000, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['JinxEHit'] = { Type = 2, Range = 900, ChampionName = "Jinx", SpellName = "JinxEHit", DisplayName = "EHit", Radius = 120, Speed = 1750, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['JinxR'] = { Type = 0, Range = 25000, ChampionName = "Jinx", SpellName = "JinxR", DisplayName = "R", Radius = 140, Speed = 1700, Delay = 0.6, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['JinxWMissile'] = { Type = 0, Range = 1450, ChampionName = "Jinx", SpellName = "JinxWMissile", DisplayName = "WMissile", Radius = 60, Speed = 3300, Delay = 0.6, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['KalistaMysticShot'] = { Type = 0, Range = 1150, ChampionName = "Kalista", SpellName = "KalistaMysticShot", DisplayName = "Q", Radius = 40, Speed = 2400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['KalistaMysticShotMisTrue'] = { Type = 0, Range = 1150, ChampionName = "Kalista", SpellName = "KalistaMysticShotMisTrue", DisplayName = "Q", Radius = 40, Speed = 2400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['KaisaW'] = { Type = 0, Range = 3000, ChampionName = "Kaisa", SpellName = "KaisaW", DisplayName = "W", Radius = 200, Speed = 1750, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['KarmaQ'] = { Type = 0, Range = 950, ChampionName = "Karma", SpellName = "KarmaQ", DisplayName = "Q", Radius = 60, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['KarmaQMantra'] = { Type = 0, Range = 950, ChampionName = "Karma", SpellName = "KarmaQMantra", DisplayName = "QMantra", Radius = 80, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['KarmaQMissile'] = { Type = 0, Range = 950, ChampionName = "Karma", SpellName = "KarmaQMissile", DisplayName = "QMissile", Radius = 60, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['KarmaQMissileMantra'] = { Type = 0, Range = 950, ChampionName = "Karma", SpellName = "KarmaQMissileMantra", DisplayName = "QMissileMantra", Radius = 80, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['KarthusLayWasteA1'] = { Type = 2, Range = 875, ChampionName = "Karthus", SpellName = "KarthusLayWasteA1", DisplayName = "Q", Radius = 175, Speed = math.huge, Delay = 0.9, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['KarthusLayWasteA2'] = { Type = 2, Range = 875, ChampionName = "Karthus", SpellName = "KarthusLayWasteA2", DisplayName = "Q", Radius = 175, Speed = math.huge, Delay = 0.9, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['KarthusLayWasteA3'] = { Type = 2, Range = 875, ChampionName = "Karthus", SpellName = "KarthusLayWasteA3", DisplayName = "Q", Radius = 175, Speed = math.huge, Delay = 0.9, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['KayleQ'] = { Type = 0, Range = 850, ChampionName = "Kayle", SpellName = "KayleQ", DisplayName = "Q", Radius = 60, Speed = 2000, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['KayleQMisVFX'] = { Type = 0, Range = 850, ChampionName = "Kayle", SpellName = "KayleQMisVFX", DisplayName = "Q", Radius = 60, Speed = 2000, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['KaynW'] = { Type = 0, Range = 700, ChampionName = "Kayn", SpellName = "KaynW", DisplayName = "W", Radius = 90, Speed = math.huge, Delay = 0.55, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['KennenShurikenHurlMissile1'] = { Type = 0, Range = 1050, ChampionName = "Kennen", SpellName = "KennenShurikenHurlMissile1", DisplayName = "Q", Radius = 50, Speed = 1700, Delay = 0.175, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['KhazixW'] = { Type = 0, Range = 1000, ChampionName = "Khazix", SpellName = "KhazixW", DisplayName = "W", Radius = 70, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['KhazixWLong'] = { Type = 3, Range = 1000, ChampionName = "Khazix", SpellName = "KhazixWLong", DisplayName = "WLong", Radius = 70, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['KhazixWMissile'] = { Type = 0, Range = 1000, ChampionName = "Khazix", SpellName = "KhazixWMissile", DisplayName = "WMissile", Radius = 70, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['KledQ'] = { Type = 0, Range = 800, ChampionName = "Kled", SpellName = "KledQ", DisplayName = "Q", Radius = 45, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['KledQMissile'] = { Type = 0, Range = 800, ChampionName = "Kled", SpellName = "KledQMissile", DisplayName = "QMissile", Radius = 45, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['KledRiderQ'] = { Type = 1, Range = 700, ChampionName = "Kled", SpellName = "KledRiderQ", DisplayName = "RiderQ", Radius = 0, Speed = 3000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['KledRiderQMissile'] = { Type = 1, Range = 700, ChampionName = "Kled", SpellName = "KledRiderQMissile", DisplayName = "RiderQMissile", Radius = 0, Speed = 3000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['KogMawLivingArtillery'] = { Type = 2, Range = 1300, ChampionName = "KogMaw", SpellName = "KogMawLivingArtillery", DisplayName = "R", Radius = 200, Speed = math.huge, Delay = 1.1, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['KogMawQ'] = { Type = 0, Range = 1175, ChampionName = "KogMaw", SpellName = "KogMawQ", DisplayName = "Q", Radius = 70, Speed = 1650, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['KogMawVoidOozeMissile'] = { Type = 0, Range = 1360, ChampionName = "KogMaw", SpellName = "KogMawVoidOozeMissile", DisplayName = "E", Radius = 120, Speed = 1400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Landslide'] = { Type = 2, Range = 400, ChampionName = "Malphite", SpellName = "Landslide", DisplayName = "E", Radius = 400, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Landslide'] = { Type = 2, Range = 400, ChampionName = "Malphite", SpellName = "Landslide", DisplayName = "E", Radius = 400, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LeblancE'] = { Type = 0, Range = 925, ChampionName = "LeblancE", SpellName = "LeblancE", DisplayName = "E", Radius = 55, Speed = 1750, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LeblancEMissile'] = { Type = 0, Range = 925, ChampionName = "LeblancE", SpellName = "LeblancEMissile", DisplayName = "EMissile", Radius = 55, Speed = 1750, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LeblancRE'] = { Type = 0, Range = 925, ChampionName = "LeblancE", SpellName = "LeblancRE", DisplayName = "RE", Radius = 55, Speed = 1750, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LeblancREMissile'] = { Type = 0, Range = 925, ChampionName = "LeblancE", SpellName = "LeblancREMissile", DisplayName = "REMissile", Radius = 55, Speed = 1750, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LeonaSolarFlare'] = { Type = 2, Range = 1200, ChampionName = "Leona", SpellName = "LeonaSolarFlare", DisplayName = "R", Radius = 300, Speed = math.huge, Delay = 0.85, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LeonaZenithBlade'] = { Type = 0, Range = 875, ChampionName = "Leona", SpellName = "LeonaZenithBlade", DisplayName = "E", Radius = 100, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LilliaE'] = { Type = 0, Range = 10000, ChampionName = "Lillia", SpellName = "LilliaE", DisplayName = "E", Radius = 75, Speed = 1400, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['LilliaERollingMissile'] = { Type = 0, Range = 10000, ChampionName = "Lillia", SpellName = "LilliaERollingMissile", DisplayName = "ERollingMissile", Radius = 75, Speed = 1400, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LissandraEMissile'] = { Type = 0, Range = 1025, ChampionName = "Lissandra", SpellName = "LissandraEMissile", DisplayName = "EMissile", Radius = 125, Speed = 850, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['LissandraQMissile'] = { Type = 0, Range = 750, ChampionName = "Lissandra", SpellName = "LissandraQMissile", DisplayName = "QMissile", Radius = 75, Speed = 2200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LucianQ'] = { Type = 0, Range = 900, ChampionName = "Lucian", SpellName = "LucianQ", DisplayName = "Q", Radius = 65, Speed = math.huge, Delay = 0.35, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['LucianRMissile'] = { Type = 0, Range = 1200, ChampionName = "Lucian", SpellName = "LucianRMissile", DisplayName = "RMissile", Radius = 110, Speed = 2800, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['LucianW'] = { Type = 0, Range = 900, ChampionName = "Lucian", SpellName = "LucianW", DisplayName = "W", Radius = 80, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['LucianWMissile'] = { Type = 0, Range = 900, ChampionName = "Lucian", SpellName = "LucianWMissile", DisplayName = "WMissile", Radius = 80, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['LuluQ'] = { Type = 0, Range = 925, ChampionName = "Lulu", SpellName = "LuluQ", DisplayName = "Q", Radius = 60, Speed = 1450, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuluQMissile'] = { Type = 0, Range = 925, ChampionName = "Lulu", SpellName = "LuluQMissile", DisplayName = "QMissile", Radius = 60, Speed = 1450, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxLightBinding'] = { Type = 0, Range = 1300, ChampionName = "Lux", SpellName = "LuxLightBinding", DisplayName = "Q", Radius = 140, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxLightBindingMis'] = { Type = 0, Range = 1300, ChampionName = "Lux", SpellName = "LuxLightBindingMis", DisplayName = "QMis", Radius = 140, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxLightBindingDummy'] = { Type = 2, Range = 1175, ChampionName = "Lux", SpellName = "LuxLightBindingDummy", DisplayName = "E", Radius = 50, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxLightStrikeKugel'] = { Type = 2, Range = 1100, ChampionName = "Lux", SpellName = "LuxLightStrikeKugel", DisplayName = "E", Radius = 300, Speed = 1200, Delay = 0.25, TTL = 5, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['LuxMaliceCannonMis'] = { Type = 0, Range = 3400, ChampionName = "Lux", SpellName = "LuxMaliceCannonMis", DisplayName = "R", Radius = 200, Speed = math.huge, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['LuxRMis'] = { Type = 0, Range = 3400, ChampionName = "Lux", SpellName = "LuxRMis", DisplayName = "R", Radius = 200, Speed = math.huge, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['MalzaharQ'] = { Type = 4, Range = 900, ChampionName = "Malzahar", SpellName = "MalzaharQ", DisplayName = "Q", Radius = 400, Speed = 1600, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MalzaharQMissile'] = { Type = 4, Range = 900, ChampionName = "Malzahar", SpellName = "MalzaharQMissile", DisplayName = "QMissile", Radius = 400, Speed = 1600, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MaokaiQ'] = { Type = 0, Range = 600, ChampionName = "Maokai", SpellName = "MaokaiQ", DisplayName = "Q", Radius = 110, Speed = 1600, Delay = 0.375, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MaokaiQMissile'] = { Type = 0, Range = 600, ChampionName = "Maokai", SpellName = "MaokaiQMissile", DisplayName = "QMissile", Radius = 110, Speed = 1600, Delay = 0.375, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MissFortuneBulletTime'] = { Type = 1, Range = 1400, ChampionName = "MissFortune", SpellName = "MissFortuneBulletTime", DisplayName = "R", Radius = 100, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['MissileBarrageMissile'] = { Type = 0, Range = 1300, ChampionName = "Corki", SpellName = "MissileBarrageMissile", DisplayName = "R", Radius = 40, Speed = 2000, Delay = 0.175, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['MissileBarrageMissile2'] = { Type = 0, Range = 1500, ChampionName = "Corki", SpellName = "MissileBarrageMissile2", DisplayName = "R2", Radius = 40, Speed = 2000, Delay = 0.175, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['PhosphorusBomb'] = { Type = 2, Range = 825, ChampionName = "Corki", SpellName = "PhosphorusBomb", DisplayName = "PhosphorusBomb", Radius = 250, Speed = 1000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['MordekaiserSyphonOfDestruction'] = { Type = 1, Range = 700, ChampionName = "Mordekaiser", SpellName = "MordekaiserSyphonOfDestruction", DisplayName = "R", Radius = 0, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['MordekaiserEMissile'] = { Type = 0, Range = 900, ChampionName = "Mordekaiser", SpellName = "MordekaiserEMissile", DisplayName = "EMissile", Radius = 100, Speed = 2000, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MordekaiserE'] = { Type = 0, Range = 900, ChampionName = "Mordekaiser", SpellName = "MordekaiserE", DisplayName = "E", Radius = 100, Speed = 2000, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MorganaQ'] = { Type = 0, Range = 1250, ChampionName = "Morgana", SpellName = "MorganaQ", DisplayName = "Q", Radius = 70, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MorganaW'] = { Type = 2, Range = 900, ChampionName = "Morgana", SpellName = "MorganaW", DisplayName = "W", Radius = 275, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['NamiQ'] = { Type = 2, Range = 875, ChampionName = "Nami", SpellName = "NamiQ", DisplayName = "Q", Radius = 180, Speed = math.huge, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['NamiRMissile'] = { Type = 0, Range = 2750, ChampionName = "Nami", SpellName = "NamiRMissile", DisplayName = "RMissile", Radius = 250, Speed = 850, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['NautilusAnchorDragMissile'] = { Type = 0, Range = 1200, ChampionName = "Nautilus", SpellName = "NautilusAnchorDragMissile", DisplayName = "Q", Radius = 100, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['NeekoE'] = { Type = 0, Range = 1000, ChampionName = "Neeko", SpellName = "NeekoE", DisplayName = "E", Radius = 65, Speed = 1400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['NeekoQ'] = { Type = 2, Range = 800, ChampionName = "Neeko", SpellName = "NeekoQ", DisplayName = "Q", Radius = 200, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['NocturneDuskbringer'] = { Type = 0, Range = 1200, ChampionName = "Nocturne", SpellName = "NocturneDuskbringer", DisplayName = "Q", Radius = 60, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['NunuR'] = { Type = 2, Range = 600, ChampionName = "Nunu", SpellName = "NunuR", DisplayName = "R", Radius = 650, Speed = math.huge, Delay = 3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['OlafAxeThrow'] = { Type = 0, Range = 1000, ChampionName = "Olaf", SpellName = "OlafAxeThrow", DisplayName = "Q", Radius = 90, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['OlafAxeThrowCast'] = { Type = 0, Range = 1000, ChampionName = "Olaf", SpellName = "OlafAxeThrowCast", DisplayName = "QCast", Radius = 90, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['OrnnE'] = { Type = 0, Range = 800, ChampionName = "Ornn", SpellName = "OrnnE", DisplayName = "E", Radius = 150, Speed = 1800, Delay = 0.35, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['OrnnQ'] = { Type = 0, Range = 800, ChampionName = "Ornn", SpellName = "OrnnQ", DisplayName = "Q", Radius = 65, Speed = 1800, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['OrnnRCharge'] = { Type = 0, Range = 2500, ChampionName = "Ornn", SpellName = "OrnnRCharge", DisplayName = "RCharge", Radius = 200, Speed = 1650, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['PantheonQMissile'] = { Type = 0, Range = 1200, ChampionName = "Pantheon", SpellName = "PantheonQMissile", DisplayName = "QMissile", Radius = 70, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['PantheonE'] = { Type = 1, Range = 400, ChampionName = "Pantheon", SpellName = "PantheonE", DisplayName = "E", Radius = 0, Speed = math.huge, Delay = 0.389, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['PhosphorusBombMissile'] = { Type = 2, Range = 825, ChampionName = "Corki", SpellName = "PhosphorusBombMissile", DisplayName = "Q", Radius = 250, Speed = 1000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['PoppyQSpell'] = { Type = 0, Range = 430, ChampionName = "Poppy", SpellName = "PoppyQSpell", DisplayName = "QSpell", Radius = 100, Speed = math.huge, Delay = 0.332, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['PoppyRSpell'] = { Type = 0, Range = 1200, ChampionName = "Poppy", SpellName = "PoppyRSpell", DisplayName = "RSpell", Radius = 100, Speed = 2000, Delay = 0.33, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['PoppyRSpellMissile'] = { Type = 0, Range = 1200, ChampionName = "Poppy", SpellName = "PoppyRSpellMissile", DisplayName = "RSpellMissile", Radius = 100, Speed = 2000, Delay = 0.33, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['PoroSnowballMissile'] = { Type = 0, Range = 1600, ChampionName = "MISC", SpellName = "PoroSnowballMissile", DisplayName = "PoroSnowballMissile", Radius = 60, Speed = math.huge, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['Pulverize'] = { Type = 2, Range = 0, ChampionName = "ChoGath", SpellName = "Pulverize", DisplayName = "Q", Radius = 365, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['PykeE'] = { Type = 0, Range = 25000, ChampionName = "Pyke", SpellName = "PykeE", DisplayName = "E", Radius = 110, Speed = 3000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['PykeEMissile'] = { Type = 0, Range = 25000, ChampionName = "Pyke", SpellName = "PykeEMissile", DisplayName = "EMissile", Radius = 110, Speed = 3000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['PykeQMelee'] = { Type = 0, Range = 400, ChampionName = "Pyke", SpellName = "PykeQMelee", DisplayName = "QMelee", Radius = 70, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['PykeQRange'] = { Type = 0, Range = 1100, ChampionName = "Pyke", SpellName = "PykeQRange", DisplayName = "QRange", Radius = 100, Speed = 2000, Delay = 0.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['PykeR'] = { Type = 2, Range = 750, ChampionName = "Pyke", SpellName = "PykeR", DisplayName = "R", Radius = 350, Speed = math.huge, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 4}
	self.Spells['QiyanaQ'] = { Type = 0, Range = 600, ChampionName = "Qiyana", SpellName = "QiyanaQ", DisplayName = "Q", Radius = 75, Speed = math.huge, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['QiyanaQ_Water'] = { Type = 0, Range = 1100, ChampionName = "Qiyana", SpellName = "QiyanaQ_Water", DisplayName = "Q_Water", Radius = 75, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['QiyanaQ_Rock'] = { Type = 0, Range = 1100, ChampionName = "Qiyana", SpellName = "QiyanaQ_Rock", DisplayName = "Q_Rock", Radius = 75, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['QiyanaQ_Grass'] = { Type = 0, Range = 1100, ChampionName = "Qiyana", SpellName = "QiyanaQ_Grass", DisplayName = "Q_Grass", Radius = 75, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['QiyanaQ_ExplosionMissile'] = { Type = 0, Range = 1100, ChampionName = "Qiyana", SpellName = "QiyanaQ_ExplosionMissile", DisplayName = "Q_ExplosionMissile", Radius = 75, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['QiyanaRMis'] = { Type = 0, Range = 900, ChampionName = "Qiyana", SpellName = "QiyanaRMis", DisplayName = "RMis", Radius = 325, Speed = 3500, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['QiyanaRWallHitMis'] = { Type = 0, Range = 900, ChampionName = "Qiyana", SpellName = "QiyanaRWallHitMis", DisplayName = "RWallHitMis", Radius = 325, Speed = 3500, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['QuinnQ'] = { Type = 0, Range = 1025, ChampionName = "Quinn", SpellName = "QuinnQ", DisplayName = "Q", Radius = 75, Speed = 1550, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['RakanQ'] = { Type = 0, Range = 850, ChampionName = "Rakan", SpellName = "RakanQ", DisplayName = "Q", Radius = 75, Speed = 1850, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['RakanQMis'] = { Type = 0, Range = 850, ChampionName = "Rakan", SpellName = "RakanQMis", DisplayName = "QMis", Radius = 75, Speed = 1850, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['RakanW'] = { Type = 2, Range = 650, ChampionName = "Rakan", SpellName = "RakanW", DisplayName = "W", Radius = 265, Speed = math.huge, Delay = 0.7, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RakanWCast'] = { Type = 2, Range = 650, ChampionName = "Rakan", SpellName = "RakanWCast", DisplayName = "WCast", Radius = 265, Speed = math.huge, Delay = 0.7, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RellQ_VFXMis'] = { Type = 0, Range = 800, ChampionName = "Rell", SpellName = "RellQ_VFXMis", DisplayName = "QMis", Radius = 90, Speed = math.huge, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['RenataQ'] = { Type = 0, Range = 900, ChampionName = "Renata", SpellName = "RenataQ", DisplayName = "Q", Radius = 140, Speed = 1450, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RenataE'] = { Type = 0, Range = 1000, ChampionName = "Renata", SpellName = "RenataE", DisplayName = "E", Radius = 220, Speed = 1450, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['RekSaiQBurrowed'] = { Type = 0, Range = 1625, ChampionName = "RekSai", SpellName = "RekSaiQBurrowed", DisplayName = "Q", Radius = 65, Speed = 1950, Delay = 0.125, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['RekSaiQBurrowedMis'] = { Type = 0, Range = 1625, ChampionName = "RekSai", SpellName = "RekSaiQBurrowedMis", DisplayName = "Q", Radius = 65, Speed = 1950, Delay = 0.125, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['RengarE'] = { Type = 0, Range = 1000, ChampionName = "Rengar", SpellName = "RengarE", DisplayName = "E", Radius = 70, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['RengarEMis'] = { Type = 0, Range = 1000, ChampionName = "Rengar", SpellName = "RengarEMis", DisplayName = "EMis", Radius = 70, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['RiftWalk'] = { Type = 2, Range = 500, ChampionName = "Kassadin", SpellName = "RiftWalk", DisplayName = "R", Radius = 250, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['RocketGrab'] = { Type = 0, Range = 1100, ChampionName = "Blitzcrank", SpellName = "RocketGrab", DisplayName = "Q", Radius = 70, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RocketGrabMissile'] = { Type = 0, Range = 1100, ChampionName = "Blitzcrank", SpellName = "RocketGrabMissile", DisplayName = "QMissile", Radius = 70, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RumbleGrenade'] = { Type = 0, Range = 850, ChampionName = "Rumble", SpellName = "RumbleGrenade", DisplayName = "E", Radius = 60, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RumbleGrenadeMissile'] = { Type = 0, Range = 850, ChampionName = "Rumble", SpellName = "RumbleGrenadeMissile", DisplayName = "EMissile", Radius = 60, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Rupture'] = { Type = 2, Range = 950, ChampionName = "Chogath", SpellName = "Rupture", DisplayName = "Q", Radius = 250, Speed = math.huge, Delay = 1.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RyzeQ'] = { Type = 0, Range = 1000, ChampionName = "Ryze", SpellName = "RyzeQ", DisplayName = "Q", Radius = 55, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['SamiraQGun'] = { Type = 0, Range = 950, ChampionName = "Samira", SpellName = "SamiraQGun", DisplayName = "QGun", Radius = 60, Speed = 2600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['SealFateMissile'] = { Type = 0, Range = 1450, ChampionName = "TwistedFate", SpellName = "SealFateMissile", DisplayName = "Q", Radius = 40, Speed = 1000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 3}
	self.Spells['SejuaniR'] = { Type = 0, Range = 1300, ChampionName = "Sejuani", SpellName = "SejuaniR", DisplayName = "R", Radius = 120, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SejuaniRMissile'] = { Type = 0, Range = 1300, ChampionName = "Sejuani", SpellName = "SejuaniRMissile", DisplayName = "RMissile", Radius = 120, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SennaQCast'] = { Type = 0, Range = 1300, ChampionName = "Senna", SpellName = "SennaQCast", DisplayName = "Q", Radius = 100, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['SennaW'] = { Type = 0, Range = 1300, ChampionName = "Senna", SpellName = "SennaW", DisplayName = "W", Radius = 70, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['SennaR'] = { Type = 0, Range = 5000, ChampionName = "Senna", SpellName = "SennaR", DisplayName = "R", Radius = 160, Speed = 20000, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['SeraphineQCastEcho'] = { Type = 2, Range = 900, ChampionName = "Seraphine", SpellName = "SeraphineQCastEcho", DisplayName = "Q", Radius = 400, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SeraphineQCast'] = { Type = 2, Range = 900, ChampionName = "Seraphine", SpellName = "SeraphineQCast", DisplayName = "Q", Radius = 400, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SeraphineECast'] = { Type = 0, Range = 1300, ChampionName = "Seraphine", SpellName = "SeraphineECast", DisplayName = "E", Radius = 150, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SeraphineEMissile'] = { Type = 0, Range = 1300, ChampionName = "Seraphine", SpellName = "SeraphineEMissile", DisplayName = "EMissile", Radius = 150, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SeraphineR'] = { Type = 0, Range = 1200, ChampionName = "Seraphine", SpellName = "SeraphineR", DisplayName = "R", Radius = 250, Speed = 1600, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SeraphineRPostCast'] = { Type = 0, Range = 1200, ChampionName = "Seraphine", SpellName = "SeraphineRPostCast", DisplayName = "R", Radius = 250, Speed = 1600, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ShenE'] = { Type = 0, Range = 600, ChampionName = "Shen", SpellName = "ShenE", DisplayName = "E", Radius = 60, Speed = 2000, Delay = 0.1, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['ShyvanaFireball'] = { Type = 0, Range = 925, ChampionName = "Shyvana", SpellName = "ShyvanaFireball", DisplayName = "E", Radius = 60, Speed = 1575, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ShyvanaFireballDragon2'] = { Type = 0, Range = 975, ChampionName = "Shyvana", SpellName = "ShyvanaFireballDragon2", DisplayName = "E2", Radius = 60, Speed = 1575, Delay = 0.333, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ShyvanaFireballDragonMissile'] = { Type = 0, Range = 975, ChampionName = "Shyvana", SpellName = "ShyvanaFireballDragonMissile", DisplayName = "EMissile", Radius = 60, Speed = 1575, Delay = 0.333, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ShyvanaFireballMissile'] = { Type = 0, Range = 925, ChampionName = "Shyvana", SpellName = "ShyvanaFireballMissile", DisplayName = "E2Missile", Radius = 60, Speed = 1575, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ShyvanaTransformLeap'] = { Type = 0, Range = 850, ChampionName = "Shyvana", SpellName = "ShyvanaTransformLeap", DisplayName = "R", Radius = 150, Speed = 700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SionE'] = { Type = 0, Range = 800, ChampionName = "Sion", SpellName = "SionE", DisplayName = "E", Radius = 80, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SionEMissile'] = { Type = 0, Range = 800, ChampionName = "Sion", SpellName = "SionEMissile", DisplayName = "EMissile", Radius = 80, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SionQ'] = { Type = 0, Range = 750, ChampionName = "Sion", SpellName = "SionQ", DisplayName = "Q", Radius = 150, Speed = math.huge, Delay = 2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['SivirQ'] = { Type = 0, Range = 1250, ChampionName = "Sivir", SpellName = "SivirQ", DisplayName = "Q", Radius = 90, Speed = 1350, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['SivirQMissile'] = { Type = 0, Range = 1250, ChampionName = "Sivir", SpellName = "SivirQMissile", DisplayName = "QMissile", Radius = 90, Speed = 1350, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['SkarnerFractureMissile'] = { Type = 0, Range = 1000, ChampionName = "Skarner", SpellName = "SkarnerFractureMissile", DisplayName = "E", Radius = 70, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SonaR'] = { Type = 0, Range = 1000, ChampionName = "Sona", SpellName = "SonaR", DisplayName = "R", Radius = 140, Speed = 2400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SonaRMissile'] = { Type = 0, Range = 1000, ChampionName = "Sona", SpellName = "SonaRMissile", DisplayName = "RMissile", Radius = 140, Speed = 2400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SorakaQ'] = { Type = 2, Range = 810, ChampionName = "Soraka", SpellName = "SorakaQ", DisplayName = "Q", Radius = 235, Speed = 1150, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['SorakaQMissile'] = { Type = 2, Range = 810, ChampionName = "Soraka", SpellName = "SorakaQMissile", DisplayName = "QMissile", Radius = 235, Speed = 1150, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['SwainE'] = { Type = 0, Range = 950, ChampionName = "Swain", SpellName = "SwainE", DisplayName = "E", Radius = 110, Speed = 935, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SwainQ'] = { Type = 1, Range = 725, ChampionName = "Swain", SpellName = "SwainQ", DisplayName = "Q", Radius = 0, Speed = 5000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['SwainW'] = { Type = 2, Range = 3500, ChampionName = "Swain", SpellName = "SwainW", DisplayName = "W", Radius = 300, Speed = math.huge, Delay = 1.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Swipe'] = { Type = 1, Range = 350, ChampionName = "Nidalee", SpellName = "Swipe", DisplayName = "E", Radius = 0, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['SylasQ'] = { Type = 0, Range = 800, ChampionName = "Sylas", SpellName = "SylasQ", DisplayName = "Q", Radius = 80, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SylasE2'] = { Type = 0, Range = 800, ChampionName = "Sylas", SpellName = "SylasE2", DisplayName = "E2", Radius = 50, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}	
	self.Spells['SyndraE'] = { Type = 1, Range = 700, ChampionName = "Syndra", SpellName = "SyndraE", DisplayName = "E", Radius = 0, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SyndraEMissile'] = { Type = 1, Range = 700, ChampionName = "Syndra", SpellName = "SyndraEMissile", DisplayName = "EMissile", Radius = 0, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SyndraESphereMissile'] = { Type = 0, Range = 950, ChampionName = "Syndra", SpellName = "SyndraESphereMissile", DisplayName = "ESphereMissile", Radius = 100, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SyndraQSpell'] = { Type = 2, Range = 800, ChampionName = "Syndra", SpellName = "SyndraQSpell", DisplayName = "QSpell", Radius = 200, Speed = math.huge, Delay = 0.625, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['TahmKenchQ'] = { Type = 0, Range = 800, ChampionName = "TahmKench", SpellName = "TahmKenchQ", DisplayName = "Q", Radius = 70, Speed = 2800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TahmKenchQMissile'] = { Type = 0, Range = 800, ChampionName = "TahmKench", SpellName = "TahmKenchQMissile", DisplayName = "QMissile", Radius = 70, Speed = 2800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TaliyahE'] = { Type = 1, Range = 800, ChampionName = "Taliyah", SpellName = "TaliyahE", DisplayName = "E", Radius = 0, Speed = 2000, Delay = 0.45, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TaliyahQ'] = { Type = 0, Range = 1000, ChampionName = "Taliyah", SpellName = "TaliyahQ", DisplayName = "Q", Radius = 100, Speed = 3600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['TaliyahQMis'] = { Type = 0, Range = 1000, ChampionName = "Taliyah", SpellName = "TaliyahQMis", DisplayName = "QMis", Radius = 100, Speed = 3600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['TaliyahR'] = { Type = 0, Range = 3000, ChampionName = "Taliyah", SpellName = "TaliyahR", DisplayName = "R", Radius = 120, Speed = 1700, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['TaliyahRMis'] = { Type = 0, Range = 3000, ChampionName = "Taliyah", SpellName = "TaliyahRMis", DisplayName = "RMis", Radius = 120, Speed = 1700, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['TaliyahWVC'] = { Type = 2, Range = 900, ChampionName = "Taliyah", SpellName = "TaliyahWVC", DisplayName = "W", Radius = 150, Speed = math.huge, Delay = 0.85, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TalonW'] = { Type = 1, Range = 650, ChampionName = "Talon", SpellName = "TalonW", DisplayName = "W", Radius = 75, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['TalonWMissileOne'] = { Type = 1, Range = 650, ChampionName = "Talon", SpellName = "TalonWMissileOne", DisplayName = "WMissileOne", Radius = 75, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['TaricE'] = { Type = 0, Range = 575, ChampionName = "Taric", SpellName = "TaricE", DisplayName = "E", Radius = 40, Speed = math.huge, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ThreshE'] = { Type = 0, Range = 500, ChampionName = "Thresh", SpellName = "ThreshE", DisplayName = "E", Radius = 110, Speed = math.huge, Delay = 0.389, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ThreshEMissile1'] = { Type = 0, Range = 500, ChampionName = "Thresh", SpellName = "ThreshEMissile1", DisplayName = "EMissile1", Radius = 110, Speed = math.huge, Delay = 0.389, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ThreshQMissile'] = { Type = 0, Range = 1100, ChampionName = "Thresh", SpellName = "ThreshQMissile", DisplayName = "QMissile", Radius = 80, Speed = 1900, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TristanaW'] = { Type = 2, Range = 900, ChampionName = "Tristana", SpellName = "TristanaW", DisplayName = "W", Radius = 300, Speed = 1100, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Slash'] = { Type = 0, Range = 700, ChampionName = "Tryndamere", SpellName = "Slash", DisplayName = "E", Radius = 93, Speed = 1000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0} --Tryndamere 
	self.Spells['UrgotE'] = { Type = 0, Range = 475, ChampionName = "Urgot", SpellName = "UrgotE", DisplayName = "E", Radius = 100, Speed = 1500, Delay = 0.45, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['UrgotQ'] = { Type = 2, Range = 800, ChampionName = "Urgot", SpellName = "UrgotQ", DisplayName = "Q", Radius = 180, Speed = math.huge, Delay = 0.6, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['UrgotQMissile'] = { Type = 2, Range = 800, ChampionName = "Urgot", SpellName = "UrgotQMissile", DisplayName = "QMissile", Radius = 180, Speed = math.huge, Delay = 0.6, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['UrgotR'] = { Type = 0, Range = 1600, ChampionName = "Urgot", SpellName = "UrgotR", DisplayName = "R", Radius = 80, Speed = 3200, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['VarusE'] = { Type = 2, Range = 925, ChampionName = "Varus", SpellName = "VarusE", DisplayName = "E", Radius = 260, Speed = 1500, Delay = 0.242, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['VarusEMissile'] = { Type = 2, Range = 925, ChampionName = "Varus", SpellName = "VarusEMissile", DisplayName = "EMissile", Radius = 260, Speed = 1500, Delay = 0.242, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['VarusQMissile'] = { Type = 0, Range = 1525, ChampionName = "Varus", SpellName = "VarusQMissile", DisplayName = "QMissile", Radius = 70, Speed = 1900, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['VarusR'] = { Type = 0, Range = 1200, ChampionName = "Varus", SpellName = "VarusR", DisplayName = "R", Radius = 120, Speed = 1950, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VarusRMissile'] = { Type = 0, Range = 1200, ChampionName = "Varus", SpellName = "VarusRMissile", DisplayName = "RMissile", Radius = 120, Speed = 1950, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VeigarBalefulStrike'] = { Type = 0, Range = 900, ChampionName = "Veigar", SpellName = "VeigarBalefulStrike", DisplayName = "Q", Radius = 70, Speed = 2200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['VeigarBalefulStrikeMis'] = { Type = 0, Range = 900, ChampionName = "Veigar", SpellName = "VeigarBalefulStrikeMis", DisplayName = "QMis", Radius = 70, Speed = 2200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['VeigarDarkMatterCastLockout'] = { Type = 2, Range = 900, ChampionName = "Veigar", SpellName = "VeigarDarkMatterCastLockout", DisplayName = "W", Radius = 200, Speed = math.huge, Delay = 1.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['VeigarEventHorizon'] = { Type = 5, Range = 700, ChampionName = "Veigar", SpellName = "VeigarEventHorizon", DisplayName = "E", Radius = 375, Speed = math.huge, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
	self.Spells['VelkozE'] = { Type = 2, Range = 800, ChampionName = "Velkoz", SpellName = "VelkozE", DisplayName = "E", Radius = 185, Speed = math.huge, Delay = 0.8, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VelkozEMissile'] = { Type = 2, Range = 800, ChampionName = "Velkoz", SpellName = "VelkozEMissile", DisplayName = "EMissile", Radius = 185, Speed = math.huge, Delay = 0.8, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VelkozQ'] = { Type = 0, Range = 1050, ChampionName = "Velkoz", SpellName = "VelkozQ", DisplayName = "Q", Radius = 50, Speed = 1300, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VelkozQMissile'] = { Type = 0, Range = 1050, ChampionName = "Velkoz", SpellName = "VelkozQMissile", DisplayName = "QMissile", Radius = 50, Speed = 1300, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VelkozQMissileSplit'] = { Type = 0, Range = 1100, ChampionName = "Velkoz", SpellName = "VelkozQMissileSplit", DisplayName = "QMissileSplit", Radius = 45, Speed = 2100, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VelkozW'] = { Type = 0, Range = 1200, ChampionName = "Velkoz", SpellName = "VelkozW", DisplayName = "W", Radius = 100, Speed = 2000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['VelkozWMissile'] = { Type = 0, Range = 1200, ChampionName = "Velkoz", SpellName = "VelkozWMissile", DisplayName = "WMissile", Radius = 100, Speed = 2000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['VexQ'] = { Type = 0, Range = 1200, ChampionName = "Vex", SpellName = "VexQ", DisplayName = "VexQ", Radius = 120, Speed = 1500, Delay = 0.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VexE'] = { Type = 2, Range = 800, ChampionName = "Vex", SpellName = "VexE", DisplayName = "VexE", Radius = 250, Speed = math.huge, Delay = 1.0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VexR'] = { Type = 0, Range = 3000, ChampionName = "Vex", SpellName = "VexR", DisplayName = "VexR", Radius = 110, Speed = 2000, Delay = 0.2, DangerLevel = 5, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ViegoQ'] = { Type = 0, Range = 600, ChampionName = "Viego", SpellName = "ViegoQ", DisplayName = "Q", Radius = 63, Speed = math.huge, Delay = 0.35, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['ViegoWMis'] = { Type = 0, Range = 1000, ChampionName = "Viego", SpellName = "ViegoWMis", DisplayName = "WMis", Radius = 85, Speed = 1300, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ViegoEMissile'] = { Type = 0, Range = 775, ChampionName = "Viego", SpellName = "ViegoEMissile", DisplayName = "EMissile", Radius = 250, Speed = 1600, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 5}
	self.Spells['ViktorDeathRayMissile'] = { Type = 0, Range = 750, ChampionName = "Viktor", SpellName = "ViktorDeathRayMissile", DisplayName = "EMissile", Radius = 80, Speed = 1050, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ViktorGravitonField'] = { Type = 2, Range = 800, ChampionName = "Viktor", SpellName = "ViktorGravitonField", DisplayName = "W", Radius = 270, Speed = math.huge, Delay = 1.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Volley'] = { Type = 0, Range = 1200, ChampionName = "Ashe", SpellName = "Volley", DisplayName = "W", Radius = 20, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VolleyAttack'] = { Type = 0, Range = 1200, ChampionName = "Ashe", SpellName = "VolleyAttack", DisplayName = "WAttack", Radius = 20, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['VolleyRightAttack'] = { Type = 0, Range = 1200, ChampionName = "Ashe", SpellName = "VolleyRightAttack", DisplayName = "WRightAttack", Radius = 20, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['WarwickR'] = { Type = 0, Range = 3000, ChampionName = "Warwick", SpellName = "WarwickR", DisplayName = "R", Radius = 55, Speed = 1800, Delay = 0.1, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['XayahQ'] = { Type = 0, Range = 1100, ChampionName = "Xayah", SpellName = "XayahQ", DisplayName = "Q", Radius = 45, Speed = 2075, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['XerathArcaneBarrage2'] = { Type = 2, Range = 1000, ChampionName = "Xerath", SpellName = "XerathArcaneBarrage2", DisplayName = "W", Radius = 235, Speed = math.huge, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['XerathLocusPulse'] = { Type = 2, Range = 5600, ChampionName = "Xerath", SpellName = "XerathLocusPulse", DisplayName = "R", Radius = 200, Speed = math.huge, Delay = 0.7, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	-- self.Spells['XerathArcanopulseChargeUp'] = { Type = 2, Range = 5600, ChampionName = "Xerath", SpellName = "XerathArcanopulseChargeUp", DisplayName = "R", Radius = 200, Speed = math.huge, Delay = 0.7, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['XerathMageSpear'] = { Type = 0, Range = 1050, ChampionName = "Xerath", SpellName = "XerathMageSpear", DisplayName = "E", Radius = 70, Speed = 1400, Delay = 0.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TestCubeRender10Vision'] = { Type = 0, Range = 1400, ChampionName = "Xerath", SpellName = "TestCubeRender10Vision", DisplayName = "Q", Radius = 100, Speed = 1600, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['XerathMageSpearMissile'] = { Type = 0, Range = 1050, ChampionName = "Xerath", SpellName = "XerathMageSpearMissile", DisplayName = "E", Radius = 70, Speed = 1400, Delay = 0.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['XinZhaoW'] = { Type = 0, Range = 900, ChampionName = "XinZhao", SpellName = "XinZhaoW", DisplayName = "W", Radius = 40, Speed = 5000, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['YasuoQ3Mis'] = { Type = 0, Range = 1100, ChampionName = "Yasuo", SpellName = "YasuoQ3Mis", DisplayName = "Q3Mis", Radius = 90, Speed = 1200, Delay = 0.318, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['YasuoQ1'] = { Type = 0, Range = 400, ChampionName = "Yasuo", SpellName = "YasuoQ1", DisplayName = "Q1", Radius = 100, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['YoneQ'] = { Type = 0, Range = 950, ChampionName = "Yone", SpellName = "YoneQ", DisplayName = "Q", Radius = 100, Speed = 5000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['YoneQ3Missile'] = { Type = 0, Range = 950, ChampionName = "Yone", SpellName = "YoneQ3Missile", DisplayName = "Q3Missile", Radius = 100, Speed = 5000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['YoneR'] = { Type = 0, Range = 1000, ChampionName = "Yone", SpellName = "YoneR", DisplayName = "R", Radius = 140, Speed = math.huge, Delay = 0.75, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['ZacQ'] = { Type = 0, Range = 800, ChampionName = "Zac", SpellName = "ZacQ", DisplayName = "Q", Radius = 120, Speed = 2800, Delay = 0.33, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZacQMissile'] = { Type = 0, Range = 800, ChampionName = "Zac", SpellName = "ZacQMissile", DisplayName = "QMissile", Radius = 120, Speed = 2800, Delay = 0.33, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZedQ'] = { Type = 0, Range = 900, ChampionName = "Zed", SpellName = "ZedQ", DisplayName = "Q", Radius = 50, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['ZedQMissile'] = { Type = 0, Range = 900, ChampionName = "Zed", SpellName = "ZedQMissile", DisplayName = "QMissile", Radius = 50, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['ZedW'] = { Type = 0, Range = 700, ChampionName = "Zed", SpellName = "ZedW", DisplayName = "W", Radius = 60, Speed = 1750, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['ZedWMissile'] = { Type = 0, Range = 700, ChampionName = "Zed", SpellName = "ZedWMissile", DisplayName = "WMissile", Radius = 60, Speed = 1750, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['ZiggsE'] = { Type = 2, Range = 900, ChampionName = "Ziggs", SpellName = "ZiggsE", DisplayName = "E", Radius = 250, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZiggsQ'] = { Type = 0, Range = 1050, ChampionName = "Ziggs", SpellName = "ZiggsQ", DisplayName = "Q", Radius = 100, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZiggsQSpell'] = { Type = 2, Range = 850, ChampionName = "Ziggs", SpellName = "ZiggsQSpell", DisplayName = "QSpell", Radius = 120, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZiggsR'] = { Type = 2, Range = 5000, ChampionName = "Ziggs", SpellName = "ZiggsR", DisplayName = "R", Radius = 480, Speed = 1550, Delay = 0.375, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZiggsRBoom'] = { Type = 2, Range = 5000, ChampionName = "Ziggs", SpellName = "ZiggsRBoom", DisplayName = "RBoom", Radius = 480, Speed = 1550, Delay = 0.375, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZiggsW'] = { Type = 2, Range = 1000, ChampionName = "Ziggs", SpellName = "ZiggsW", DisplayName = "W", Radius = 240, Speed = 1750, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZileanQ'] = { Type = 2, Range = 900, ChampionName = "Zilean", SpellName = "ZileanQ", DisplayName = "Q", Radius = 150, Speed = math.huge, Delay = 0.8, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZileanQMissile'] = { Type = 2, Range = 900, ChampionName = "Zilean", SpellName = "ZileanQMissile", DisplayName = "QMissile", Radius = 150, Speed = math.huge, Delay = 0.8, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZoeE'] = { Type = 2, Range = 800, ChampionName = "Zoe", SpellName = "ZoeE", DisplayName = "E", Radius = 250, Speed = 1700, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZoeEMis'] = { Type = 2, Range = 800, ChampionName = "Zoe", SpellName = "ZoeEMis", DisplayName = "EMis", Radius = 250, Speed = 1700, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZoeEc'] = { Type = 2, Range = 800, ChampionName = "Zoe", SpellName = "ZoeEc", DisplayName = "Ec", Radius = 250, Speed = 1700, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZoeEMissile'] = { Type = 0, Range = 800, ChampionName = "Zoe", SpellName = "ZoeEMissile", DisplayName = "EMissile", Radius = 50, Speed = 1700, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZoeQMis2'] = { Type = 0, Range = 800, ChampionName = "Zoe", SpellName = "ZoeQMis2", DisplayName = "QMis2", Radius = 100, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZoeQMis2Warning'] = { Type = 0, Range = 800, ChampionName = "Zoe", SpellName = "ZoeQMis2Warning", DisplayName = "QMis2Warning", Radius = 100, Speed = 1300, Delay = 0., DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZoeQMissile'] = { Type = 0, Range = 800, ChampionName = "Zoe", SpellName = "ZoeQMissile", DisplayName = "QMissile", Radius = 50, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZyraE'] = { Type = 0, Range = 1100, ChampionName = "Zyra", SpellName = "ZyraE", DisplayName = "E", Radius = 70, Speed = 1150, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['ZyraQ'] = { Type = 4, Range = 800, ChampionName = "Zyra", SpellName = "ZyraQ", DisplayName = "Q", Radius = 400, Speed = math.huge, Delay = 0.825, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ZyraR'] = { Type = 2, Range = 700, ChampionName = "Zyra", SpellName = "ZyraR", DisplayName = "R", Radius = 500, Speed = math.huge, Delay = 2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}

	self.EvadeMenu = Menu:CreateMenu("Evade")
	self.Main = self.EvadeMenu:AddSubMenu("Main")
	self.EvadeActive = self.Main:AddCheckbox("Evade Active", 1)
	self.CoreOptions = self.Main:AddSubMenu("Core Options")
	self.DodgeCCOnly = self.CoreOptions:AddCheckbox("Only Dodge CC", 0)
	self.DodgeWithoutKey = self.CoreOptions:AddCheckbox("Dodge while not holding a key", 0)
	self.CoreOptions:AddLabel("Danger Level Sliders explanation")
	self.CoreOptions:AddLabel("Don't Dodge Spells if HP % above slider values")
	self.CoreOptions:AddLabel("and in combo mode and in attack range")
	self.UseDangerLevels = self.CoreOptions:AddCheckbox("Use Danger Levels for Evade", 1)
	self.IgnoreDangerLevelsForCC = self.CoreOptions:AddCheckbox("Ignore Sliders if Spell is CC", 1)
	self.DangerLevel1 = self.CoreOptions:AddSlider("Danger Level 1 HP %", 30, 1, 100, 1)
	self.DangerLevel2 = self.CoreOptions:AddSlider("Danger Level 2 HP %", 40, 1, 100, 1)
	self.DangerLevel3 = self.CoreOptions:AddSlider("Danger Level 3 HP %", 50, 1, 100, 1)
	self.DangerLevel4 = self.CoreOptions:AddSlider("Danger Level 4 HP %", 60, 1, 100, 1)
	self.DangerLevel5 = self.CoreOptions:AddSlider("Danger Level 5 HP %", 75, 1, 100, 1)

	self.Champions = self.EvadeMenu:AddSubMenu("Champion Abilities")

	self.Debug = self.EvadeMenu:AddSubMenu("Debug")
	self.PrintSpells = self.Debug:AddCheckbox("Print Abilities in Console", 1)

	self.HeroMenu = {}
	self.SpellsMenu = {}
	self.DodgeSpells = {}
	self.DrawSpells = {}
	self.DangerLevels = {}

	self.SpellsToDodge = {}

    self.PrevDodgePos = nil
	self.CanEvadeInTime = nil
	self.Timer_LastMove = 0

	self.IsMovePosisitionSetByExternal = false

	self:LoadSettings()
end

function Evade:SaveSettings()
	SettingsManager:CreateSettings("Evade")
	SettingsManager:AddSettingsGroup("Main")
	SettingsManager:AddSettingsInt("Dodge Spells", self.EvadeActive.Value)
	SettingsManager:AddSettingsInt("Only Dodge CC", self.DodgeCCOnly.Value)
	SettingsManager:AddSettingsInt("Dodge While not holding a key", self.DodgeWithoutKey.Value)
	SettingsManager:AddSettingsGroup("Debug")
	SettingsManager:AddSettingsInt("Print Abilities in Console", self.PrintSpells.Value)
end

function Evade:LoadSettings()
	SettingsManager:GetSettingsFile("Evade")
	self.EvadeActive.Value = SettingsManager:GetSettingsInt("Main","Dodge Spells")
	self.DodgeCCOnly.Value = SettingsManager:GetSettingsInt("Main","Only Dodge CC")
	self.DodgeWithoutKey.Value = SettingsManager:GetSettingsInt("Main","Dodge While not holding a key")
	self.PrintSpells.Value = SettingsManager:GetSettingsInt("Debug","Print Abilities in Console")
end

function Evade:GetDist(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Evade:PlayerHasOlafR()
	if myHero.BuffData:GetBuff("OlafRagnarok").Valid then
		return true
    end
	return false
end

function Evade:CalcLinearSpellStartEndPos(StartPos, EndPos, Spell)
	local Range = Spell.Range + myHero.CharData.BoundingRadius * 1.5
	local StartEndVec 					= Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local Distance						= Evade:GetDist(StartPos, EndPos)
	local StartEndVecNormalized 		= Vector3.new(StartEndVec.x / Distance, 0, StartEndVec.z / Distance)	
	EndPos 								= Vector3.new(StartPos.x + (StartEndVecNormalized.x*Range), StartPos.y , StartPos.z + (StartEndVecNormalized.z*Range))
	
	return StartPos, EndPos
end

function Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, RadiusAddition)
	local StartEndVec 				= Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local Distance 					= Evade:GetDist(StartPos,EndPos)
	local StartEndVecNormalized 	= Vector3.new(StartEndVec.x / Distance, 0, StartEndVec.z / Distance)
	local Mod 						= Distance + RadiusAddition
	EndPos 							= Vector3.new(StartPos.x + (StartEndVecNormalized.x * Mod), StartPos.y , StartPos.z + (StartEndVecNormalized.z * Mod))

	local VecX 						= EndPos.x - StartPos.x
	local VecZ 						= EndPos.z - StartPos.z

	local XZVecLength 				= math.sqrt((VecX * VecX) + (VecZ * VecZ))
	VecX = (VecX / XZVecLength) * (Spell.Radius+RadiusAddition)
	VecZ = (VecZ / XZVecLength) * (Spell.Radius+RadiusAddition)

	local Corners3D = {}

	local Corner_1_X = StartPos.x - VecZ
	local Corner_1_Z = StartPos.z + VecX

	local Corner_2_X = StartPos.x + VecZ
	local Corner_2_Z = StartPos.z - VecX

	local Corner_3_X = EndPos.x - VecZ
	local Corner_3_Z = EndPos.z + VecX

	local Corner_4_X = EndPos.x + VecZ
	local Corner_4_Z = EndPos.z - VecX

	Corners3D[1] = Vector3.new(Corner_1_X, StartPos.y, Corner_1_Z)
	Corners3D[2] = Vector3.new(Corner_2_X, StartPos.y, Corner_2_Z)
	Corners3D[3] = Vector3.new(Corner_3_X, StartPos.y, Corner_3_Z)
    Corners3D[4] = Vector3.new(Corner_4_X, StartPos.y ,Corner_4_Z)
    return Corners3D
end

function Evade:CalcLinearSpellHitbox2D(corners3D) 
	local corners2D = {}
	corners2D[1] = Vector3.new()
	corners2D[2] = Vector3.new()
	corners2D[3] = Vector3.new()
	corners2D[4] = Vector3.new()
	Render:World2Screen(corners3D[1], corners2D[1])
	Render:World2Screen(corners3D[2], corners2D[2])
	Render:World2Screen(corners3D[3], corners2D[3])
	Render:World2Screen(corners3D[4], corners2D[4])
	return corners2D
end

function Evade:DrawLineHitbox(corners2D) 
	Render:DrawLine(corners2D[1], corners2D[3], 255, 255, 255, 255)
	Render:DrawLine(corners2D[2], corners2D[4], 255, 255, 255, 255)
	Render:DrawLine(corners2D[1], corners2D[2], 255, 0, 0, 255)
	Render:DrawLine(corners2D[3], corners2D[4], 255, 0, 0, 255)
end

function Evade:CalcLinearMissileStartEndPos(Missile, StartPos, EndPos, Spell)
	local MissilePos 					= Missile.Position
	local CurrentPos 					= Vector3.new(MissilePos.x, StartPos.y, MissilePos.z)
	local StartToCurrentPos 			= Vector3.new(CurrentPos.x - StartPos.x, 0, CurrentPos.z - StartPos.z)
	local DistToStartPos 				= math.sqrt((StartToCurrentPos.x * StartToCurrentPos.x) + (StartToCurrentPos.y * StartToCurrentPos.y) + (StartToCurrentPos.z * StartToCurrentPos.z))

	local StartEndVec 					= Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local Distance						= Evade:GetDist(StartPos, EndPos)
	local StartEndVecNormalized 		= Vector3.new(StartEndVec.x / Distance, 0, StartEndVec.z / Distance)
	
	EndPos 								= Vector3.new(StartPos.x + (StartEndVecNormalized.x*Spell.Range), StartPos.y , StartPos.z + (StartEndVecNormalized.z*Spell.Range))

	return CurrentPos, EndPos
end

function Evade:IsInAOESkillShot(EndPos, Spell)
	local playerPos = myHero.Position
	local RadiusAddition = myHero.CharData.BoundingRadius
	local mousePos = GameHud.MousePos
	if self:GetDist(playerPos, EndPos) <= Spell.Radius * 1.05 then
		return true
	else
		return false
	end
end

function Evade:IsDodgePosInSpell(evadePos, EndPos, Spell)
	local mousePos = GameHud.MousePos
	local waypoint = myHero.AIData.TargetPos
	if self:GetDist(evadePos, EndPos) <= Spell.Radius * 1.05 then
		return true
	else
		return false
	end
end

function Evade:IsMouseOutsideSkillShot(EndPos, Spell)
	local RadiusAddition = myHero.CharData.BoundingRadius
	local mousePos = GameHud.MousePos
	local waypoint = myHero.AIData.TargetPos
	if self:GetDist(mousePos, EndPos) <= Spell.Radius + RadiusAddition then
		return true
	end
end

function Evade:IsDodgePosOutOfSkillShot(StartPos, EndPos, PosToCheck, Spell, myHeroTeamObject)
	if Spell.Type == 2 then
		local isInSkillShot = self:IsDodgePosInSpell(PosToCheck, EndPos, Spell)
		if isInSkillShot then
			return true
		else
			return false
		end
	end
	if Spell.Type == 0 then
		if myHeroTeamObject == nil then
			local RadiusAddition = myHero.CharData.BoundingRadius * 1.35
			local PlayerPos = myHero.Position
			local MousePos = GameHud.MousePos
			if Evade:IsMouseOutsideSkillShot(EndPos, Spell) then
				return false
			end
			if Prediction:PointOnLineSegment(StartPos, EndPos, PosToCheck, Spell.Radius + RadiusAddition) then --If Player in SkillShot move Out
				return true
			else
				if not Prediction:PointOnLineSegment(StartPos, EndPos, GameHud.MousePos, Spell.Radius + RadiusAddition) then --if mouse in skillshot return in skillshot true
					return false
				end
			end
			-- return true
		else
			local RadiusAddition = myHeroTeamObject.CharData.BoundingRadius / 2
			if Prediction:PointOnLineSegment(StartPos, EndPos, PosToCheck, Spell.Radius + RadiusAddition) then --If Player in SkillShot move Out
				return true
			else
				return false
			end
		end
	end
end


function Evade:IsInSkillShot(StartPos, EndPos, PosToCheck, Spell, myHeroTeamObject)
	if Spell.Type == 2 then
		local isInSkillShot = self:IsDodgePosInSpell(PosToCheck, EndPos, Spell)
		if isInSkillShot then
			return true
		else
			return false
		end
	end
	if Spell.Type == 0 then
		if myHeroTeamObject == nil then
			local RadiusAddition = myHero.CharData.BoundingRadius * 1.1
			local PlayerPos = myHero.Position
			local MousePos = GameHud.MousePos
			if Evade:IsMouseOutsideSkillShot(EndPos, Spell) then
				return false
			end
			if Prediction:PointOnLineSegment(StartPos, EndPos, PosToCheck, Spell.Radius + RadiusAddition) then --If Player in SkillShot move Out
				return true
			else
				if not Prediction:PointOnLineSegment(StartPos, EndPos, GameHud.MousePos, Spell.Radius + RadiusAddition) then --if mouse in skillshot return in skillshot true
					return false
				end
			end
			-- return true
		else
			local RadiusAddition = myHeroTeamObject.CharData.BoundingRadius / 2
			if Prediction:PointOnLineSegment(StartPos, EndPos, PosToCheck, Spell.Radius + RadiusAddition) then --If Player in SkillShot move Out
				return true
			else
				return false
			end
		end
	end
end

-- compatibility
function Evade:CantEvade()
    if self.EvadePos ~= nil then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do
            if Hero.Team ~= myHero.Team and self:GetDist(myHero.Position, Hero.Position) <= 1400 then
                local Missiles = ObjectManager.MissileList
                for I, Missile in pairs(Missiles) do
                    if Missile.Team ~= myHero.Team then 
                        local Info = Evade.Spells[Missile.Name]
                        if Info ~= nil and Info.Type == 0 then
                            local EvadePos = self.EvadePos
                            local Multiplier = 100
                            local DistanceForE = self:GetDist(myHero.Position, EvadePos)
                            local TimeToDodge = DistanceForE / myHero.MovementSpeed
                            local TimeToDodge2 = 87 / myHero.MovementSpeed
                            local SpellDistance = self:GetDist(Missile.MissileStartPos, myHero.Position)
                            local TimeToHit = SpellDistance / Info.Speed
                            if TimeToDodge2 > TimeToHit then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

function Evade:IsValidDodgePos(evadePos)
	-- if engine:IsNotWall returns true then its a wall pos and it should be false
	if Engine:IsNotWall(evadePos) == false then
		return false
	end

	-- if the dodge pos is on a minion's pos then return false
	local MinionList = ObjectManager.MinionList
	for i, minion in pairs(MinionList) do 
		if minion.Team ~= myHero.Team and not minion.IsDead and minion.IsTargetable then
			if self:GetDist(myHero.Position, minion.Position) <= 800 then
				if self:GetDist(evadePos, minion.Position) <= minion.CharData.BoundingRadius / 2 then
					return false
				end
			end
		end
	end

	-- if the dodge pos is on a hero's pos then return false
	local HeroList = ObjectManager.HeroList
	for i, Hero in pairs(HeroList) do 
		if Hero.Team ~= myHero.Team and not Hero.IsDead and Hero.IsTargetable then
			if self:GetDist(myHero.Position, Hero.Position) <= 800 then
				if self:GetDist(evadePos, Hero.Position) <= Hero.CharData.BoundingRadius / 2 then
					return false
				end
			end
		end
	end
	return true
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function Evade:GetDodgePos(searchsize)
    local dodgePos = nil
    local limiter = 600
    -- if prevDodgeTime ~= nil then
    --     if GameClock.Time <= prevDodgeTime then
    --         return
    --     end
    -- end
	Orbwalker.BlockAttack = 0
	for i, Spell in pairs(self.SpellsToDodge) do
		local IsDodgePosOutOfSkillShot = self:IsDodgePosOutOfSkillShot(Spell["Data"]["StartPos"], Spell["Data"]["EndPos"], GameHud.MousePos, Spell["Data"]["Spell"], nil)
		if not IsDodgePosOutOfSkillShot then
			local time = GameClock.Time
			local Start     = myHero.Position
			local End       = GameHud.MousePos
			local Vec       = Vector3.new(End.x - Start.x ,End.y - Start.y ,End.z - Start.z) 
			
			local Length    = self:GetDist(Start,End)
			local VecNorm   = Vector3.new(Vec.x / Length,Vec.y / Length,Vec.z / Length)
			local Mod 		= Length / 2
			local Point
			local PointScreen = Vector3.new()
			Point   = Vector3.new(Start.x + (VecNorm.x * Mod) , Start.y + (VecNorm.y * Mod) , Start.z + (VecNorm.z * Mod))	
			if not self:IsDodgePosOutOfSkillShot(Spell["Data"]["StartPos"], Spell["Data"]["EndPos"], Point, Spell["Data"]["Spell"], nil) and self:GetDist(myHero.Position, GameHud.MousePos) > Spell["Data"]["Spell"].Radius then
				local distanceFromMyHeroToNormalizedPoint = self:GetDist(myHero.Position, Point)
				local distanceFromMyHeroToMouse = self:GetDist(myHero.Position, GameHud.MousePos)
				local distanceSkillToMyHero = self:GetDist(Spell["Data"]["StartPos"], myHero.Position)
				local timeToMouse = distanceFromMyHeroToMouse / myHero.MovementSpeed
				local timeToNormalizedPoint = distanceFromMyHeroToNormalizedPoint / myHero.MovementSpeed
				local timeFromSkillShotToMyhero = distanceSkillToMyHero / Spell["Data"]["Spell"].Speed
				-- print('time to mouse', timeToMouse)
				-- print('time to normalizedPoint', timeToNormalizedPoint)
				-- print('time to hit', timeFromSkillShotToMyhero)
				if timeToNormalizedPoint < timeFromSkillShotToMyhero then
					return GameHud.MousePos, Spell["Data"]["Spell"]
				end
			end
		end
	end
    for i=0, limiter, searchsize do 
        for x = 0, 15 do
            if x == 0 then
                --up
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x, PlayerPos.y, PlayerPos.z + i)
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
				-- end
            end
            if x == 1 then
                --down
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x, PlayerPos.y, PlayerPos.z - i)
				local dodgePosFound = false
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 2 then
                --left
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x - i, PlayerPos.y, PlayerPos.z)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 3 then
                --right
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x + i, PlayerPos.y, PlayerPos.z)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 4 then
                --top right i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x + i, PlayerPos.y, PlayerPos.z + i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 5 then
                --bottom left i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x - i, PlayerPos.y, PlayerPos.z - i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 6 then
                --bottom right i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x + i, PlayerPos.y, PlayerPos.z - i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 7 then
                --top left i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x - i, PlayerPos.y, PlayerPos.z + i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
			if x == 8 then
                --top right i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x + i, PlayerPos.y, PlayerPos.z + (i / 2))
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 9 then
                --bottom left i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x - i, PlayerPos.y, PlayerPos.z - (i / 2))
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 10 then
                --bottom right i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x + i, PlayerPos.y, PlayerPos.z - (i / 2))
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 11 then
                --top left i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x - i, PlayerPos.y, PlayerPos.z + (i / 2))
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
			if x == 12 then
                --top right i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x + (i / 2), PlayerPos.y, PlayerPos.z + i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 13 then
                --bottom left i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x - (i / 2), PlayerPos.y, PlayerPos.z - i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 14 then
                --bottom right i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x + (i / 2), PlayerPos.y, PlayerPos.z - i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
            if x == 15 then
                --top left i believe
                local PlayerPos = myHero.Position
                local evadePos = Vector3.new(PlayerPos.x - (i / 2), PlayerPos.y, PlayerPos.z + i)
				-- else
				local prevSpell = nil
				local prevSpellData = nil
				local dodgePosFound = false
				for i, STD in pairs(self.SpellsToDodge) do
					-- if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
					-- 	return evadePos, STD["Data"]["Spell"]
					-- end
					if prevSpell == nil then
						prevSpell = i
					end
					if dodgePosFound then
						if string.find(i, prevSpell) then
							return dodgePos, STD["Data"]["Spell"]
						end
						if not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], dodgePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(dodgePos) then
							return dodgePos, STD["Data"]["Spell"]
						else
							dodgePosFound = false
						end
					end
					if not dodgePosFound and not self:IsDodgePosOutOfSkillShot(STD["Data"]["StartPos"], STD["Data"]["EndPos"], evadePos, STD["Data"]["Spell"], nil) and self:IsValidDodgePos(evadePos) then
						dodgePos = evadePos
						dodgePosFound = true
						prevSpellData = STD["Data"]["Spell"]
						if tablelength(self.SpellsToDodge) <= 1 then
							return dodgePos, STD["Data"]["Spell"]
						end
					end
				end
				if dodgePosFound then
					return dodgePos, prevSpellData
				end
            end
        end
    end
    return nil
end

function Evade:IsAllyOrMinionInSpellShotLine(StartPos, EndPos, Spell)
	local Heros = ObjectManager.HeroList
	local Minions = ObjectManager.MinionList
	for x, allies in pairs(Heros) do
		if allies.Team == myHero.Team and allies.ChampionName ~= myHero.ChampionName and self:GetDist(myHero.Position, allies.Position) <= 1000 then
			if not allies.IsDead and allies.IsTargetable then
				local isInSkillShotHitBox = self:IsInSkillShot(StartPos, EndPos, allies.Position, Spell, allies)
				if isInSkillShotHitBox then
					return true
				end
			end
		end
	end
	for x, minions in pairs(Minions) do
		if minions.Team == myHero.Team and self:GetDist(myHero.Position, minions.Position) <= 1000 then
			if not minions.IsDead and minions.IsTargetable then
				local isInSkillShotHitBox = self:IsInSkillShot(StartPos, EndPos, minions.Position, Spell, minions)
				if isInSkillShotHitBox then
					return true
				end
			end
		end
	end
	return false
end

function Evade:CanEvade(SpellType, dodgePos)
	local additionalFactor = 1.5
	-- todo add activespell for faster calc
	-- if SpellType ~= 0 then return true, dodgePos end
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team then
			local Spell = self.Spells[Hero.ActiveSpell.Info.Name]
			local SpellName = Hero.ActiveSpell.Info.Name
			if Spell ~= nil and self.DodgeSpells[SpellName] and self.DodgeSpells[SpellName].Value == 1 then
				local distanceSpellToPlayer = self:GetDist(Hero.ActiveSpell.StartPos, myHero.Position)
				local timeToHit = nil
				if Spell.Speed == math.huge then
					timeToHit = Spell.Delay
				else
					timeToHit = ((distanceSpellToPlayer / Spell.Speed) + Spell.Delay) * additionalFactor
				end
				local evadePosDistance = self:GetDist(myHero.Position, dodgePos)
				local evadeSpeed = myHero.MovementSpeed
				local evadeTimeToPos = evadePosDistance / evadeSpeed
				-- print("hittime1", timeToHit)
				-- print("evadeTimeToPos1", evadeTimeToPos)
				if evadeTimeToPos < timeToHit then
					self.CanEvadeInTime = true
					self.evadePos = nil
					return true, dodgePos
				end
			end
		end
	end

	local Missiles = ObjectManager.MissileList
	for I, Missile in pairs(Missiles) do
		if Missile.Team ~= myHero.Team then 
			local Spell = self.Spells[Missile.Name]
			local SpellName = Missile.Name
			if Spell ~= nil and self.DodgeSpells[SpellName] and self.DodgeSpells[SpellName].Value == 1 then
				local distanceSpellToPlayer = self:GetDist(Missile.MissileStartPos, myHero.Position)
				local timeToHit = nil
				if Spell.Speed == math.huge then
					timeToHit = Spell.Delay
				else
					timeToHit = ((distanceSpellToPlayer / Spell.Speed) + Spell.Delay) * additionalFactor
				end
				local evadePosDistance = self:GetDist(myHero.Position, dodgePos)
				local evadeSpeed = myHero.MovementSpeed
				local evadeTimeToPos = evadePosDistance / evadeSpeed
				-- print("hittime", timeToHit)
				-- print("evadeTimeToPos", evadeTimeToPos)
				if evadeTimeToPos < timeToHit then
					self.CanEvadeInTime = true
					self.evadePos = nil
					return true, dodgePos
				end
			end
		end
	end
	self.CanEvadeInTime = false
	self.evadePos = dodgePos
	return false, dodgePos
end

function Evade:ClearSpellsFromTable()
	local count = tablelength(self.SpellsToDodge)
	if count == 0 then return end
	for i, Spells in pairs(self.SpellsToDodge) do
		local time = GameClock.Time
		-- add if skill past myhero
		local distanceTargetMyHero = self:GetDist(myHero.Position, Spells["Data"]["EndPos"])
		local distanceSkillEnd = self:GetDist(Spells["Data"]["StartPos"], Spells["Data"]["EndPos"])
		local travelTime = Spells["Data"]["Time"] - time
		local distanceTravelled = Spells["Data"]["Spell"].Speed * travelTime
		if Spells.Type == 0 then
			if distanceTargetMyHero > distanceTravelled + myHero.CharData.BoundingRadius * 3.5 and not Prediction:LineIntersection3D(myHero.Position, GameHud.MousePos, Spells["Data"]["StartPos"], Spells["Data"]["EndPos"]) then
				local spellName = Spells["Data"]["Spell"].SpellName
				self.PrevDodgePos = nil
			end
		end
		if time > Spells["Data"]["Time"] then
			local spellName = Spells["Data"]["Spell"].SpellName
			self.SpellsToDodge[spellName] = nil
			self.PrevDodgePos = nil
		end
	end
end

local isInitDone = false
local xerQ = {}
local xerathPosition = nil

function Evade:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if not isInitDone then
			local HeroList = ObjectManager.HeroList
			for i, Hero in pairs(ObjectManager.HeroList) do
				if Hero.Team ~= myHero.Team then
					if self.HeroMenu[Hero.ChampionName] == nil then
						self.HeroMenu[Hero.ChampionName] = self.Champions:AddSubMenu(Hero.ChampionName)
						for x, Spells in pairs(self.Spells) do
							if Spells.ChampionName == Hero.ChampionName then
								self.SpellsMenu[Spells.SpellName] = self.HeroMenu[Hero.ChampionName]:AddSubMenu(Spells.DisplayName)
								self.DodgeSpells[Spells.SpellName] = self.SpellsMenu[Spells.SpellName]:AddCheckbox("Dodge ".. Spells.DisplayName, 1)
								self.DrawSpells[Spells.SpellName] = self.SpellsMenu[Spells.SpellName]:AddCheckbox("Draw ".. Spells.DisplayName, 1)
								self.DangerLevels[Spells.SpellName] = self.SpellsMenu[Spells.SpellName]:AddSlider("Danger Level ", Spells.DangerLevel, 1, 5, 1)
							end
						end
					end
				end
			end
		end
		isInitDone = true
		local PlayerPos 		= myHero.Position
		local OnlyCC 			= self.DodgeCCOnly.Value
		local EvadeActive 		= self.EvadeActive.Value

		if myHero.ChampionName == "Olaf" then
			if Evade:PlayerHasOlafR() then
				return
			end
		end
		self:ClearSpellsFromTable()
		if myHero.IsDead then return end
		for i, Spell in pairs(self.SpellsToDodge) do
			local isInSkillShot = self:IsInSkillShot(Spell["Data"]["StartPos"], Spell["Data"]["EndPos"], myHero.Position, Spell["Data"]["Spell"], nil)
			if not isInSkillShot then
				Orbwalker.BlockAttack 	= 0
				Orbwalker.MovePosition 	= nil
				self.evadePos = nil
				self.PrevDodgePos = nil
				return
			end
		end
		local Point, Spell = self:GetDodgePos(50)
		if Point and Spell then
			Orbwalker.BlockAttack = 1
			local StickToPrevDodgePos = false
			local rangeFactor = 0
			if self.PrevDodgePos == nil then
				self.PrevDodgePos = Point
			end
			if self.PrevDodgePos ~= Point then
				-- if self:GetDist(self.PrevDodgePos, Point) >= rangeFactor then 
				-- 	StickToPrevDodgePos = true
				-- 	Point = self.PrevDodgePos
				-- end
				StickToPrevDodgePos = true
				Point = self.PrevDodgePos
			end
			if not self:CanEvade(Spell.Type, Point) then
				-- local Point2, Spell2 = self:GetDodgePos(400)
				-- if Point2 and Spell2 then
				-- 	self.evadePos = Point2
				-- 	if self.evadePos ~= nil and Engine:SpellReady("HK_SUMMONER2") then
				-- 		if Spell2.CC ~= 0 then
				-- 			Engine:CastSpell("HK_SUMMONER2", self.evadePos, 0)
				-- 			return
				-- 		end
				-- 	end
				-- end
				return
			else
				if not StickToPrevDodgePos then
					self.PrevDodgePos = Point
					self.evadePos           = Point
					Orbwalker.MovePosition  = Point
					if self.DodgeWithoutKey.Value == 1 then
						if not Engine:IsKeyDown("HK_COMBO") and not Engine:IsKeyDown("HK_HARASS") and not Engine:IsKeyDown("HK_LANECLEAR") and not Engine:IsKeyDown("HK_LASTHIT") and not Engine:IsKeyDown("HK_FLEE") then
							if Orbwalker:CanMove() then
								Engine:MoveClick(Point)
								return
							end
						end
					end
					self.IsMovePosisitionSetByExternal = false
					return
				else
					self.evadePos           = self.PrevDodgePos
					Orbwalker.MovePosition  = self.PrevDodgePos
					if self.DodgeWithoutKey.Value == 1 then
						if not Engine:IsKeyDown("HK_COMBO") and not Engine:IsKeyDown("HK_HARASS") and not Engine:IsKeyDown("HK_LANECLEAR") and not Engine:IsKeyDown("HK_LASTHIT") and not Engine:IsKeyDown("HK_FLEE") then
							if Orbwalker:CanMove() then
								Engine:MoveClick(self.PrevDodgePos)
								return
							end
						end
					end
					self.IsMovePosisitionSetByExternal = false
					return
				end
			end
		end

		-- local Minions = ObjectManager.MinionList
		-- local Heros = ObjectManager.HeroList
		-- local hasXerath = false
		-- for I, Hero in pairs(Heros) do
		-- 	if Hero.ChampionName == "Xerath" and Hero.Team ~= myHero.Team then
		-- 		hasXerath = true
		-- 		xerathPosition = Hero.Position
		-- 	end
		-- end
		-- if hasXerath then
		-- 	for I, Minion in pairs(Minions) do
		-- 		if Minion.ChampionName == "TestCubeRender10Vision" then
		-- 			-- xer q
		-- 			if #xerQ >= 16 then return end
		-- 			table.insert(xerQ, Minion)
		-- 		end
		-- 	end
		-- end

		local Heros = ObjectManager.HeroList
		for I, Hero in pairs(Heros) do
			if Hero.Team ~= myHero.Team then
				local Spell = self.Spells[Hero.ActiveSpell.Info.Name]
				local SpellName = Hero.ActiveSpell.Info.Name
				if SpellName ~= "" and not string.find(SpellName, "Basic") and self.PrintSpells.Value == 1 then
					print('evade table', Spell)
					print('spell name', SpellName)
					-- print('menu item', self.DodgeSpells[SpellName].Value)
				end
				if Spell ~= nil and self.DodgeSpells[SpellName] and self.DodgeSpells[SpellName].Value == 1 then
					local StartPos, EndPos = Evade:CalcLinearSpellStartEndPos(Hero.ActiveSpell.StartPos, Hero.ActiveSpell.EndPos, Spell);
					local dangerLevel = Spell.DangerLevel
					local target = Orbwalker:GetTarget("Combo", myHero.AttackRange + myHero.CharData.BoundingRadius)
					if OnlyCC == 1 and Spell.CC == 0 then
						EvadeActive = 0
					end
					if self.IgnoreDangerLevelsForCC.Value == 1 then
						if Spell.CC == 0 then
							if dangerLevel == 1 then
								local hpMark = self.DangerLevel1.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 2 then
								local hpMark = self.DangerLevel2.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 3 then
								local hpMark = self.DangerLevel3.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 4 then
								local hpMark = self.DangerLevel4.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 5 then
								local hpMark = self.DangerLevel5.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							end
						end
					else
						if dangerLevel == 1 then
							local hpMark = self.DangerLevel1.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 2 then
							local hpMark = self.DangerLevel2.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 3 then
							local hpMark = self.DangerLevel3.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 4 then
							local hpMark = self.DangerLevel4.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 5 then
							local hpMark = self.DangerLevel5.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						end
					end
					if EvadeActive == 1 then -- //If Player in Range of Skillshot
						if Spell.Type == 2 then
							EndPos = Hero.ActiveSpell.EndPos
							local isInSkillShot = self:IsInAOESkillShot(EndPos, Spell)
							if not isInSkillShot then
								Orbwalker.BlockAttack = 0	 
								self.EvadePos           = nil
								Orbwalker.MovePosition  = nil
								break 
							end
						end
						local isInSkillShotHitBox = self:IsInSkillShot(StartPos, EndPos, myHero.Position, Spell, nil)
						if not isInSkillShotHitBox then 
							Orbwalker.BlockAttack = 0	 
							self.EvadePos           = nil
							Orbwalker.MovePosition  = nil
							break 
						end
						if Spell.Type == 0 and Spell.WillCollide == 0 then
							local isInWay = self:IsAllyOrMinionInSpellShotLine(StartPos, EndPos, Spell)
							if isInWay then 
								Orbwalker.BlockAttack = 0	 
								self.EvadePos           = nil
								Orbwalker.MovePosition  = nil
								break 
							end
						end
						local spellDistance = self:GetDist(StartPos, EndPos)
						local spellDuration = spellDistance / Spell.Speed
						spellDuration = spellDuration + Spell.Delay
						if Spell.TTL ~= nil then
							spellDuration = spellDuration + Spell.TTL
						end
						if self.SpellsToDodge[SpellName] == nil then
							self.SpellsToDodge[SpellName] = {
								["Data"] = {
									["StartPos"] = StartPos,
									["EndPos"] = EndPos,
									["Spell"] = Spell,
									["Time"] = spellDuration + GameClock.Time
								}
							}
						end
					end
				else
					-- if SpellName ~= "" and not string.find("Basic", SpellName) then
					-- 	print(SpellName)
					-- end
				end
			end
		end

		local Missiles = ObjectManager.MissileList
		for I, Missile in pairs(Missiles) do
			if Missile.Team ~= myHero.Team then 
				local Spell = self.Spells[Missile.Name]
				local SpellName = Missile.Name
				if SpellName ~= "" and not string.find(SpellName, "Basic") and self.PrintSpells.Value == 1 then
					-- print('evade table2', Spell)
					-- print('spell name2', SpellName)
					-- print('menu item', self.DodgeSpells[SpellName].Value)
				end
				if Spell ~= nil and self.DodgeSpells[SpellName] and self.DodgeSpells[SpellName].Value == 1 then
					local StartPos, EndPos = Evade:CalcLinearMissileStartEndPos(Missile, Missile.MissileStartPos, Missile.MissileEndPos, Spell);
					if OnlyCC == 1 and Spell.CC == 0 then
						EvadeActive = 0
					end
					local dangerLevel = Spell.DangerLevel
					local target = Orbwalker:GetTarget("Combo", myHero.AttackRange + myHero.CharData.BoundingRadius)
					if OnlyCC == 1 and Spell.CC == 0 then
						EvadeActive = 0
					end
					if self.IgnoreDangerLevelsForCC.Value == 1 then
						if Spell.CC == 0 then
							if dangerLevel == 1 then
								local hpMark = self.DangerLevel1.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 2 then
								local hpMark = self.DangerLevel2.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 3 then
								local hpMark = self.DangerLevel3.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 4 then
								local hpMark = self.DangerLevel4.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							elseif dangerLevel == 5 then
								local hpMark = self.DangerLevel5.Value
								local condition = myHero.MaxHealth / 100 * hpMark
								if myHero.Health < condition and target then
									return
								end
							end
						end
					else
						if dangerLevel == 1 then
							local hpMark = self.DangerLevel1.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 2 then
							local hpMark = self.DangerLevel2.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 3 then
							local hpMark = self.DangerLevel3.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 4 then
							local hpMark = self.DangerLevel4.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						elseif dangerLevel == 5 then
							local hpMark = self.DangerLevel5.Value
							local condition = myHero.MaxHealth / 100 * hpMark
							if myHero.Health < condition and target then
								return
							end
						end
					end
					if EvadeActive == 1 then
						if Spell.Type == 2 then
							EndPos = Missile.MissileEndPos
							local isInSkillShot = self:IsInAOESkillShot(EndPos, Spell)
							if not isInSkillShot then
								Orbwalker.BlockAttack = 0	 
								self.EvadePos           = nil
								Orbwalker.MovePosition  = nil
								break 
							end
						end
						local isInSkillShotHitBox = self:IsInSkillShot(StartPos, EndPos, myHero.Position, Spell, nil)
						if not isInSkillShotHitBox then 
							Orbwalker.BlockAttack = 0
							self.EvadePos           = nil
							Orbwalker.MovePosition  = nil
							break
						end
						if Spell.Type == 0 and Spell.WillCollide == 0 then
							local isInWay = self:IsAllyOrMinionInSpellShotLine(StartPos, EndPos, Spell)
							if isInWay then 
								Orbwalker.BlockAttack = 0	
								self.EvadePos           = nil
								Orbwalker.MovePosition  = nil
								break 
							end
						end
						local spellDistance = self:GetDist(StartPos, EndPos)
						local spellDuration = spellDistance / Spell.Speed
						spellDuration = spellDuration + Spell.Delay
						if Spell.TTL ~= nil then
							spellDuration = spellDuration + Spell.TTL
						end
						if self.SpellsToDodge[SpellName] == nil then
							self.SpellsToDodge[SpellName] = {
								["Data"] = {
									["StartPos"] = StartPos,
									["EndPos"] = EndPos,
									["Spell"] = Spell,
									["Time"] = spellDuration + GameClock.Time
								}
							}
						end
					end
				end
			end
		end

		--[[DEBUG SHIT
		local Spell = self.Spells["EzrealR"]
		local Missile = {}
		Missile.MissileStartPos = Vector3.new(400,200,400)
		Missile.MissileEndPos 	= myHero.Position


		if Spell ~= nil and Spell.Type == 0 then
			local StartPos, EndPos = Missile.MissileStartPos, Missile.MissileEndPos
			if OnlyCC == 1 and Spell.CC == 0 then
				EvadeActive = 0
			end
			if EvadeActive == 1 and Prediction:PointOnLineSegment(Missile.MissileStartPos, Missile.MissileEndPos, PlayerPos, Spell.Radius + RadiusAddition * 2) then -- //If Player in Range of Skillshot
				local AdvancedHitbox 	= Evade:CalcLinearSpellHitbox3D(Missile.MissileStartPos, EndPos, Spell, RadiusAddition);
				local Point = self:GetDodgePos(Missile.MissileStartPos, Missile.MissileEndPos, Spell)
				Orbwalker.MovePosition  = Point
				return
			end	
		end
		--]]
		-- self.SpellsToDodge = {}
		Orbwalker.BlockAttack 	= 0
		Orbwalker.MovePosition 	= nil
		self.evadePos = nil
		self.PrevDodgePos = nil
		self.CanEvadeInTime = nil
	end
end

function Evade:OnDraw()
	if GameHud.Minimized == false then

		if self.evadePos ~= nil then
			Render:DrawCircle(self.evadePos, 50,255,255,255,255)
		end

		local Heros = ObjectManager.HeroList
		for I, Hero in pairs(Heros) do
			if Hero.Team ~= myHero.Team then
				local Spell = self.Spells[Hero.ActiveSpell.Info.Name]
				local SpellName = Hero.ActiveSpell.Info.Name
				-- print(SpellName)
				if Spell ~= nil and self.DrawSpells[SpellName] and self.DrawSpells[SpellName].Value == 1 then
					-- local StartPos, EndPos = Evade:CalcLinearSpellStartEndPos(Hero.ActiveSpell.StartPos, Hero.ActiveSpell.EndPos, Spell);
					-- Render:DrawCircle(Hero.ActiveSpell.EndPos, 200,255,255,255,255)
					-- print('x', Hero.ActiveSpell.EndPos.x)
					-- print('y', Hero.ActiveSpell.EndPos.y)
					-- print('z', Hero.ActiveSpell.EndPos.z)
					-- print('hero x', myHero.Position.x)
					-- print('hero y', myHero.Position.y)
					-- print('hero z', myHero.Position.z)
					if Spell.Type == 0 then
						local StartPos, EndPos = Evade:CalcLinearSpellStartEndPos(Hero.ActiveSpell.StartPos, Hero.ActiveSpell.EndPos, Spell);
						local corners3D = Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, 0)
						local corners2D = Evade:CalcLinearSpellHitbox2D(corners3D)
						Evade:DrawLineHitbox(corners2D);
					end
					if Spell.Type == 2 then
						Render:DrawCircle(Hero.ActiveSpell.EndPos,Spell.Radius,255,255,255,255)
					end
				end
			end
		end

		local Missiles = ObjectManager.MissileList
		for I, Missile in pairs(Missiles) do
			if Missile.Team ~= myHero.Team then 
				local Spell = self.Spells[Missile.Name]
				local SpellName = Missile.Name
				if Spell ~= nil and self.DrawSpells[SpellName] and self.DrawSpells[SpellName].Value == 1 then
					if Spell.Type == 0 then
						local StartPos, EndPos = Evade:CalcLinearMissileStartEndPos(Missile, Missile.MissileStartPos, Missile.MissileEndPos, Spell);
						local corners3D = Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, 0)
						local corners2D = Evade:CalcLinearSpellHitbox2D(corners3D)
						-- Render:DrawCircle(Missile.MissileEndPos,Spell.Radius,255,255,255,255)
						Evade:DrawLineHitbox(corners2D);
					-- 	local pos = self:GetDodgePos(StartPos, EndPos, Spell)
					-- 	if pos then
					-- 		Render:DrawCircle(pos,100,255,255,255,255)
					-- 	end
					end
					if Spell.Type == 2 then
						Render:DrawCircle(Missile.MissileEndPos,Spell.Radius,255,255,255,255)
					end
				end
			end
		end

		-- local count = tablelength(self.SpellsToDodge)
		-- if count == 0 then return end
		-- for i, Spells in pairs(self.SpellsToDodge) do
		-- 	if Spells["Data"]["Spell"].Type == 2 then
		-- 		Render:DrawCircle(Spells["Data"]["EndPos"],Spells["Data"]["Spell"].Radius,255,255,255,255)
		-- 	end
		-- end


		-- local time = nil
		-- local lastQ = xerQ[0]
		-- if lastQ ~= nil then
		-- 	if time == nil then
		-- 		time = GameClock.Time + 0.4
		-- 	end
		-- 	if GameClock.Time > time then
		-- 		xerQ = {}
		-- 		time = nil
		-- 		return
		-- 	end
		-- 	local Spell = self.Spells["TestCubeRender10Vision"]
		-- 	local StartPos, EndPos = Evade:CalcLinearMissileStartEndPos(lastQ, xerathPosition, lastQ.Position, Spell);
		-- 	local corners3D = Evade:CalcLinearSpellHitbox3D(xerathPosition, lastQ.Position, Spell, 0)
		-- 	local corners2D = Evade:CalcLinearSpellHitbox2D(corners3D)
		-- 	-- Render:DrawCircle(Missile.MissileEndPos,Spell.Radius,255,255,255,255)
		-- 	Evade:DrawLineHitbox(corners2D);
		-- end


			--[[DEBUG SHIT	
			local Spell 		= self.Spells["EzrealR"]
			local Missile 		= {}
			Missile.MissileStartPos = Vector3.new(400,200,400)
			Missile.MissileEndPos 	= Vector3.new(1300,100,1300)
			if Spell ~= nil and Spell.Type == 0 then
				local StartPos, EndPos = Missile.MissileStartPos, Missile.MissileEndPos
				--DRAW HITBOX
				local corners3D = Evade:CalcLinearSpellHitbox3D(Missile.MissileStartPos, EndPos, Spell, 0)
				local corners2D = Evade:CalcLinearSpellHitbox2D(corners3D)
				Evade:DrawLineHitbox(corners2D);
			end
			if Orbwalker.MovePosition then
				Render:DrawCircle(Orbwalker.MovePosition,65,255,255,255,255)
			end	]]	
	end
end

function Evade:OnLoad()
	AddEvent("OnSettingsSave" , function() Evade:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Evade:LoadSettings() end)
    AddEvent("OnTick", function() Evade:OnTick() end)
	AddEvent("OnDraw", function() Evade:OnDraw() end)
	Evade:__init()
end

AddEvent("OnLoad", function() Evade:OnLoad() end)