Evade = {

}
-- Evade version 2.3
-- Dmg: 0 == ad, 1 == ap, 3 == mixed, 4 == true, 5 == none
function Evade:__init()
	self.Spells 			={}
	self.Spells['AatroxQWrapperCast'] = { Type = 0, Range = 625, ChampionName = "Aatrox", SpellName = "AatroxQWrapperCast", DisplayName = "Q", Radius = 180, Speed = math.huge, Delay = 0.35, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['AatroxW'] = { Type = 0, Range = 825, ChampionName = "Aatrox", SpellName = "AatroxW", DisplayName = "W", Radius = 80, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['AhriOrbMissile'] = { Type = 0, Range = 880, ChampionName = "Ahri", SpellName = "AhriOrbMissile", DisplayName = "QMissile", Radius = 100, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['AhriOrbofDeception'] = { Type = 0, Range = 880, ChampionName = "Ahri", SpellName = "AhriOrbofDeception", DisplayName = "Q", Radius = 100, Speed = 2500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
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
	self.Spells['AnnieW'] = { Type = 1, Range = 600, ChampionName = "Annie", SpellName = "AnnieW", DisplayName = "W", Radius = 0, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['ApheliosCalibrumQ'] = { Type = 0, Range = 1450, ChampionName = "Aphelios", SpellName = "ApheliosCalibrumQ", DisplayName = "Q", Radius = 70, Speed = 1850, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['ApheliosRMis'] = { Type = 0, Range = 1300, ChampionName = "Aphelios", SpellName = "ApheliosRMis", DisplayName = "RMis", Radius = 155, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['AurelionSolR'] = { Type = 0, Range = 1300, ChampionName = "AurelionSol", SpellName = "AurelionSolR", DisplayName = "R", Radius = 140, Speed = 2200, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AurelionSolQMissile'] = { Type = 0, Range = 25000, ChampionName = "AurelionSol", SpellName = "AurelionSolQMissile", DisplayName = "QMissile", Radius = 220, Speed = 1000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	-- self.Spells['AurelionSolStarMissile'] = { Type = 1, Range = 50, ChampionName = "AurelionSol", SpellName = "AurelionSolStarMissile", DisplayName = "AurelionSolStarMissile", Radius = 50, Speed = 600, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AzirR'] = { Type = 0, Range = 500, ChampionName = "Azir", SpellName = "AzirR", DisplayName = "R", Radius = 250, Speed = 1400, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['AzirQ'] = { Type = 0, Range = 740, ChampionName = "Azir", SpellName = "AzirQ", DisplayName = "Q", Radius = 300, Speed = 1400, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['BandageToss'] = { Type = 0, Range = 1100, ChampionName = "Amumu", SpellName = "BandageToss", DisplayName = "Q", Radius = 80, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
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
	self.Spells['CaitlynE'] = { Type = 0, Range = 750, ChampionName = "Caitlyn", SpellName = "CaitlynE", DisplayName = "E", Radius = 70, Speed = 1600, Delay = 0.15, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['CaitlynQ'] = { Type = 0, Range = 1250, ChampionName = "Caitlyn", SpellName = "CaitlynQ", DisplayName = "Q", Radius = 60, Speed = 2200, Delay = 0.625, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['CaitlynW'] = { Type = 2, Range = 800, ChampionName = "Caitlyn", SpellName = "CaitlynW", DisplayName = "W", Radius = 75, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 5}
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
	self.Spells['FlashFrostSpell'] = { Type = 0, Range = 1100, ChampionName = "Anivia", SpellName = "FlashFrostSpell", DisplayName = "Q", Radius = 110, Speed = 850, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
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
	self.Spells['HowlingGaleSpell10'] = { Type = 0, Range = 1445, ChampionName = "Janna", SpellName = "HowlingGaleSpell10", DisplayName = "HowlingGaleSpell10", Radius = 120, Speed = 967, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell11'] = { Type = 0, Range = 1495, ChampionName = "Janna", SpellName = "HowlingGaleSpell11", DisplayName = "HowlingGaleSpell11", Radius = 120, Speed = 1000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell12'] = { Type = 0, Range = 1545, ChampionName = "Janna", SpellName = "HowlingGaleSpell12", DisplayName = "HowlingGaleSpell12", Radius = 120, Speed = 1033, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell13'] = { Type = 0, Range = 1595, ChampionName = "Janna", SpellName = "HowlingGaleSpell13", DisplayName = "HowlingGaleSpell13", Radius = 120, Speed = 1067, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell14'] = { Type = 0, Range = 1645, ChampionName = "Janna", SpellName = "HowlingGaleSpell14", DisplayName = "HowlingGaleSpell14", Radius = 120, Speed = 1100, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell15'] = { Type = 0, Range = 1695, ChampionName = "Janna", SpellName = "HowlingGaleSpell15", DisplayName = "HowlingGaleSpell15", Radius = 120, Speed = 1133, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell16'] = { Type = 0, Range = 1745, ChampionName = "Janna", SpellName = "HowlingGaleSpell16", DisplayName = "HowlingGaleSpell16", Radius = 120, Speed = 1167, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell2'] = { Type = 0, Range = 1045, ChampionName = "Janna", SpellName = "HowlingGaleSpell2", DisplayName = "HowlingGaleSpell2", Radius = 120, Speed = 700, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell3'] = { Type = 0, Range = 1095, ChampionName = "Janna", SpellName = "HowlingGaleSpell3", DisplayName = "HowlingGaleSpell3", Radius = 120, Speed = 733, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell4'] = { Type = 0, Range = 1145, ChampionName = "Janna", SpellName = "HowlingGaleSpell4", DisplayName = "HowlingGaleSpell4", Radius = 120, Speed = 767, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell5'] = { Type = 0, Range = 1195, ChampionName = "Janna", SpellName = "HowlingGaleSpell5", DisplayName = "HowlingGaleSpell5", Radius = 120, Speed = 800, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell6'] = { Type = 0, Range = 1245, ChampionName = "Janna", SpellName = "HowlingGaleSpell6", DisplayName = "HowlingGaleSpell6", Radius = 120, Speed = 833, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell7'] = { Type = 0, Range = 1295, ChampionName = "Janna", SpellName = "HowlingGaleSpell7", DisplayName = "HowlingGaleSpell7", Radius = 120, Speed = 867, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell8'] = { Type = 0, Range = 1345, ChampionName = "Janna", SpellName = "HowlingGaleSpell8", DisplayName = "HowlingGaleSpell8", Radius = 120, Speed = 900, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['HowlingGaleSpell9'] = { Type = 0, Range = 1395, ChampionName = "Janna", SpellName = "HowlingGaleSpell9", DisplayName = "HowlingGaleSpell9", Radius = 120, Speed = 933, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
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
	self.Spells['LuxLightBinding'] = { Type = 0, Range = 1300, ChampionName = "Lux", SpellName = "LuxLightBinding", DisplayName = "Q", Radius = 60, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxLightBindingMis'] = { Type = 0, Range = 1300, ChampionName = "Lux", SpellName = "LuxLightBindingMis", DisplayName = "QMis", Radius = 60, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxLightBindingDummy'] = { Type = 0, Range = 1175, ChampionName = "Lux", SpellName = "LuxLightBindingDummy", DisplayName = "E", Radius = 50, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxLightStrikeKugel'] = { Type = 2, Range = 1100, ChampionName = "Lux", SpellName = "LuxLightStrikeKugel", DisplayName = "E", Radius = 300, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['LuxMaliceCannonMis'] = { Type = 0, Range = 3340, ChampionName = "Lux", SpellName = "LuxMaliceCannonMis", DisplayName = "R", Radius = 120, Speed = math.huge, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['MalzaharQ'] = { Type = 4, Range = 900, ChampionName = "Malzahar", SpellName = "MalzaharQ", DisplayName = "Q", Radius = 400, Speed = 1600, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MalzaharQMissile'] = { Type = 4, Range = 900, ChampionName = "Malzahar", SpellName = "MalzaharQMissile", DisplayName = "QMissile", Radius = 400, Speed = 1600, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MaokaiQ'] = { Type = 0, Range = 600, ChampionName = "Maokai", SpellName = "MaokaiQ", DisplayName = "Q", Radius = 110, Speed = 1600, Delay = 0.375, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MaokaiQMissile'] = { Type = 0, Range = 600, ChampionName = "Maokai", SpellName = "MaokaiQMissile", DisplayName = "QMissile", Radius = 110, Speed = 1600, Delay = 0.375, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MissFortuneBulletTime'] = { Type = 1, Range = 1400, ChampionName = "MissFortune", SpellName = "MissFortuneBulletTime", DisplayName = "R", Radius = 100, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['MissileBarrageMissile'] = { Type = 0, Range = 1300, ChampionName = "Corki", SpellName = "MissileBarrageMissile", DisplayName = "R", Radius = 40, Speed = 2000, Delay = 0.175, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['MissileBarrageMissile2'] = { Type = 0, Range = 1500, ChampionName = "Corki", SpellName = "MissileBarrageMissile2", DisplayName = "R2", Radius = 40, Speed = 2000, Delay = 0.175, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['PhosphorusBomb'] = { Type = 2, Range = 825, ChampionName = "Corki", SpellName = "PhosphorusBomb", DisplayName = "PhosphorusBomb", Radius = 250, Speed = 1000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['MordekaiserSyphonOfDestruction'] = { Type = 1, Range = 700, ChampionName = "Mordekaiser", SpellName = "MordekaiserSyphonOfDestruction", DisplayName = "R", Radius = 0, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['MordekaiserEMissile'] = { Type = 0, Range = 900, ChampionName = "Mordekaiser", SpellName = "MordekaiserEMissile", DisplayName = "EMissile", Radius = 100, Speed = 3000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['MordekaiserE'] = { Type = 0, Range = 900, ChampionName = "Mordekaiser", SpellName = "MordekaiserE", DisplayName = "E", Radius = 100, Speed = 3000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
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
	self.Spells['RekSaiQBurrowed'] = { Type = 0, Range = 1625, ChampionName = "RekSai", SpellName = "RekSaiQBurrowed", DisplayName = "Q", Radius = 65, Speed = 1950, Delay = 0.125, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['RekSaiQBurrowedMis'] = { Type = 0, Range = 1625, ChampionName = "RekSai", SpellName = "RekSaiQBurrowedMis", DisplayName = "Q", Radius = 65, Speed = 1950, Delay = 0.125, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['RengarE'] = { Type = 0, Range = 1000, ChampionName = "Rengar", SpellName = "RengarE", DisplayName = "E", Radius = 70, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['RengarEMis'] = { Type = 0, Range = 1000, ChampionName = "Rengar", SpellName = "RengarEMis", DisplayName = "EMis", Radius = 70, Speed = 1500, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['RiftWalk'] = { Type = 2, Range = 500, ChampionName = "Kassadin", SpellName = "RiftWalk", DisplayName = "R", Radius = 250, Speed = math.huge, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['RocketGrab'] = { Type = 0, Range = 1050, ChampionName = "Blitzcrank", SpellName = "RocketGrab", DisplayName = "Q", Radius = 70, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RocketGrabMissile'] = { Type = 0, Range = 1050, ChampionName = "Blitzcrank", SpellName = "RocketGrabMissile", DisplayName = "QMissile", Radius = 70, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RumbleGrenade'] = { Type = 0, Range = 850, ChampionName = "Rumble", SpellName = "RumbleGrenade", DisplayName = "E", Radius = 60, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RumbleGrenadeMissile'] = { Type = 0, Range = 850, ChampionName = "Rumble", SpellName = "RumbleGrenadeMissile", DisplayName = "EMissile", Radius = 60, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Rupture'] = { Type = 2, Range = 950, ChampionName = "Chogath", SpellName = "Rupture", DisplayName = "Q", Radius = 250, Speed = math.huge, Delay = 1.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['RyzeQ'] = { Type = 0, Range = 1000, ChampionName = "Ryze", SpellName = "RyzeQ", DisplayName = "Q", Radius = 55, Speed = 1700, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 1}
	self.Spells['SadMummyBandageToss'] = { Type = 0, Range = 1100, ChampionName = "Amumu", SpellName = "SadMummyBandageToss", DisplayName = "Q", Radius = 80, Speed = 2000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SamiraQGun'] = { Type = 0, Range = 950, ChampionName = "Samira", SpellName = "SamiraQGun", DisplayName = "QGun", Radius = 60, Speed = 2600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['SealFateMissile'] = { Type = 0, Range = 1450, ChampionName = "TwistedFate", SpellName = "SealFateMissile", DisplayName = "Q", Radius = 40, Speed = 1000, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 3}
	self.Spells['SejuaniR'] = { Type = 0, Range = 1300, ChampionName = "Sejuani", SpellName = "SejuaniR", DisplayName = "R", Radius = 120, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SejuaniRMissile'] = { Type = 0, Range = 1300, ChampionName = "Sejuani", SpellName = "SejuaniRMissile", DisplayName = "RMissile", Radius = 120, Speed = 1600, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SennaW'] = { Type = 0, Range = 1300, ChampionName = "Senna", SpellName = "SennaW", DisplayName = "W", Radius = 70, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['SennaR'] = { Type = 0, Range = 5000, ChampionName = "Senna", SpellName = "SennaR", DisplayName = "R", Radius = 160, Speed = 20000, Delay = 1, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
	self.Spells['SeraphineEMissile'] = { Type = 0, Range = 1300, ChampionName = "Seraphine", SpellName = "SeraphineEMissile", DisplayName = "EMissile", Radius = 80, Speed = 1200, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SeraphineR'] = { Type = 0, Range = 1200, ChampionName = "Seraphine", SpellName = "SeraphineR", DisplayName = "R", Radius = 160, Speed = 1600, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
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
	self.Spells['SorakaQ'] = { Type = 2, Range = 810, ChampionName = "Soraka", SpellName = "SorakaQ", DisplayName = "Q", Radius = 235, Speed = 1150, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SorakaQMissile'] = { Type = 2, Range = 810, ChampionName = "Soraka", SpellName = "SorakaQMissile", DisplayName = "QMissile", Radius = 235, Speed = 1150, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['SwainE'] = { Type = 0, Range = 850, ChampionName = "Swain", SpellName = "SwainE", DisplayName = "E", Radius = 85, Speed = 1800, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
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
	self.Spells['ThreshQMissile'] = { Type = 0, Range = 1075, ChampionName = "Thresh", SpellName = "ThreshQMissile", DisplayName = "QMissile", Radius = 70, Speed = 1900, Delay = 0.5, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TristanaW'] = { Type = 2, Range = 900, ChampionName = "Tristana", SpellName = "TristanaW", DisplayName = "W", Radius = 300, Speed = 1100, Delay = 0.25, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['Slash'] = { Type = 0, Range = 700, ChampionName = "Tryndamere", SpellName = "Slash", DisplayName = "E", Radius = 93, Speed = 1000, Delay = 0, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0} --Tryndamere 
	self.Spells['UrgotE'] = { Type = 0, Range = 475, ChampionName = "Urgot", SpellName = "UrgotE", DisplayName = "E", Radius = 100, Speed = 1500, Delay = 0.45, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['UrgotQ'] = { Type = 2, Range = 800, ChampionName = "Urgot", SpellName = "UrgotQ", DisplayName = "Q", Radius = 180, Speed = math.huge, Delay = 0.6, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['UrgotQMissile'] = { Type = 2, Range = 800, ChampionName = "Urgot", SpellName = "UrgotQMissile", DisplayName = "QMissile", Radius = 180, Speed = math.huge, Delay = 0.6, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['UrgotR'] = { Type = 0, Range = 1600, ChampionName = "Urgot", SpellName = "UrgotR", DisplayName = "R", Radius = 80, Speed = 3200, Delay = 0.4, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 0}
	self.Spells['VarusE'] = { Type = 2, Range = 925, ChampionName = "Varus", SpellName = "VarusE", DisplayName = "E", Radius = 260, Speed = 1500, Delay = 0.242, DangerLevel = 3, WillCollide = 0, CC = 0, Dmg = 0}
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
	self.Spells['XerathMageSpear'] = { Type = 0, Range = 1050, ChampionName = "Xerath", SpellName = "XerathMageSpear", DisplayName = "E", Radius = 60, Speed = 1400, Delay = 0.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['TestCubeRender10Vision'] = { Type = 0, Range = 1400, ChampionName = "Xerath", SpellName = "TestCubeRender10Vision", DisplayName = "Q", Radius = 100, Speed = 1600, Delay = 0.3, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
	self.Spells['XerathMageSpearMissile'] = { Type = 0, Range = 1050, ChampionName = "Xerath", SpellName = "XerathMageSpearMissile", DisplayName = "E", Radius = 60, Speed = 1400, Delay = 0.2, DangerLevel = 3, WillCollide = 0, CC = 1, Dmg = 1}
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
	self.CoreOptions = self.EvadeMenu:AddSubMenu("Core Options")
	self.EvadeActive = self.CoreOptions:AddCheckbox("Evade Active", 1)
	self.DodgeCCOnly = self.CoreOptions:AddCheckbox("Only Dodge CC", 1)
	self.DodgeWithoutKey = self.CoreOptions:AddCheckbox("Dodge While not holding a key", 1)
	self.CoreOptions:AddLabel("Dodge Factor, lower = closer to skillshot")
	self.CoreOptions:AddLabel("Dodge Factor, higer = more away from skillshot")
	self.AdditionalFactor = self.CoreOptions:AddSlider("Dodge Factor Linear", 18, 5, 40, 1)
	self.AdditionalFactorAOE = self.CoreOptions:AddSlider("Dodge Factor Circular", 13, 5, 40, 1)
	self.AdditionalFactorMouse = 1.4
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

	self.HeroMenu 		= {}
	self.SpellsMenu 	= {}
	self.DodgeSpells 	= {}
	self.DrawSpells 	= {}
	self.DangerLevels 	= {}
	
	self.InitDone 		= false

	self.SpellsToDodge	= {}
	self.SpellsToDraw 	= {}

	self.lastDodge = 0
	self:LoadSettings()
end

function Evade:SaveSettings()
	SettingsManager:CreateSettings("Evade")
	SettingsManager:AddSettingsGroup("Main")
	SettingsManager:AddSettingsInt("Dodge Spells", self.EvadeActive.Value)
	SettingsManager:AddSettingsInt("Only Dodge CC", self.DodgeCCOnly.Value)
	SettingsManager:AddSettingsInt("Use Danger Levels", self.UseDangerLevels.Value)
	SettingsManager:AddSettingsInt("DangerLevel1", self.DangerLevel1.Value)
	SettingsManager:AddSettingsInt("DangerLevel2", self.DangerLevel2.Value)
	SettingsManager:AddSettingsInt("DangerLevel3", self.DangerLevel3.Value)
	SettingsManager:AddSettingsInt("DangerLevel4", self.DangerLevel4.Value)
	SettingsManager:AddSettingsInt("DangerLevel5", self.DangerLevel5.Value)
	SettingsManager:AddSettingsInt("Dodge Factor Linear", self.AdditionalFactor.Value)
	SettingsManager:AddSettingsInt("Dodge Factor Circular", self.AdditionalFactorAOE.Value)
	SettingsManager:AddSettingsGroup("Debug")
	SettingsManager:AddSettingsInt("Print Abilities in Console", self.PrintSpells.Value)
end

function Evade:LoadSettings()
	SettingsManager:GetSettingsFile("Evade")
	self.EvadeActive.Value = SettingsManager:GetSettingsInt("Main","Dodge Spells")
	self.DodgeCCOnly.Value = SettingsManager:GetSettingsInt("Main","Only Dodge CC")
	self.UseDangerLevels.Value = SettingsManager:GetSettingsInt("Main","Use Danger Levels")
	self.DangerLevel1.Value = SettingsManager:GetSettingsInt("Main","DangerLevel1")
	self.DangerLevel2.Value = SettingsManager:GetSettingsInt("Main","DangerLevel2")
	self.DangerLevel3.Value = SettingsManager:GetSettingsInt("Main","DangerLevel3")
	self.DangerLevel4.Value = SettingsManager:GetSettingsInt("Main","DangerLevel4")
	self.DangerLevel5.Value = SettingsManager:GetSettingsInt("Main","DangerLevel5")
	self.DodgeWithoutKey.Value = SettingsManager:GetSettingsInt("Main","Dodge While not holding a key")
	self.AdditionalFactor.Value = SettingsManager:GetSettingsInt("Main","Dodge Factor Linear")
	self.AdditionalFactorAOE.Value = SettingsManager:GetSettingsInt("Main","Dodge Factor Circular")
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
	local StartEndVec 					= Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local Distance						= Evade:GetDist(StartPos, EndPos)
	local StartEndVecNormalized 		= Vector3.new(StartEndVec.x / Distance, 0, StartEndVec.z / Distance)	
	EndPos 								= Vector3.new(StartPos.x + (StartEndVecNormalized.x*Spell.Range), StartPos.y , StartPos.z + (StartEndVecNormalized.z*Spell.Range))
	
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

function Evade:ClosestLineFromLinearHitbox3D(corners3D) 
	local PlayerPos = myHero.Position
	local Point1 = Prediction:GetShortestPointToLine3D(corners3D[1], corners3D[3], PlayerPos)
	local Point2 = Prediction:GetShortestPointToLine3D(corners3D[2], corners3D[4], PlayerPos)
	local dist1  = self:GetDist(Point1, PlayerPos)
	local dist2  = self:GetDist(Point2, PlayerPos)

	if dist1 <= dist2 then
		return corners3D[1], corners3D[3], corners3D[2], corners3D[4]
	end
		return corners3D[2], corners3D[4], corners3D[1], corners3D[3]
end

function Evade:LineIntersection3D(line1_start, line1_end, line2_start, line2_end)
	local s1_x = line1_end.x - line1_start.x   
	local s1_z = line1_end.z - line1_start.z
	local s2_x = line2_end.x - line2_start.x   
	local s2_z = line2_end.z - line2_start.z

	local s = (-s1_z * (line1_start.x - line2_start.x) + s1_x * (line1_start.z - line2_start.z)) / (-s2_x * s1_z + s1_x * s2_z)
	local t = (s2_x * (line1_start.z - line2_start.z) - s2_z * (line1_start.x - line2_start.x)) / (-s2_x * s1_z + s1_x * s2_z)

	if (s >= 0 and s <= 1 and t >= 0 and t <= 1)then
		--Collision detected
		local I_Point = Vector3.new(line1_start.x + (t * s1_x), line1_start.y, line1_start.z + (t * s1_z))
		return true, I_Point
	end
	return false, nil --No collision
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

function Evade:IsInSkillShot(StartPos, EndPos, PosToCheck, Spell, RadiusAddition)
	if Spell.Type == 2 then
		if self:GetDist(EndPos, PosToCheck) <= Spell.Radius + RadiusAddition then
			return true
		end
	end
	if Spell.Type == 0 then
		if Prediction:PointOnLineSegment(StartPos, EndPos, PosToCheck, Spell.Radius + RadiusAddition) then 
			return true
		end
	end
	return false
end

function Evade:IsValidDodgePos(evadePos)
	if not Engine:IsNotWall(evadePos) then
		return false
	end

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

function Evade:GetPossiblePositions(StartPos)
	local Possible = {}
    for i=0, 600, 50 do 
        for x = 0, 15 do
            if x == 0 then            
                Possible[#Possible+1] = Vector3.new(StartPos.x, StartPos.y, StartPos.z + i) --up
            end
            if x == 1 then              
                Possible[#Possible+1]  = Vector3.new(StartPos.x, StartPos.y, StartPos.z - i) --down
            end
            if x == 2 then               
                Possible[#Possible+1]  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z) --left
            end
            if x == 3 then               
                Possible[#Possible+1]  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z) --right
            end

            if x == 4 then               
                Possible[#Possible+1]  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z + i) --top right
            end
            if x == 5 then              
                Possible[#Possible+1]  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z - i) --bottom left
            end
            if x == 6 then              
                Possible[#Possible+1]  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z - i) --bottom right
            end
            if x == 7 then              
                Possible[#Possible+1]  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z + i) --top left
            end

			if x == 8 then               
                Possible[#Possible+1]  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z + (i / 2)) --top right
            end
            if x == 9 then             
                Possible[#Possible+1]  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z - (i / 2)) --bottom left
            end
            if x == 10 then              
                Possible[#Possible+1]  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z - (i / 2)) --bottom right
            end
            if x == 11 then              
                Possible[#Possible+1]  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z + (i / 2)) --top left
            end

			if x == 12 then       
                Possible[#Possible+1]  = Vector3.new(StartPos.x + (i / 2), StartPos.y, StartPos.z + i) --top right
            end
            if x == 13 then      
                Possible[#Possible+1]  = Vector3.new(StartPos.x - (i / 2), StartPos.y, StartPos.z - i) --bottom left
            end
            if x == 14 then   
                Possible[#Possible+1]  = Vector3.new(StartPos.x + (i / 2), StartPos.y, StartPos.z - i) --bottom right
            end
            if x == 15 then
                Possible[#Possible+1]  = Vector3.new(StartPos.x - (i / 2), StartPos.y, StartPos.z + i) --top left
            end
		end
	end
	return Possible
end

function Evade:GetCirclePoints(Center, Spell, RadiusAddition)
	local Points = 48
	local Circle = {}
	local WedgeAngle = (2 * math.pi) / Points
	local Radius = Spell.Radius + RadiusAddition
	for i = 0, Points do
		local Theta = i * WedgeAngle;
		local X = math.cos(Theta) * Radius + Center.x
		local Y = Center.y
		local Z = math.sin(Theta) * Radius + Center.z
		Circle[#Circle+1] = Vector3.new(X,Y,Z)
	end
	return Circle
end

function Evade:ClosestPointToCircle(Center, Spell, RadiusAddition, Check)
	local Norm = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(Check, Center))
	local X = Center.x + (Norm.x * (Spell.Radius + RadiusAddition))
	local Y = Center.y + (Norm.y * (Spell.Radius + RadiusAddition))
	local Z = Center.z + (Norm.z * (Spell.Radius + RadiusAddition))                
	
	return Vector3.new(X,Y,Z)
end

function Evade:CircleIntersection(Center, CirclePoints, Point1, Point2)
	for _, Point in pairs(CirclePoints) do
		local Intersect, CrossPoint  = self:LineIntersection3D(Center, Point, Point1, Point2)
		if Intersect and CrossPoint then
			return CrossPoint
		end
	end
	return nil
end

function Evade:GetPointsOutsideSpellCircle(Center, PlayerCircle, Spell, RadiusAddition)
	local Outside = {}
	for _, Point in pairs(PlayerCircle) do
		if self:GetDist(Point, Center) > Spell.Radius + RadiusAddition then
			Outside[#Outside + 1] = Point
		end
	end
	return Outside
end

function Evade:GetPointsOutsideSpellLine(StartPos, EndPos, PlayerCircle, Spell, RadiusAddition)
	local PlayerPos =  myHero.Position
	local Outside 	= {}
	for _, Point in pairs(PlayerCircle) do
		local Closest = Prediction:GetShortestPointToLine3D(StartPos, EndPos, PlayerPos)
		if self:GetDist(Point, Closest) > Spell.Radius*2 and Prediction:PointOnLineSegment(StartPos, EndPos, Point, Spell.Radius, RadiusAddition) == false and self:LineIntersection3D(StartPos, EndPos, PlayerPos, Point) == false then
			Outside[#Outside + 1] = Point
		end
	end
	return Outside
end

function Evade:GetClosestPointToMouse(Points)
	local Closest = nil
	local Distance = 0
	for _, Point in pairs(Points) do
		if Closest then
			if self:GetDist(GameHud.MousePos, Point) < Distance then
				Closest = Point
				Distance = self:GetDist(GameHud.MousePos, Point)	
			end
		else
			Closest = Point
			Distance = self:GetDist(GameHud.MousePos, Point)
		end
	end
	return Closest
end

function Evade:GetLineDodgePos(Dodge1, Dodge2)
	local MousePos 	= GameHud.MousePos
	local PlayerPos = myHero.Position		

	local Closest 	= Prediction:GetShortestPointToLine3D(Dodge1, Dodge2, PlayerPos)
	local ClosestM  = Prediction:GetShortestPointToLine3D(Dodge1, Dodge2, MousePos)
	local Norm	 	= Prediction:GetVectorNormalized(Prediction:GetVectorDirection(ClosestM, Closest))
	local Distance  = self:GetDist(Closest, ClosestM)
	
	local X = Closest.x + (Norm.x * math.min(50, Distance))
	local Y = Closest.y + (Norm.y * math.min(50, Distance))
	local Z = Closest.z + (Norm.z * math.min(50, Distance))                
	
	return Vector3.new(X,Y,Z)
end

function Evade:GetDodgePos()
	local MousePos 	= GameHud.MousePos
	local PlayerPos = myHero.Position		
	for _, S in pairs(self.SpellsToDodge) do
		local Data = S["Data"]
		if Data then
			local Spell		= Data["Spell"]
			if Spell then
				local EndPos 	= Data["EndPos"]
				local StartPos 	= Data["StartPos"]
				if Spell.Type == 0 and (Spell.WillCollide == 0 or self:IsAllyOrMinionInSpellShotLine(StartPos, EndPos, PlayerPos, Spell) == false) then
					local RadiusAddition 	= myHero.CharData.BoundingRadius * (self.AdditionalFactor.Value / 10) + 50
					local DodgeHitbox 		= self:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, RadiusAddition)
					local Dodge1, Dodge2, Dodge3, Dodge4 = self:ClosestLineFromLinearHitbox3D(DodgeHitbox)	
					if self:IsInSkillShot(StartPos, EndPos, PlayerPos, Spell, RadiusAddition/2) then
						if self:IsInSkillShot(StartPos, EndPos, PlayerPos, Spell, 0) then --if in center of skill
							Orbwalker.BlockAttack 	= 1
							if Orbwalker.MovePosition then
								return Orbwalker.MovePosition
							end
						end
						local DodgePos = Prediction:GetShortestPointToLine3D(Dodge1, Dodge2, PlayerPos)
						if Engine:IsNotWall(DodgePos) == false then
							DodgePos = Prediction:GetShortestPointToLine3D(Dodge3, Dodge4, PlayerPos)
						end
						return DodgePos	
					else
						local MouseHitbox 		= self:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, 0)
						local Point1, Point2    = self:ClosestLineFromLinearHitbox3D(MouseHitbox)
						if self:IsInSkillShot(StartPos, EndPos, PlayerPos, Spell, RadiusAddition * 1.2) then
							local Intersect, CrossPoint  = self:LineIntersection3D(Point1, Point2, PlayerPos, MousePos)
							if Intersect and CrossPoint then
								return Prediction:GetShortestPointToLine3D(Dodge1, Dodge2, MousePos)
							end
						end				
					end
				end
				if Spell.Type == 2 and EndPos then
					local RadiusAddition 	= myHero.CharData.BoundingRadius * (self.AdditionalFactorAOE.Value / 10)
					local PlayerHitbox 		= self:GetCirclePoints(PlayerPos, Spell, 0)
					if self:IsInSkillShot(StartPos, EndPos, PlayerPos, Spell, RadiusAddition) then
						if self:IsInSkillShot(StartPos, EndPos, PlayerPos, Spell, RadiusAddition/2) then
							Orbwalker.BlockAttack 	= 1
						end
						local OutsidePoints = self:GetPointsOutsideSpellCircle(EndPos, PlayerHitbox, Spell, RadiusAddition/2)
						local Closest 		= self:GetClosestPointToMouse(OutsidePoints)
						if Closest and Prediction:PointOnLineSegment(PlayerPos, MousePos, Closest, 30) == false then
							return Closest
						end		
					end					
				end
			end
		end
	end
   
    return nil
end

function Evade:IsAllyOrMinionInSpellShotLine(StartPos, EndPos, PlayerPos, Spell)
	local Heros 			= ObjectManager.HeroList
	local Minions 			= ObjectManager.MinionList
	for _, Ally in pairs(Heros) do
		if Ally.IsTargetable and Ally.Team == myHero.Team and Ally.Index ~= myHero.Index then
			if self:IsInSkillShot(StartPos, EndPos, Ally.Position, Spell, Ally) and Prediction:PointOnLineSegment(StartPos, PlayerPos, Ally.Position, Spell.Radius) then
				return true
			end
		end
	end
	for _, Minion in pairs(Minions) do
		if Minion.MaxHealth > 10 and Minion.IsTargetable and Minion.Team == Minion.Team then
			if self:IsInSkillShot(StartPos, EndPos, Minion.Position, Spell, Minion) and Prediction:PointOnLineSegment(StartPos, PlayerPos, Minion.Position, Spell.Radius) then
				return true
			end
		end
	end
	return false
end

function Evade:CantEvade()
    if Orbwalker.MovePosition ~= nil then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do
            if Hero.Team ~= myHero.Team and self:GetDist(myHero.Position, Hero.Position) <= 1400 then
                local Missiles = ObjectManager.MissileList
                for I, Missile in pairs(Missiles) do
                    if Missile.Team ~= myHero.Team then 
                        local Info = Evade.Spells[Missile.Name]
                        if Info ~= nil and Info.Type == 0 then
                            local EvadePos = Orbwalker.MovePosition
                            local Multiplier = 100
                            local DistanceForE = self:GetDist(myHero.Position, EvadePos)
                            local TimeToDodge = DistanceForE / myHero.MovementSpeed
                            local TimeToDodge2 = 87 / myHero.MovementSpeed
                            local SpellDistance = self:GetDist(Missile.MissileStartPos, myHero.Position)
                            local TimeToHit = SpellDistance / Info.Speed
                            --if DistanceForE <= 80 then return end
                            if TimeToDodge2 > TimeToHit then
                                --print(TimeToHit)
                                return true
                            --else
                                --print("DODGED")
                                --return
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

function Evade:MissileIsGone(Missile)
	local List = ObjectManager.MissileList
	local CheckMissile = List[Missile.Index]
	if CheckMissile and CheckMissile.Name == Missile.Name then
		return false
	end
	return true
end

function Evade:ClearDodgeTable()
	local EntriesToDelete = {}
	if self.SpellsToDodge then
		for Key, S in pairs(self.SpellsToDodge) do
			local Data = S["Data"]
			if Data then
				local Spell		= Data["Spell"]
				local Time 		= Data["Time"]
				local StartPos 	= Data["StartPos"]
				local EndPos 	= Data["EndPos"]
				local Object 	= Data["Object"]
				if Spell then
					if Object and self:MissileIsGone(Object) then
						EntriesToDelete[#EntriesToDelete+1] = Key
					end
				end
				if Time and Time > GameClock.Time or Time < 0 then
					EntriesToDelete[#EntriesToDelete+1] = Key
				end
			end
		end

		for _, Remove in pairs(EntriesToDelete) do
			self.SpellsToDodge[Remove] = nil
		end
	end
end

function Evade:ClearDrawTable()
	local EntriesToDelete = {}
	if self.SpellsToDraw then
		for Key, S in pairs(self.SpellsToDraw) do
			local Data = S["Data"]
			if Data then
				local Time 		= Data["Time"]
				local Object 	= Data["Object"]
				if Time and Time > GameClock.Time or Time < 0 then
					EntriesToDelete[#EntriesToDelete+1] = Key
				end
				if Object and self:MissileIsGone(Object) then
					EntriesToDelete[#EntriesToDelete+1] = Key
				end
			end
		end

		for _, Remove in pairs(EntriesToDelete) do
			self.SpellsToDraw[Remove] = nil
		end
	end
end

function Evade:SetupTables(Spell, SpellName, StartPos, EndPos, Object)
	local Hitbox_Draw  = Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, 0)
	local Distance = self:GetDist(StartPos, EndPos)
	local Duration = Distance / Spell.Speed
	if Duration == 0 then
		Duration = Spell.Delay
	end
	if self.DodgeSpells[SpellName] and self.DodgeSpells[SpellName].Value == 1 then
		self.SpellsToDodge[Object.Index] = {
			["Data"] = {
				["StartPos"] 	= StartPos,
				["EndPos"] 		= EndPos,
				["Spell"] 		= Spell,
				["Time"] 		= Duration + GameClock.Time,
				["Object"] 		= Object
			}
		}
	end
	if self.DrawSpells[SpellName] and self.DrawSpells[SpellName].Value == 1 then
		self.SpellsToDraw[Object.Index] = {
			["Data"] = {
				["EndPos"] 	= EndPos,
				["Spell"] 	= Spell,
				["Time"] 	= Duration + GameClock.Time,
				["Object"] 	= Object,
				["Hitbox"] 	= Hitbox_Draw
			}
		}
	end
end

function Evade:SetDebug()
	local Spell			= self.Spells["VexR"]--self.Spells["BrandW"] --self.Spells["EzrealR"]
	local StartPos 		= Vector3.new(400, 200, 400)
	local EndPos 		= Vector3.new(2000, 200, 2000)--Vector3.new(1000, 200, 1000) --Vector3.new(10000, 200, 10000)
	local Hitbox_Draw  	= Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, 0)
	local Distance 		= self:GetDist(StartPos, EndPos)
	local Duration 		= Distance / Spell.Speed

	self.SpellsToDodge[9999] = {
		["Data"] = {
			["StartPos"] 	= StartPos,
			["EndPos"] 		= EndPos,
			["Spell"] 		= Spell,
			["Time"] 		= Duration + GameClock.Time,
			["Object"] 		= myHero
		}
	}
	self.SpellsToDraw[9999] = {
		["Data"] = {
			["EndPos"] 	= EndPos,
			["Spell"] 	= Spell,
			["Time"] 	= Duration + GameClock.Time,
			["Object"] 	= myHero,
			["Hitbox"] 	= Hitbox_Draw
		}
	}
end

function Evade:OnTick()
	if self.InitDone == false then
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
		self.InitDone = true
	end

	local Target = Orbwalker:GetTarget("Combo", myHero.AttackRange + myHero.CharData.BoundingRadius)
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team then
			--print(Hero.ActiveSpell.Info.Name)
			local SpellName 	= Hero.ActiveSpell.Info.Name
			local Spell 		= self.Spells[SpellName]
			if Spell and (Spell.CC == 1 or self.DodgeCCOnly.Value == 0) then	
				local DangerLevel 		= Spell.DangerLevel
				local StartPos, EndPos 	= Evade:CalcLinearSpellStartEndPos(Hero.ActiveSpell.StartPos, Hero.ActiveSpell.EndPos, Spell)
				if Spell.Type == 2 then
					EndPos = Hero.ActiveSpell.EndPos
				end			
				self:SetupTables(Spell, SpellName, StartPos, EndPos, Hero)
			end
		end
	end
	local Missiles = ObjectManager.MissileList
	for I, Missile in pairs(Missiles) do
		--print(Missile.Name)
		if Missile.Team ~= myHero.Team then 
			local SpellName 	= Missile.Name
			local Spell 		= self.Spells[SpellName]
			if Spell and (Spell.CC == 1 or self.DodgeCCOnly.Value == 0) then	
				local DangerLevel 		= Spell.DangerLevel
				local StartPos, EndPos 	= Evade:CalcLinearMissileStartEndPos(Missile, Missile.MissileStartPos, Missile.MissileEndPos, Spell)
				if Spell.Type == 2 then
					EndPos = Missile.MissileEndPos
				end			
				self:SetupTables(Spell, SpellName, StartPos, EndPos, Missile)
			end
		end
    end

	--self:SetDebug()

	Orbwalker.BlockAttack = 0
	local Point = self:GetDodgePos()
	if Point and self.EvadeActive.Value == 1 then		
		Orbwalker.MovePosition 	= Point
		self:ClearDodgeTable()
		return
	end
	Orbwalker.MovePosition 	= nil
	self:ClearDodgeTable()
end

function Evade:OnDraw()
	if GameHud.Minimized == false then
		for _, S in pairs(self.SpellsToDraw) do
			local Data = S["Data"]
			if Data then
				local Spell		= Data["Spell"]
				local EndPos 	= Data["EndPos"]
				local Object	= Data["Object"]
				local Hitbox	= Data["Hitbox"]
				if Spell then
					if Spell.Type == 0 then
						local Hitbox_2D = Evade:CalcLinearSpellHitbox2D(Hitbox)
						Evade:DrawLineHitbox(Hitbox_2D)
					end
					if Spell.Type == 2 and EndPos then
						Render:DrawCircle(EndPos,Spell.Radius,255,255,255,255)
					end
				end
			end
		end
	end

	self:ClearDrawTable()
end

function Evade:OnLoad()
	AddEvent("OnSettingsSave" , function() Evade:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Evade:LoadSettings() end)
    AddEvent("OnTick", function() Evade:OnTick() end)
	AddEvent("OnDraw", function() Evade:OnDraw() end)
	Evade:__init()
end

AddEvent("OnLoad", function() Evade:OnLoad() end)