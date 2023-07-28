Evade = {

}

function Evade:__init()
	self.Spells 			={}
	
	self.Spells['AatroxW'] = { Type = 0, Range = 825, Radius = 80, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['AhriOrbMissile'] = { Type = 0, Range = 880, Radius = 100, Speed = 2500, Delay = 0.25, CC = 0}
	self.Spells['AhriOrbofDeception'] = { Type = 0, Range = 880, Radius = 100, Speed = 2500, Delay = 0.25, CC = 0}
	self.Spells['AhriSeduce'] = { Type = 0, Range = 975, Radius = 60, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['AhriSeduceMissile'] = { Type = 0, Range = 975, Radius = 60, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['AkaliE'] = { Type = 0, Range = 825, Radius = 70, Speed = 1800, Delay = 0.25, CC = 0}
	self.Spells['AkaliEMis'] = { Type = 0, Range = 825, Radius = 70, Speed = 1800, Delay = 0.25, CC = 0}
	self.Spells['AkaliQ'] = { Type = 1, Range = 550, Radius = 60, Speed = 3200, Delay = 0.25, CC = 0}
	self.Spells['AkaliQMis'] = { Type = 1, Range = 550, Radius = 60, Speed = 3200, Delay = 0.25, CC = 0}
	self.Spells['AkaliR'] = { Type = 0, Range = 525, Radius = 65, Speed = 1800, Delay = 0, CC = 1}
	self.Spells['AkaliRb'] = { Type = 0, Range = 525, Radius = 65, Speed = 3600, Delay = 0, CC = 0}
	self.Spells['AnnieR'] = { Type = 2, Range = 600, Radius = 0, Speed = math.huge, Delay = 0.25, CC = 0}
	self.Spells['AnnieW'] = { Type = 1, Range = 600, Radius = 0, Speed = math.huge, Delay = 0.25, CC = 0}
	self.Spells['AurelionSolQ'] = { Type = 0, Range = 25000, Radius = 110, Speed = 850, Delay = 0, CC = 1}
	self.Spells['AurelionSolQMissile'] = { Type = 0, Range = 25000, Radius = 110, Speed = 850, Delay = 0, CC = 1}
	self.Spells['AzirR'] = { Type = 0, Range = 500, Radius = 250, Speed = 1400, Delay = 0.3, CC = 1}
	self.Spells['BandageToss'] = { Type = 0, Range = 1100, Radius = 80, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['BardQ'] = { Type = 0, Range = 950, Radius = 60, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['BardQMissile'] = { Type = 0, Range = 950, Radius = 60, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['BardR'] = { Type = 2, Range = 3400, Radius = 350, Speed = 2100, Delay = 0.5, CC = 1}
	self.Spells['BardRMissile'] = { Type = 2, Range = 3400, Radius = 350, Speed = 2100, Delay = 0.5, CC = 1}
	self.Spells['BlindMonkQOne'] = { Type = 0, Range = 1100, Radius = 60, Speed = 1800, Delay = 0.25, CC = 0}
	self.Spells['BrandQ'] = { Type = 0, Range = 1050, Radius = 60, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['BrandQMissile'] = { Type = 0, Range = 1050, Radius = 60, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['BrandW'] = { Type = 2, Range = 900, Radius = 250, Speed = math.huge, Delay = 0.85, CC = 0}
	self.Spells['BraumQ'] = { Type = 0, Range = 1000, Radius = 70, Speed = 1700, Delay = 0.25, CC = 1}
	self.Spells['BraumQMissile'] = { Type = 0, Range = 1000, Radius = 70, Speed = 1700, Delay = 0.25, CC = 1}
	self.Spells['BraumR'] = { Type = 0, Range = 1250, Radius = 115, Speed = 1400, Delay = 0.5, CC = 1}
	self.Spells['BraumRMissile'] = { Type = 0, Range = 1250, Radius = 115, Speed = 1400, Delay = 0.5, CC = 1}
	self.Spells['CaitlynEntrapment'] = { Type = 0, Range = 750, Radius = 70, Speed = 1600, Delay = 0.15, CC = 1}
	self.Spells['CaitlynPiltoverPeacemaker'] = { Type = 0, Range = 1250, Radius = 60, Speed = 2200, Delay = 0.625, CC = 0}
	self.Spells['CaitlynYordleTrap'] = { Type = 2, Range = 800, Radius = 75, Speed = math.huge, Delay = 0.25, CC = 1}
	self.Spells['CamilleEMissile'] = { Type = 0, Range = 925, Radius = 60, Speed = 1900, Delay = 0, CC = 0}
	self.Spells['CassiopeiaQ'] = { Type = 2, Range = 850, Radius = 150, Speed = math.huge, Delay = 0.75, CC = 0}
	self.Spells['CassiopeiaR'] = { Type = 1, Range = 825, Radius = 0, Speed = math.huge, Delay = 0.5, CC = 1}
	self.Spells['CassiopeiaW'] = { Type = 2, Range = 800, Radius = 160, Speed = 2500, Delay = 0.75, CC = 1}
	self.Spells['CurseoftheSadMummy'] = { Type = 2, Range = 0, Radius = 550, Speed = math.huge, Delay = 0.25, CC = 1}
	self.Spells['DianaArc'] = { Type = 2, Range = 900, Radius = 185, Speed = 1400, Delay = 0.25, CC = 0}
	self.Spells['DravenDoubleShot'] = { Type = 0, Range = 1050, Radius = 130, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['DravenDoubleShotMissile'] = { Type = 0, Range = 1050, Radius = 130, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['DravenR'] = { Type = 0, Range = 25000, Radius = 160, Speed = 2000, Delay = 0.25, CC = 0}
	self.Spells['DravenRCast'] = { Type = 0, Range = 25000, Radius = 160, Speed = 2000, Delay = 0.25, CC = 0}
	self.Spells['EkkoQ'] = { Type = 0, Range = 1175, Radius = 60, Speed = 1650, Delay = 0.25, CC = 1}
	self.Spells['EkkoQMis'] = { Type = 0, Range = 1175, Radius = 60, Speed = 1650, Delay = 0.25, CC = 1}
	self.Spells['EkkoW'] = { Type = 2, Range = 1600, Radius = 400, Speed = math.huge, Delay = 3.35, CC = 1}
	self.Spells['EkkoWMis'] = { Type = 2, Range = 1600, Radius = 400, Speed = math.huge, Delay = 3.35, CC = 1}
	self.Spells['EliseHumanE'] = { Type = 0, Range = 1075, Radius = 55, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['EnchantedCrystalArrow'] = { Type = 0, Range = 25000, Radius = 130, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['EvelynnQ'] = { Type = 0, Range = 800, Radius = 60, Speed = 2400, Delay = 0.25, CC = 0}
	self.Spells['EvelynnR'] = { Type = 1, Range = 450, Radius = 180, Speed = math.huge, Delay = 0.35, CC = 0}
	self.Spells['EzrealQ'] = { Type = 0, Range = 1150, Radius = 60, Speed = 2000, Delay = 0.25, CC = 0}
	self.Spells['EzrealR'] = { Type = 0, Range = 25000, Radius = 160, Speed = 2000, Delay = 1, CC = 0}
	self.Spells['EzrealW'] = { Type = 0, Range = 1150, Radius = 60, Speed = 2000, Delay = 0.25, CC = 0}
	self.Spells['FeralScream'] = { Type = 1, Range = 650, Radius = 0, Speed = math.huge, Delay = 0.5, CC = 1}
	self.Spells['FizzR'] = { Type = 0, Range = 1300, Radius = 150, Speed = 1300, Delay = 0.25, CC = 1}
	self.Spells['FizzRMissile'] = { Type = 0, Range = 1300, Radius = 150, Speed = 1300, Delay = 0.25, CC = 1}
	self.Spells['FlashFrostSpell'] = { Type = 0, Range = 1100, Radius = 110, Speed = 850, Delay = 0.25, CC = 1}
	self.Spells['ForcePulse'] = { Type = 1, Range = 600, Radius = 0, Speed = math.huge, Delay = 0.3, CC = 1}
	self.Spells['GalioE'] = { Type = 0, Range = 650, Radius = 160, Speed = 2300, Delay = 0.4, CC = 1}
	self.Spells['GalioQ'] = { Type = 2, Range = 825, Radius = 235, Speed = 1150, Delay = 0.25, CC = 0}
	self.Spells['GalioQMissileR'] = { Type = 2, Range = 825, Radius = 235, Speed = 1150, Delay = 0.25, CC = 0}
	self.Spells['GnarBigQMissile'] = { Type = 0, Range = 1125, Radius = 90, Speed = 2100, Delay = 0.5, CC = 1}
	self.Spells['GnarBigW'] = { Type = 0, Range = 575, Radius = 100, Speed = math.huge, Delay = 0.6, CC = 1}
	self.Spells['GnarQMissile'] = { Type = 0, Range = 1125, Radius = 55, Speed = 2500, Delay = 0.25, CC = 1}
	self.Spells['GnarR'] = { Type = 2, Range = 0, Radius = 475, Speed = math.huge, Delay = 0.25, CC = 1}
	self.Spells['GragasQ'] = { Type = 2, Range = 850, Radius = 275, Speed = 1000, Delay = 0.25, CC = 1}
	self.Spells['GragasQMissile'] = { Type = 2, Range = 850, Radius = 275, Speed = 1000, Delay = 0.25, CC = 1}
	self.Spells['GragasR'] = { Type = 2, Range = 1000, Radius = 400, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['GragasRBoom'] = { Type = 2, Range = 1000, Radius = 400, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['GravesChargeShot'] = { Type = 0, Range = 1000, Radius = 100, Speed = 2100, Delay = 0.25, CC = 0}
	self.Spells['GravesChargeShotShot'] = { Type = 0, Range = 1000, Radius = 100, Speed = 2100, Delay = 0.25, CC = 0}
	self.Spells['GravesClusterShotSoundMissile'] = { Type = 0, Range = 700, Radius = 20, Speed = 2000, Delay = 0.095, CC = 0}
	self.Spells['GravesQLineSpell'] = { Type = 0, Range = 700, Radius = 20, Speed = 2000, Delay = 0.095, CC = 0}
	self.Spells['GravesSmokeGrenade'] = { Type = 2, Range = 950, Radius = 250, Speed = 1500, Delay = 0.15, CC = 1}
	self.Spells['GravesSmokeGrenadeBoom'] = { Type = 2, Range = 950, Radius = 250, Speed = 1500, Delay = 0.15, CC = 1}
	self.Spells['HecarimUltMissile'] = { Type = 0, Range = 1650, Radius = 280, Speed = 1100, Delay = 0.2, CC = 1}
	self.Spells['HeimerdingerE'] = { Type = 2, Range = 970, Radius = 250, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['HeimerdingerESpell'] = { Type = 2, Range = 970, Radius = 250, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['HeimerdingerESpell_ult'] = { Type = 2, Range = 970, Radius = 250, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['HeimerdingerEUlt'] = { Type = 2, Range = 970, Radius = 250, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['HeimerdingerW'] = { Type = 0, Range = 1325, Radius = 100, Speed = 2050, Delay = 0.25, CC = 0}
	self.Spells['HeimerdingerWAttack2'] = { Type = 0, Range = 1325, Radius = 100, Speed = 2050, Delay = 0.25, CC = 0}
	self.Spells['HowlingGaleSpell'] = { Type = 0, Range = 995, Radius = 120, Speed = 667, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell10'] = { Type = 0, Range = 1445, Radius = 120, Speed = 967, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell11'] = { Type = 0, Range = 1495, Radius = 120, Speed = 1000, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell12'] = { Type = 0, Range = 1545, Radius = 120, Speed = 1033, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell13'] = { Type = 0, Range = 1595, Radius = 120, Speed = 1067, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell14'] = { Type = 0, Range = 1645, Radius = 120, Speed = 1100, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell15'] = { Type = 0, Range = 1695, Radius = 120, Speed = 1133, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell16'] = { Type = 0, Range = 1745, Radius = 120, Speed = 1167, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell2'] = { Type = 0, Range = 1045, Radius = 120, Speed = 700, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell3'] = { Type = 0, Range = 1095, Radius = 120, Speed = 733, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell4'] = { Type = 0, Range = 1145, Radius = 120, Speed = 767, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell5'] = { Type = 0, Range = 1195, Radius = 120, Speed = 800, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell6'] = { Type = 0, Range = 1245, Radius = 120, Speed = 833, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell7'] = { Type = 0, Range = 1295, Radius = 120, Speed = 867, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell8'] = { Type = 0, Range = 1345, Radius = 120, Speed = 900, Delay = 0, CC = 1}
	self.Spells['HowlingGaleSpell9'] = { Type = 0, Range = 1395, Radius = 120, Speed = 933, Delay = 0, CC = 1}
	self.Spells['IllaoiE'] = { Type = 0, Range = 900, Radius = 50, Speed = 1900, Delay = 0.25, CC = 0}
	self.Spells['IllaoiEMis'] = { Type = 0, Range = 900, Radius = 50, Speed = 1900, Delay = 0.25, CC = 0}
	self.Spells['IllaoiQ'] = { Type = 0, Range = 850, Radius = 100, Speed = math.huge, Delay = 0.75, CC = 0}
	self.Spells['InfectedCleaverMissile'] = { Type = 0, Range = 975, Radius = 60, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['IreliaR'] = { Type = 0, Range = 950, Radius = 160, Speed = 2000, Delay = 0.4, CC = 1}
	self.Spells['IreliaW2'] = { Type = 0, Range = 775, Radius = 120, Speed = math.huge, Delay = 0.25, CC = 1}
	self.Spells['IvernQ'] = { Type = 0, Range = 1075, Radius = 80, Speed = 1300, Delay = 0.25, CC = 1}
	self.Spells['JarvanIVDragonStrike'] = { Type = 0, Range = 770, Radius = 70, Speed = math.huge, Delay = 0.4, CC = 1}
	self.Spells['JavelinToss'] = { Type = 0, Range = 1500, Radius = 40, Speed = 1300, Delay = 0.25, CC = 0}
	self.Spells['JayceShockBlast'] = { Type = 0, Range = 1050, Radius = 70, Speed = 1450, Delay = 0.214, CC = 0}
	self.Spells['JayceShockBlastMis'] = { Type = 0, Range = 1050, Radius = 70, Speed = 1450, Delay = 0.214, CC = 0}
	self.Spells['JhinE'] = { Type = 2, Range = 750, Radius = 130, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['JhinETrap'] = { Type = 2, Range = 750, Radius = 130, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['JhinRShotMis'] = { Type = 0, Range = 3500, Radius = 80, Speed = 5000, Delay = 0.25, CC = 1}
	self.Spells['JhinW'] = { Type = 0, Range = 2550, Radius = 40, Speed = 5000, Delay = 0.75, CC = 1}
	self.Spells['JinxEHit'] = { Type = 2, Range = 900, Radius = 120, Speed = 1750, Delay = 0, CC = 1}
	self.Spells['JinxR'] = { Type = 0, Range = 25000, Radius = 140, Speed = 1700, Delay = 0.6, CC = 0}
	self.Spells['JinxWMissile'] = { Type = 0, Range = 1450, Radius = 60, Speed = 3300, Delay = 0.6, CC = 1}
	self.Spells['KalistaMysticShot'] = { Type = 0, Range = 1150, Radius = 40, Speed = 2400, Delay = 0.25, CC = 0}
	self.Spells['KalistaMysticShotMisTrue'] = { Type = 0, Range = 1150, Radius = 40, Speed = 2400, Delay = 0.25, CC = 0}
	self.Spells['KarmaQ'] = { Type = 0, Range = 950, Radius = 60, Speed = 1700, Delay = 0.25, CC = 1}
	self.Spells['KarmaQMantra'] = { Type = 0, Range = 950, Radius = 80, Speed = 1700, Delay = 0.25, CC = 1}
	self.Spells['KarmaQMissile'] = { Type = 0, Range = 950, Radius = 60, Speed = 1700, Delay = 0.25, CC = 1}
	self.Spells['KarmaQMissileMantra'] = { Type = 0, Range = 950, Radius = 80, Speed = 1700, Delay = 0.25, CC = 1}
	self.Spells['KarthusLayWasteA1'] = { Type = 2, Range = 875, Radius = 175, Speed = math.huge, Delay = 0.9, CC = 0}
	self.Spells['KarthusLayWasteA2'] = { Type = 2, Range = 875, Radius = 175, Speed = math.huge, Delay = 0.9, CC = 0}
	self.Spells['KarthusLayWasteA3'] = { Type = 2, Range = 875, Radius = 175, Speed = math.huge, Delay = 0.9, CC = 0}
	self.Spells['KayleQ'] = { Type = 0, Range = 850, Radius = 60, Speed = 2000, Delay = 0.5, CC = 1}
	self.Spells['KayleQMisVFX'] = { Type = 0, Range = 850, Radius = 60, Speed = 2000, Delay = 0.5, CC = 1}
	self.Spells['KaynW'] = { Type = 0, Range = 700, Radius = 90, Speed = math.huge, Delay = 0.55, CC = 1}
	self.Spells['KennenShurikenHurlMissile1'] = { Type = 0, Range = 1050, Radius = 50, Speed = 1700, Delay = 0.175, CC = 0}
	self.Spells['KhazixW'] = { Type = 0, Range = 1000, Radius = 70, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['KhazixWLong'] = { Type = 3, Range = 1000, Radius = 70, Speed = 1700, Delay = 0.25, CC = 1}
	self.Spells['KhazixWMissile'] = { Type = 0, Range = 1000, Radius = 70, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['KledQ'] = { Type = 0, Range = 800, Radius = 45, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['KledQMissile'] = { Type = 0, Range = 800, Radius = 45, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['KledRiderQ'] = { Type = 1, Range = 700, Radius = 0, Speed = 3000, Delay = 0.25, CC = 0}
	self.Spells['KledRiderQMissile'] = { Type = 1, Range = 700, Radius = 0, Speed = 3000, Delay = 0.25, CC = 0}
	self.Spells['KogMawLivingArtillery'] = { Type = 2, Range = 1300, Radius = 200, Speed = math.huge, Delay = 1.1, CC = 0}
	self.Spells['KogMawQ'] = { Type = 0, Range = 1175, Radius = 70, Speed = 1650, Delay = 0.25, CC = 0}
	self.Spells['KogMawVoidOozeMissile'] = { Type = 0, Range = 1360, Radius = 120, Speed = 1400, Delay = 0.25, CC = 1}
	self.Spells['Landslide'] = { Type = 2, Range = 0, Radius = 400, Speed = math.huge, Delay = 0.242, CC = 1}
	self.Spells['LeblancE'] = { Type = 0, Range = 925, Radius = 55, Speed = 1750, Delay = 0.25, CC = 1}
	self.Spells['LeblancEMissile'] = { Type = 0, Range = 925, Radius = 55, Speed = 1750, Delay = 0.25, CC = 1}
	self.Spells['LeblancRE'] = { Type = 0, Range = 925, Radius = 55, Speed = 1750, Delay = 0.25, CC = 1}
	self.Spells['LeblancREMissile'] = { Type = 0, Range = 925, Radius = 55, Speed = 1750, Delay = 0.25, CC = 1}
	self.Spells['LeonaSolarFlare'] = { Type = 2, Range = 1200, Radius = 300, Speed = math.huge, Delay = 0.85, CC = 1}
	self.Spells['LeonaZenithBlade'] = { Type = 0, Range = 875, Radius = 70, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['LissandraEMissile'] = { Type = 0, Range = 1025, Radius = 125, Speed = 850, Delay = 0.25, CC = 0}
	self.Spells['LissandraQMissile'] = { Type = 0, Range = 750, Radius = 75, Speed = 2200, Delay = 0.25, CC = 1}
	self.Spells['LucianQ'] = { Type = 0, Range = 900, Radius = 65, Speed = math.huge, Delay = 0.35, CC = 0}
	self.Spells['LucianRMissile'] = { Type = 0, Range = 1200, Radius = 110, Speed = 2800, Delay = 0, CC = 0}
	self.Spells['LucianW'] = { Type = 0, Range = 900, Radius = 80, Speed = 1600, Delay = 0.25, CC = 0}
	self.Spells['LuluQ'] = { Type = 0, Range = 925, Radius = 60, Speed = 1450, Delay = 0.25, CC = 1}
	self.Spells['LuluQMissile'] = { Type = 0, Range = 925, Radius = 60, Speed = 1450, Delay = 0.25, CC = 1}
	self.Spells['LuxLightBinding'] = { Type = 0, Range = 1175, Radius = 50, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['LuxLightBindingDummy'] = { Type = 0, Range = 1175, Radius = 50, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['LuxLightStrikeKugel'] = { Type = 2, Range = 1100, Radius = 300, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['LuxMaliceCannonMis'] = { Type = 0, Range = 3340, Radius = 120, Speed = math.huge, Delay = 1, CC = 0}
	self.Spells['MalzaharQ'] = { Type = 4, Range = 900, Radius = 400, Speed = 1600, Delay = 0.5, CC = 1}
	self.Spells['MalzaharQMissile'] = { Type = 4, Range = 900, Radius = 400, Speed = 1600, Delay = 0.5, CC = 1}
	self.Spells['MaokaiQ'] = { Type = 0, Range = 600, Radius = 110, Speed = 1600, Delay = 0.375, CC = 1}
	self.Spells['MaokaiQMissile'] = { Type = 0, Range = 600, Radius = 110, Speed = 1600, Delay = 0.375, CC = 1}
	self.Spells['MissFortuneBulletTime'] = { Type = 1, Range = 1400, Radius = 100, Speed = 2000, Delay = 0.25, CC = 0}
	self.Spells['MissileBarrageMissile'] = { Type = 0, Range = 1300, Radius = 40, Speed = 2000, Delay = 0.175, CC = 0}
	self.Spells['MissileBarrageMissile2'] = { Type = 0, Range = 1500, Radius = 40, Speed = 2000, Delay = 0.175, CC = 0}
	self.Spells['MordekaiserSyphonOfDestruction'] = { Type = 1, Range = 700, Radius = 0, Speed = math.huge, Delay = 0.25, CC = 0}
	self.Spells['MorganaQ'] = { Type = 0, Range = 1250, Radius = 70, Speed = 1200, Delay = 0.25, CC = 1}
	self.Spells['MorganaW'] = { Type = 2, Range = 900, Radius = 275, Speed = math.huge, Delay = 0.25, CC = 0}
	self.Spells['NamiQ'] = { Type = 2, Range = 875, Radius = 180, Speed = math.huge, Delay = 1, CC = 1}
	self.Spells['NamiRMissile'] = { Type = 0, Range = 2750, Radius = 250, Speed = 850, Delay = 0.5, CC = 1}
	self.Spells['NautilusAnchorDragMissile'] = { Type = 0, Range = 925, Radius = 90, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['NeekoE'] = { Type = 0, Range = 1000, Radius = 65, Speed = 1400, Delay = 0.25, CC = 1}
	self.Spells['NeekoQ'] = { Type = 2, Range = 800, Radius = 200, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['NocturneDuskbringer'] = { Type = 0, Range = 1200, Radius = 60, Speed = 1600, Delay = 0.25, CC = 0}
	self.Spells['NunuR'] = { Type = 2, Range = 0, Radius = 650, Speed = math.huge, Delay = 3, CC = 1}
	self.Spells['OlafAxeThrow'] = { Type = 0, Range = 1000, Radius = 90, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['OlafAxeThrowCast'] = { Type = 0, Range = 1000, Radius = 90, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['OrnnE'] = { Type = 0, Range = 800, Radius = 150, Speed = 1800, Delay = 0.35, CC = 1}
	self.Spells['OrnnQ'] = { Type = 0, Range = 800, Radius = 65, Speed = 1800, Delay = 0.3, CC = 1}
	self.Spells['OrnnRCharge'] = { Type = 0, Range = 2500, Radius = 200, Speed = 1650, Delay = 0.5, CC = 1}
	self.Spells['PantheonE'] = { Type = 1, Range = 400, Radius = 0, Speed = math.huge, Delay = 0.389, CC = 0}
	self.Spells['PhosphorusBomb'] = { Type = 2, Range = 825, Radius = 250, Speed = 1000, Delay = 0.25, CC = 0}
	self.Spells['PhosphorusBombMissile'] = { Type = 2, Range = 825, Radius = 250, Speed = 1000, Delay = 0.25, CC = 0}
	self.Spells['PoppyQSpell'] = { Type = 0, Range = 430, Radius = 100, Speed = math.huge, Delay = 0.332, CC = 1}
	self.Spells['PoppyRSpell'] = { Type = 0, Range = 1200, Radius = 100, Speed = 2000, Delay = 0.33, CC = 1}
	self.Spells['PoppyRSpellMissile'] = { Type = 0, Range = 1200, Radius = 100, Speed = 2000, Delay = 0.33, CC = 1}
	self.Spells['Pulverize'] = { Type = 2, Range = 0, Radius = 365, Speed = math.huge, Delay = 0.25, CC = 1}
	self.Spells['PykeE'] = { Type = 0, Range = 25000, Radius = 110, Speed = 3000, Delay = 0, CC = 1}
	self.Spells['PykeEMissile'] = { Type = 0, Range = 25000, Radius = 110, Speed = 3000, Delay = 0, CC = 1}
	self.Spells['PykeQMelee'] = { Type = 0, Range = 400, Radius = 70, Speed = math.huge, Delay = 0.25, CC = 1}
	self.Spells['PykeQRange'] = { Type = 0, Range = 1100, Radius = 70, Speed = 2000, Delay = 0.2, CC = 1}
	self.Spells['PykeR'] = { Type = 2, Range = 750, Radius = 350, Speed = math.huge, Delay = 0.5, CC = 0}
	self.Spells['QuinnQ'] = { Type = 0, Range = 1025, Radius = 60, Speed = 1550, Delay = 0.25, CC = 0}
	self.Spells['RakanQ'] = { Type = 0, Range = 850, Radius = 65, Speed = 1850, Delay = 0.25, CC = 0}
	self.Spells['RakanQMis'] = { Type = 0, Range = 850, Radius = 65, Speed = 1850, Delay = 0.25, CC = 0}
	self.Spells['RakanW'] = { Type = 2, Range = 650, Radius = 265, Speed = math.huge, Delay = 0.7, CC = 1}
	self.Spells['RekSaiQBurrowed'] = { Type = 0, Range = 1625, Radius = 65, Speed = 1950, Delay = 0.125, CC = 0}
	self.Spells['RekSaiQBurrowedMis'] = { Type = 0, Range = 1625, Radius = 65, Speed = 1950, Delay = 0.125, CC = 0}
	self.Spells['RengarE'] = { Type = 0, Range = 1000, Radius = 70, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['RengarEMis'] = { Type = 0, Range = 1000, Radius = 70, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['RiftWalk'] = { Type = 2, Range = 500, Radius = 250, Speed = math.huge, Delay = 0.25, CC = 0}
	self.Spells['RocketGrab'] = { Type = 0, Range = 1050, Radius = 70, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['RocketGrabMissile'] = { Type = 0, Range = 1050, Radius = 70, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['RumbleGrenade'] = { Type = 0, Range = 850, Radius = 60, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['RumbleGrenadeMissile'] = { Type = 0, Range = 850, Radius = 60, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['Rupture'] = { Type = 2, Range = 950, Radius = 250, Speed = math.huge, Delay = 1.2, CC = 1}
	self.Spells['RyzeQ'] = { Type = 0, Range = 1000, Radius = 55, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['SadMummyBandageToss'] = { Type = 0, Range = 1100, Radius = 80, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['SealFateMissile'] = { Type = 3, Range = 1450, Radius = 40, Speed = 1000, Delay = 0.25, CC = 0}
	self.Spells['SejuaniR'] = { Type = 0, Range = 1300, Radius = 120, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['SejuaniRMissile'] = { Type = 0, Range = 1300, Radius = 120, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['ShyvanaFireball'] = { Type = 0, Range = 925, Radius = 60, Speed = 1575, Delay = 0.25, CC = 0}
	self.Spells['ShyvanaFireballDragon2'] = { Type = 0, Range = 975, Radius = 60, Speed = 1575, Delay = 0.333, CC = 0}
	self.Spells['ShyvanaFireballDragonMissile'] = { Type = 0, Range = 975, Radius = 60, Speed = 1575, Delay = 0.333, CC = 0}
	self.Spells['ShyvanaFireballMissile'] = { Type = 0, Range = 925, Radius = 60, Speed = 1575, Delay = 0.25, CC = 0}
	self.Spells['ShyvanaTransformLeap'] = { Type = 0, Range = 850, Radius = 150, Speed = 700, Delay = 0.25, CC = 1}
	self.Spells['SionE'] = { Type = 0, Range = 800, Radius = 80, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['SionEMissile'] = { Type = 0, Range = 800, Radius = 80, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['SionQ'] = { Type = 0, Range = 750, Radius = 150, Speed = math.huge, Delay = 2, CC = 1}
	self.Spells['SivirQ'] = { Type = 0, Range = 1250, Radius = 90, Speed = 1350, Delay = 0.25, CC = 0}
	self.Spells['SivirQMissile'] = { Type = 0, Range = 1250, Radius = 90, Speed = 1350, Delay = 0.25, CC = 0}
	self.Spells['SkarnerFractureMissile'] = { Type = 0, Range = 1000, Radius = 70, Speed = 1500, Delay = 0.25, CC = 1}
	self.Spells['SonaR'] = { Type = 0, Range = 1000, Radius = 140, Speed = 2400, Delay = 0.25, CC = 1}
	self.Spells['SonaRMissile'] = { Type = 0, Range = 1000, Radius = 140, Speed = 2400, Delay = 0.25, CC = 1}
	self.Spells['SorakaQ'] = { Type = 2, Range = 810, Radius = 235, Speed = 1150, Delay = 0.25, CC = 1}
	self.Spells['SorakaQMissile'] = { Type = 2, Range = 810, Radius = 235, Speed = 1150, Delay = 0.25, CC = 1}
	self.Spells['SwainE'] = { Type = 0, Range = 850, Radius = 85, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['SwainQ'] = { Type = 1, Range = 725, Radius = 0, Speed = 5000, Delay = 0.25, CC = 0}
	self.Spells['SwainW'] = { Type = 2, Range = 3500, Radius = 300, Speed = math.huge, Delay = 1.5, CC = 1}
	self.Spells['Swipe'] = { Type = 1, Range = 350, Radius = 0, Speed = math.huge, Delay = 0.25, CC = 0}
	self.Spells['SyndraE'] = { Type = 1, Range = 700, Radius = 0, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['SyndraEMissile'] = { Type = 1, Range = 700, Radius = 0, Speed = 1600, Delay = 0.25, CC = 1}
	self.Spells['SyndraESphereMissile'] = { Type = 0, Range = 950, Radius = 100, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['SyndraQSpell'] = { Type = 2, Range = 800, Radius = 200, Speed = math.huge, Delay = 0.625, CC = 0}
	self.Spells['TahmKenchQ'] = { Type = 0, Range = 800, Radius = 70, Speed = 2800, Delay = 0.25, CC = 1}
	self.Spells['TahmKenchQMissile'] = { Type = 0, Range = 800, Radius = 70, Speed = 2800, Delay = 0.25, CC = 1}
	self.Spells['TaliyahE'] = { Type = 1, Range = 800, Radius = 0, Speed = 2000, Delay = 0.45, CC = 1}
	self.Spells['TaliyahQ'] = { Type = 0, Range = 1000, Radius = 100, Speed = 3600, Delay = 0.25, CC = 0}
	self.Spells['TaliyahQMis'] = { Type = 0, Range = 1000, Radius = 100, Speed = 3600, Delay = 0.25, CC = 0}
	self.Spells['TaliyahR'] = { Type = 0, Range = 3000, Radius = 120, Speed = 1700, Delay = 1, CC = 1}
	self.Spells['TaliyahRMis'] = { Type = 0, Range = 3000, Radius = 120, Speed = 1700, Delay = 1, CC = 1}
	self.Spells['TaliyahWVC'] = { Type = 2, Range = 900, Radius = 150, Speed = math.huge, Delay = 0.85, CC = 1}
	self.Spells['TalonW'] = { Type = 1, Range = 650, Radius = 75, Speed = 2500, Delay = 0.25, CC = 1}
	self.Spells['TalonWMissileOne'] = { Type = 1, Range = 650, Radius = 75, Speed = 2500, Delay = 0.25, CC = 1}
	self.Spells['ThreshE'] = { Type = 0, Range = 500, Radius = 110, Speed = math.huge, Delay = 0.389, CC = 1}
	self.Spells['ThreshEMissile1'] = { Type = 0, Range = 500, Radius = 110, Speed = math.huge, Delay = 0.389, CC = 1}
	self.Spells['ThreshQMissile'] = { Type = 0, Range = 1075, Radius = 70, Speed = 1900, Delay = 0.5, CC = 1}
	self.Spells['TristanaW'] = { Type = 2, Range = 900, Radius = 300, Speed = 1100, Delay = 0.25, CC = 1}
	self.Spells['UrgotE'] = { Type = 0, Range = 475, Radius = 100, Speed = 1500, Delay = 0.45, CC = 1}
	self.Spells['UrgotQ'] = { Type = 2, Range = 800, Radius = 180, Speed = math.huge, Delay = 0.6, CC = 1}
	self.Spells['UrgotQMissile'] = { Type = 2, Range = 800, Radius = 180, Speed = math.huge, Delay = 0.6, CC = 1}
	self.Spells['UrgotR'] = { Type = 0, Range = 1600, Radius = 80, Speed = 3200, Delay = 0.4, CC = 1}
	self.Spells['VarusE'] = { Type = 2, Range = 925, Radius = 260, Speed = 1500, Delay = 0.242, CC = 1}
	self.Spells['VarusEMissile'] = { Type = 2, Range = 925, Radius = 260, Speed = 1500, Delay = 0.242, CC = 1}
	self.Spells['VarusQMissile'] = { Type = 0, Range = 1525, Radius = 70, Speed = 1900, Delay = 0, CC = 0}
	self.Spells['VarusR'] = { Type = 0, Range = 1200, Radius = 120, Speed = 1950, Delay = 0.25, CC = 1}
	self.Spells['VarusRMissile'] = { Type = 0, Range = 1200, Radius = 120, Speed = 1950, Delay = 0.25, CC = 1}
	self.Spells['VeigarBalefulStrike'] = { Type = 0, Range = 900, Radius = 70, Speed = 2200, Delay = 0.25, CC = 0}
	self.Spells['VeigarBalefulStrikeMis'] = { Type = 0, Range = 900, Radius = 70, Speed = 2200, Delay = 0.25, CC = 0}
	self.Spells['VeigarDarkMatterCastLockout'] = { Type = 2, Range = 900, Radius = 200, Speed = math.huge, Delay = 1.25, CC = 0}
	self.Spells['VeigarEventHorizon'] = { Type = 5, Range = 700, Radius = 375, Speed = math.huge, Delay = 1, CC = 1}
	self.Spells['VelkozE'] = { Type = 2, Range = 800, Radius = 185, Speed = math.huge, Delay = 0.8, CC = 1}
	self.Spells['VelkozEMissile'] = { Type = 2, Range = 800, Radius = 185, Speed = math.huge, Delay = 0.8, CC = 1}
	self.Spells['VelkozQ'] = { Type = 0, Range = 1050, Radius = 50, Speed = 1300, Delay = 0.25, CC = 1}
	self.Spells['VelkozQMissile'] = { Type = 0, Range = 1050, Radius = 50, Speed = 1300, Delay = 0.25, CC = 1}
	self.Spells['VelkozQMissileSplit'] = { Type = 0, Range = 1100, Radius = 45, Speed = 2100, Delay = 0.25, CC = 1}
	self.Spells['VelkozW'] = { Type = 0, Range = 1050, Radius = 87.5, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['VelkozWMissile'] = { Type = 0, Range = 1050, Radius = 87.5, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['ViktorDeathRayMissile'] = { Type = 0, Range = 750, Radius = 80, Speed = 1050, Delay = 0, CC = 0}
	self.Spells['ViktorGravitonField'] = { Type = 2, Range = 800, Radius = 270, Speed = math.huge, Delay = 1.75, CC = 1}
	self.Spells['Volley'] = { Type = 1, Range = 1200, Radius = 20, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['VolleyRightAttack'] = { Type = 1, Range = 1200, Radius = 20, Speed = 2000, Delay = 0.25, CC = 1}
	self.Spells['WarwickR'] = { Type = 0, Range = 3000, Radius = 55, Speed = 1800, Delay = 0.1, CC = 1}
	self.Spells['WildCards'] = { Type = 3, Range = 1450, Radius = 40, Speed = 1000, Delay = 0.25, CC = 0}
	self.Spells['XayahQ'] = { Type = 0, Range = 1100, Radius = 45, Speed = 2075, Delay = 0.5, CC = 0}
	self.Spells['XerathArcaneBarrage2'] = { Type = 2, Range = 1000, Radius = 235, Speed = math.huge, Delay = 0.75, CC = 1}
	self.Spells['XerathLocusPulse'] = { Type = 2, Range = 5600, Radius = 200, Speed = math.huge, Delay = 0.7, CC = 0}
	self.Spells['XerathMageSpear'] = { Type = 0, Range = 1050, Radius = 60, Speed = 1400, Delay = 0.2, CC = 1}
	self.Spells['XerathMageSpearMissile'] = { Type = 0, Range = 1050, Radius = 60, Speed = 1400, Delay = 0.2, CC = 1}
	self.Spells['XinZhaoW'] = { Type = 0, Range = 900, Radius = 40, Speed = 5000, Delay = 0.5, CC = 1}
	self.Spells['YasuoQ3Mis'] = { Type = 0, Range = 1100, Radius = 90, Speed = 1200, Delay = 0.318, CC = 1}
	self.Spells['ZacQ'] = { Type = 0, Range = 800, Radius = 120, Speed = 2800, Delay = 0.33, CC = 1}
	self.Spells['ZacQMissile'] = { Type = 0, Range = 800, Radius = 120, Speed = 2800, Delay = 0.33, CC = 1}
	self.Spells['ZedQ'] = { Type = 0, Range = 900, Radius = 50, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['ZedQMissile'] = { Type = 0, Range = 900, Radius = 50, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['ZedW'] = { Type = 0, Range = 700, Radius = 60, Speed = 1750, Delay = 0, CC = 0}
	self.Spells['ZedWMissile'] = { Type = 0, Range = 700, Radius = 60, Speed = 1750, Delay = 0, CC = 0}
	self.Spells['ZiggsE'] = { Type = 2, Range = 900, Radius = 250, Speed = 1800, Delay = 0.25, CC = 1}
	self.Spells['ZiggsQ'] = { Type = 2, Range = 850, Radius = 120, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['ZiggsQSpell'] = { Type = 2, Range = 850, Radius = 120, Speed = 1700, Delay = 0.25, CC = 0}
	self.Spells['ZiggsR'] = { Type = 2, Range = 5000, Radius = 480, Speed = 1550, Delay = 0.375, CC = 0}
	self.Spells['ZiggsRBoom'] = { Type = 2, Range = 5000, Radius = 480, Speed = 1550, Delay = 0.375, CC = 0}
	self.Spells['ZiggsW'] = { Type = 2, Range = 1000, Radius = 240, Speed = 1750, Delay = 0.25, CC = 1}
	self.Spells['ZileanQ'] = { Type = 2, Range = 900, Radius = 150, Speed = math.huge, Delay = 0.8, CC = 1}
	self.Spells['ZileanQMissile'] = { Type = 2, Range = 900, Radius = 150, Speed = math.huge, Delay = 0.8, CC = 1}
	self.Spells['ZoeE'] = { Type = 0, Range = 800, Radius = 50, Speed = 1700, Delay = 0.3, CC = 1}
	self.Spells['ZoeEMissile'] = { Type = 0, Range = 800, Radius = 50, Speed = 1700, Delay = 0.3, CC = 1}
	self.Spells['ZoeQMMis2'] = { Type = 0, Range = 800, Radius = 50, Speed = 1200, Delay = 0.25, CC = 0}
	self.Spells['ZoeQMissile'] = { Type = 0, Range = 800, Radius = 50, Speed = 1200, Delay = 0.25, CC = 0}
	self.Spells['ZyraE'] = { Type = 0, Range = 1100, Radius = 70, Speed = 1150, Delay = 0.25, CC = 1}
	self.Spells['ZyraQ'] = { Type = 4, Range = 800, Radius = 400, Speed = math.huge, Delay = 0.825, CC = 0}
	self.Spells['ZyraR'] = { Type = 2, Range = 700, Radius = 500, Speed = math.huge, Delay = 2, CC = 1}
end

local DZone

function Evade:GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Evade:CalcLinearSpellStartEndPos(StartPos, EndPos, Spell, SpellStartPos, SpellEndPos)
	local totargetvec = Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local length = math.sqrt((totargetvec.x * totargetvec.x) + (totargetvec.y * totargetvec.y) + (totargetvec.z * totargetvec.z))
	local totargetvecnorm = Vector3.new(totargetvec.x / length, 0, totargetvec.z / length)
    local mod = Spell.Range
	EndPos = Vector3.new(StartPos.x + (totargetvecnorm.x*mod), StartPos.y + (totargetvecnorm.y*mod), StartPos.z + (totargetvecnorm.z*mod))
	local StartEndVec = Vector3.new(EndPos.x - StartPos.x, EndPos.y - StartPos.y, EndPos.z - StartPos.z)
	local length2 = math.sqrt((StartEndVec.x * StartEndVec.x) + (StartEndVec.y * StartEndVec.y) + (StartEndVec.z * StartEndVec.z))
	local Start2Screen
	local End2Screen
	if Spell.Range > 5000 then
		for i = 0, 25000 do
			if Engine:World2Screen(StartPos, Start2Screen) then
				if i > 0 then
					StartPos = Vector3.new(StartPos.x - (totargetvecnorm.x * 2000), StartPos.y, StartPos.z - (totargetvecnorm.z * 2000))
                end
				break
			end
			if not Engine:World2Screen(StartPos, Start2Screen) then
				StartPos = Vector3.new(StartPos.x + (totargetvecnorm.x* i), StartPos.y, StartPos.z + (totargetvecnorm.z* i))
            end
		end
		for i = 0, 25000 do
			if Engine:World2Screen(EndPos, End2Screen) then
				if i > 0 then
					EndPos = Vector3.new(EndPos.x + (totargetvecnorm.x * 2000), EndPos.y, EndPos.z + (totargetvecnorm.z * 2000))
                end
				break
			end
			if not Engine:World2Screen(EndPos, End2Screen) then
				EndPos = Vector3.new(EndPos.x - (totargetvecnorm.x* i), EndPos.y, EndPos.z - (totargetvecnorm.z* i))
            end
		end
	end
	SpellStartPos = StartPos
	SpellEndPos = EndPos
end

function Evade:CalcLinearMissileStartEndPos(Missile, StartPos, EndPos, Spell, SpellStartPos, SpellEndPos)
	local MissilePos = Missile.Position
	local CurrentPos = Vector3.new(MissilePos.x, StartPos.y, MissilePos.z)
	local StartToCurrentPos = Vector3.new(CurrentPos.x - StartPos.x, 0, CurrentPos.z - StartPos.z)
	local DistToStartPos = math.sqrt((StartToCurrentPos.x * StartToCurrentPos.x) + (StartToCurrentPos.y * StartToCurrentPos.y) + (StartToCurrentPos.z * StartToCurrentPos.z))

	local totargetvec = Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local length = math.sqrt((totargetvec.x * totargetvec.x) + (totargetvec.y * totargetvec.y) + (totargetvec.z * totargetvec.z))
	local totargetvecnorm = Vector3.new(totargetvec.x / length, 0, totargetvec.z / length)
	local mod = Spell.Range
	EndPos = Vector3.new(StartPos.x + (totargetvecnorm.x*mod), StartPos.y + (totargetvecnorm.y*mod), StartPos.z + (totargetvecnorm.z*mod))
	local StartEndVec = Vector3.new(EndPos.x - StartPos.x, EndPos.y - StartPos.y, EndPos.z - StartPos.z)
    local length2 = math.sqrt((StartEndVec.x * StartEndVec.x) + (StartEndVec.y * StartEndVec.y) + (StartEndVec.z * StartEndVec.z))
    
	local Start2Screen, End2Screen = Vector3.new()
	if Spell.Range > 5000 then
		for i = 0, 25000 do
			if Engine:World2Screen(StartPos, Start2Screen) then
				if i > 0 then
					StartPos = Vector3.Math(StartPos.x - (totargetvecnorm.x * 2000), StartPos.y, StartPos.z - (totargetvecnorm.z * 2000))
                end
				break
			end
			if not Engine:World2Screen(StartPos, Start2Screen) then
				StartPos = Vector3(StartPos.x + (totargetvecnorm.x* i), StartPos.y, StartPos.z + (totargetvecnorm.z* i))
            end
		end
		for i = 0, 25000 do
			if Engine:World2Screen(EndPos, End2Screen) then
				if i > 0 then
					EndPos = Vector3(EndPos.x + (totargetvecnorm.x * 2000), EndPos.y, EndPos.z + (totargetvecnorm.z * 2000))
                end
				break
			end
			if not Engine:World2Screen(EndPos, End2Screen) then
				EndPos = Vector3.new(EndPos.x - (totargetvecnorm.x* i), EndPos.y, EndPos.z - (totargetvecnorm.z* i))
            end
		end
	end
	if DistToStartPos < length2 then
		SpellStartPos = CurrentPos
	else
		SpellStartPos = EndPos
    end
	
	SpellEndPos = EndPos
end

function Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell)
	local x = StartPos.x

	local y = StartPos.y

	local z = StartPos.z

	local xx = EndPos.x

	local yy = EndPos.y -- Critic: from yy = StartPos.y

	local zz = EndPos.z

	local x3 = xx - x

	local y3 = yy - y

	local z3 = zz - z

	local length3 = math.sqrt((x3 * x3) + (z3 * z3))
	x3 = (x3 / length3) * Spell.Radius
    z3 = (z3 / length3) * Spell.Radius

	local corners3D = {}

	local x4 = x - z3
	local z4 = z + x3

	local x5 = x + z3
	local z5 = z - x3

	local x6 = xx - z3
	local z6 = zz + x3

	local x7 = xx + z3
	local z7 = zz - x3

	corners3D[0] = { x4, y , z4 }
	corners3D[1] = { x5, y , z5 }
	corners3D[2] = { x6, yy ,z6 }
	corners3D[3] = { x7, yy ,z7 }
	return corners3D
end

function Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, RadiusAddition)
	local totargetvec = Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local length = math.sqrt((totargetvec.x * totargetvec.x) + (totargetvec.y * totargetvec.y) + (totargetvec.z * totargetvec.z))
	local totargetvecnorm = Vector3.new(totargetvec.x / length, 0, totargetvec.z / length)
	local mod = Spell.Range + RadiusAddition
	EndPos = Vector3.new(StartPos.x + (totargetvecnorm.x * mod), StartPos.y + (totargetvecnorm.y * mod), StartPos.z + (totargetvecnorm.z * mod))

	local x = StartPos.x

	local y = StartPos.y

	local z = StartPos.z

	local xx = EndPos.x

	local yy = EndPos.y -- Critic: from yy = StartPos.y

	local zz = EndPos.z

	local x3 = xx - x

	local y3 = yy - y

	local z3 = zz - z

	local length3 = math.sqrt((x3 * x3) + (z3 * z3))
	x3 = (x3 / length3) * (Spell.Radius+RadiusAddition)
	z3 = (z3 / length3) * (Spell.Radius+RadiusAddition)
	local corners3D = {}

	local x4 = x - z3
	local z4 = z + x3

	local x5 = x + z3
	local z5 = z - x3

	local x6 = xx - z3
	local z6 = zz + x3

	local x7 = xx + z3
	local z7 = zz - x3

	corners3D[0] = { x4, y , z4 }
	corners3D[1] = { x5, y , z5 }
	corners3D[2] = { x6, yy ,z6 }
	corners3D[3] = { x7, yy ,z7 }
	return corners3D
end

function Evade:CalcCircleSpellHitbox3D(EndPos, Spell, precision)
	local pointOnCircle3D = {}
	local radius = Spell.Radius
	for i = 0, i < precision do
		local angle = (i * math.pi) / 180
		pointOnCircle3D[i].x = math.cos(angle) * radius + EndPos.x
		pointOnCircle3D[i].y = EndPos.y
		pointOnCircle3D[i].z = math.sin(angle) * radius + EndPos.z
    end
	return pointOnCircle3D
end

function Evade:CalcEvadeCircle3D(PlayerPos, precision, RadiusAddition) 
	local pointOnCircle3D = {}
	local MousePos = Gamehud.MousePos
	local MouseDistance = math.sqrt(math.pow((MousePos.x - PlayerPos.x), 2) + math.pow((MousePos.z - PlayerPos.z), 2))
	local radius = MouseDistance
	for i = 0, i < precision do
		local angle = (i * math.pi) / 180
		pointOnCircle3D[i].x = math.cos(angle) * radius + PlayerPos.x
		pointOnCircle3D[i].y = PlayerPos.y
		pointOnCircle3D[i].z = math.sin(angle) * radius + PlayerPos.z
    end
	return pointOnCircle3D
end

function Evade:CalcEvadeDirection3D(EvadePoint3D, RadiusAddition) 
	local PlayerPos = myHero.Position
	local Bound = myHero.CharData.BoundingRadius
    local movetovector = Vector3.new(EvadePoint3D.x - PlayerPos.x, EvadePoint3D.y - PlayerPos.y, EvadePoint3D.z - PlayerPos.z)
    local length = math.sqrt((movetovector.x * movetovector.x) + (movetovector.y * movetovector.y) + (movetovector.z * movetovector.z))
    local movetovectornorm = Vector3.new(movetovector.x / length, movetovector.y / length, movetovector.z / length)
    local movespeed = myHero.MovementSpeed
    local mod = RadiusAddition
    return Vector3.new(PlayerPos.x + (movetovectornorm.x*mod), PlayerPos.y + (movetovectornorm.y*mod), PlayerPos.z + (movetovectornorm.z*mod))
end

--this entire function needs checking 225-232
function Evade:CalcLinearSpellHitbox2D(corners3D) 
	local corners2D = {}
	Engine:World2Screen(corners3D[0], corners2D[0])
	Engine:World2Screen(corners3D[1], corners2D[1])
	Engine:World2Screen(corners3D[2], corners2D[2])
	Engine:World2Screen(corners3D[3], corners2D[3])
	return corners2D
end

function Evade:CalcCircleSpellHitbox2D(pointOnCircle3D, precision)
	local pointOnCircle2D = {}
	for i = 0, i < precision do
		Engine:World2Screen(pointOnCircle3D[i], pointOnCircle2D[i])
    end
	return pointOnCircle2D
end
-- the draw functions need to be looked into
function Evade:DrawCircleHitbox(pDevice, pointOnCircle2D, precision) 
	for i = 0, i < precision-1 do
		Render:DrawLine(pDevice, pointOnCircle2D[i].x, pointOnCircle2D[i].y, pointOnCircle2D[i + 1].x, pointOnCircle2D[i + 1].y, 255, 255, 255, 255)
    end
end

function Evade:DrawLineHitbox(pDevice, corners2D) 
	Render:DrawLine(pDevice, corners2D[0].x, corners2D[0].y, corners2D[2].x, corners2D[2].y, 255, 255, 255, 255)
	Render:DrawLine(pDevice, corners2D[1].x, corners2D[1].y, corners2D[3].x, corners2D[3].y, 255, 255, 255, 255)
	Render:DrawLine(pDevice, corners2D[0].x, corners2D[0].y, corners2D[1].x, corners2D[1].y, 255, 0, 0, 255)
	Render:DrawLine(pDevice, corners2D[2].x, corners2D[2].y, corners2D[3].x, corners2D[3].y, 255, 0, 0, 255)
end

function Evade:ClosestLineFromLinearHitbox2D(corners2D, ClosestLineStart2D, ClosestLineEnd2D)
	local PlayerPos = myHero.Position
	local PlayerScreen
	Engine:World2Screen(PlayerPos, PlayerScreen)
	local dist
	dist[0] = Prediction:DistanceToLine2D(corners2D[0], corners2D[2], PlayerScreen)
	dist[1] = Prediction:DistanceToLine2D(corners2D[1], corners2D[3], PlayerScreen)
	dist[2] = Prediction:DistanceToLine2D(corners2D[0], corners2D[1], PlayerScreen)
	dist[3] = Prediction:DistanceToLine2D(corners2D[2], corners2D[3], PlayerScreen)
	local closestindex = 0
	local n = dist[0]
	for i = 1, i < 4 do
		if dist[i] < n then
			n = dist[i]
			closestindex = i
        end
    end
    if closestindex == 0 then
		ClosestLineStart2D = corners2D[0]
		ClosestLineEnd2D = corners2D[2]
    elseif closestindex == 1 then
		ClosestLineStart2D = corners2D[1]
		ClosestLineEnd2D = corners2D[3]
    elseif closestindex == 2 then
        if dist[0] < dist[0] then
			ClosestLineStart2D = corners2D[0]
			ClosestLineEnd2D = corners2D[2]
		else
			ClosestLineStart2D = corners2D[1]
			ClosestLineEnd2D = corners2D[3]
        end
    elseif closestindex == 3 then
        if dist[0] < dist[0] then
			ClosestLineStart2D = corners2D[0]
			ClosestLineEnd2D = corners2D[2]
		else
			ClosestLineStart2D = corners2D[1]
			ClosestLineEnd2D = corners2D[3]
        end
    end
end

function Evade:ClosestLineFromLinearHitbox3D(corners3D, ClosestLineStart3D, ClosestLineEnd3D) 
	local PlayerPos = myHero.Position
	local dist
	dist[0] = Prediction:DistanceToLine3D(corners3D[0], corners3D[2], PlayerPos)
	dist[1] = Prediction:DistanceToLine3D(corners3D[1], corners3D[3], PlayerPos)
	dist[2] = Prediction:DistanceToLine3D(corners3D[0], corners3D[1], PlayerPos)
	dist[3] = Prediction:DistanceToLine3D(corners3D[2], corners3D[3], PlayerPos)
	local closestindex = 0
	local n = dist[0]
	for i = 1, i < 4 do
		if dist[i] < n then
			n = dist[i]
			closestindex = i
        end
    end
    if closestindex == 0 then
		ClosestLineStart3D = corners3D[0]
		ClosestLineEnd3D = corners3D[2]
    elseif closestindex == 1 then
		ClosestLineStart3D = corners3D[1]
		ClosestLineEnd3D = corners3D[3]
    elseif closestindex == 2 then
        if dist[0] < dist[1] then
			ClosestLineStart3D = corners3D[0]
			ClosestLineEnd3D = corners3D[2]
		else 
			ClosestLineStart3D = corners3D[1]
			ClosestLineEnd3D = corners3D[3]
        end
    elseif closestindex == 3 then
		if dist[0] < dist[1] then
			ClosestLineStart3D = corners3D[0]
			ClosestLineEnd3D = corners3D[2]
		else
			ClosestLineStart3D = corners3D[1]
			ClosestLineEnd3D = corners3D[3]
        end
    end
end
-- this function needs to be checked too
function Evade:ClosestPointFromCircle3D(pointOnCircle3D, precision)
	local dist = precision
	-- dist[0] = HUGE_VALF
    for i = 0, i < precision - 1 do
        dist[i] = Evade:GetDist(pointOnCircle3D[i], myHero.Position)
    end
	local closestindex = 0
	local n = dist[0]
	for i = 1, i < precision - 1 do
		if dist[i] < n then
			n = dist[i]
			closestindex = i
        end
	end
	return pointOnCircle3D[closestindex]
end

function Evade:GetMissilePredPos(MissileStartPos, MissileEndPos, missilespeed, delay, time)
	local StartPos = MissileStartPos
	local EndPos = MissileEndPos
	local totargetvec = Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local length = math.sqrt((totargetvec.x * totargetvec.x) + (totargetvec.y * totargetvec.y) + (totargetvec.z * totargetvec.z))
	local totargetvectornorm = Vector3.new(totargetvec.x / length, 0, totargetvec.z / length)
	local mod = missilespeed * (time - delay)
	local predpos = Vector3.new(StartPos.x + (totargetvectornorm.x*mod), StartPos.y + (totargetvectornorm.y*mod), StartPos.z + (totargetvectornorm.z*mod))
	return predpos
end

function Evade:GetTimeToEvadePos(EvadePos)
	local StartPos = myHero.Position
	local EndPos = EvadePos
	local totargetvec = Vector3.new(EndPos.x - StartPos.x, 0, EndPos.z - StartPos.z)
	local distance = math.sqrt((totargetvec.x * totargetvec.x) + (totargetvec.y * totargetvec.y) + (totargetvec.z * totargetvec.z))
	local movespeed = myHero.MovementSpeed
	local time = distance / movespeed
	return time
end

function Evade:EvadePointClosestToMouse(StartPos, EndPos, EvadeCircle, HitBox, Spell, precision, RadiusAddition)
	local ClosestPoint = Vector3.new(0,0,0)
	local PlayerPos = myHero.Position
	local MousePos = Gamehud.MousePos
	local Bound = myHero.CharData.BoundingRadius
	local bufferdist = HUGE_VALF
	local colorself = 0x00FF88FF
	for i = 0, i < precision do
		local Point = EvadeCircle[i]
        if Prediction:PointOnLineSegment3D(StartPos, EndPos, Point, Spell.Radius + RadiusAddition + Bound*2) then
            --this may cause unintended behavior
			goto continue
        end
        --wrong function or wrong class
        if Prediction:WallBetween(PlayerPos,Point,10) then
            --this may cause unintended behavior
			goto continue
        end
		--Engine::DrawCircle(&Point, 65.f, &colorself, 0, 0, 0, 1.f)

		local MouseDistance = math.sqrt(math.pow((Point.x - MousePos.x), 2) + math.pow((Point.z - MousePos.z), 2))
		if MouseDistance < bufferdist then
			bufferdist = MouseDistance
			ClosestPoint = Point
        end
    end
    ::continue::
    
	--Engine::DrawCircle(&MousePos, 65.f, &colorself, 0, 0, 0, 1.f)

	return ClosestPoint
end

function Evade:GetEvadePos(StartPos, EndPos, HitBox, Spell, precision, RadiusAddition)
	local PlayerPos = myHero.Position
	local MousePos = GameHud.MousePos
	local Bound = myHero.CharData.BoundingRadius
	if (Spell.Type == 0) then
		local StartEndVec = Vector3.new(EndPos.x - StartPos.x, EndPos.y - StartPos.y, EndPos.z - StartPos.z)
		local Length = math.sqrt((StartEndVec.x * StartEndVec.x) + (StartEndVec.y * StartEndVec.y) + (StartEndVec.z * StartEndVec.z))
		local StartPlayerVec = Vector3.new(PlayerPos.x - StartPos.x, PlayerPos.y - StartPos.y, PlayerPos.z - StartPos.z)
		local DistanceToStartPos = math.sqrt((StartPlayerVec.x * StartPlayerVec.x) + (StartPlayerVec.y * StartPlayerVec.y) + (StartPlayerVec.z * StartPlayerVec.z))
		local EndPlayerVec = Vector3.new(PlayerPos.x - EndPos.x, PlayerPos.y - EndPos.y, PlayerPos.z - EndPos.z)
		local DistanceToEndPos = math.sqrt((EndPlayerVec.x * EndPlayerVec.x) + (EndPlayerVec.y * EndPlayerVec.y) + (EndPlayerVec.z * EndPlayerVec.z))
		local IntersectionPoint = Vector3.new()
		local ClosestLineStart3D = Vector3.new()
		local ClosestLineEnd3D = Vector3.new()
		
		Evade:ClosestLineFromLinearHitbox3D(HitBox, ClosestLineStart3D, ClosestLineEnd3D)

		-- //DWORD colorself = 0x00FF88FF
		-- //Engine::DrawCircle(&ClosestLineStart3D, 65.f, &colorself, 0, 0, 0, 1.f)
		-- //Engine::DrawCircle(&ClosestLineEnd3D, 65.f, &colorself, 0, 0, 0, 1.f)


		PlayerPredMovePos = CalcEvadeDirection3D(MousePos, 50)

		local ClosestPoint = Prediction:GetShortestPointToLine3D(ClosestLineStart3D, ClosestLineEnd3D, PlayerPredMovePos)
		local ClosestDirection = CalcEvadeDirection3D(ClosestPoint, 300)
		if Prediction:PointOnLineSegment3D(StartPos, EndPos, PlayerPos, Spell.Radius + RadiusAddition/2) then --If Player in SkillShot move Out
			DZone = Inside
			return ClosestDirection
        end
		if Prediction:PointOnLineSegment3D(StartPos, EndPos, PlayerPos, Spell.Radius + RadiusAddition + Bound) then --If Player about to Leave SkillShot
			DZone = AtBorder
			if Prediction:LineIntersection3D(StartPos, EndPos, PlayerPos, MousePos, IntersectionPoint) then
				return Prediction:GetShortestPointToLine3D(ClosestLineStart3D, ClosestLineEnd3D, MousePos)
            end
			if Prediction:PointOnLineSegment3D(StartPos, EndPos, MousePos, Spell.Radius + RadiusAddition + Bound) then
				return Prediction:GetShortestPointToLine3D(ClosestLineStart3D, ClosestLineEnd3D, MousePos)
            end
			-- //return MousePos
		end
		if Prediction:PointOnLineSegment3D(StartPos, EndPos, PlayerPos, Spell.Radius + RadiusAddition*3) then --If Player outside but Mouse inside Skillshot, dont move In
			if Prediction:PointOnLineSegment3D(StartPos, EndPos, MousePos, Spell.Radius + RadiusAddition + Bound) or
				Prediction:LineIntersection3D(StartPos, EndPos, PlayerPos, MousePos, IntersectionPoint) then
				DZone = Outside
				if Orbwalker.Mode ~= Idle then
					return Prediction:GetShortestPointToLine3D(ClosestLineStart3D, ClosestLineEnd3D, MousePos)
                end
			end
		end
	end
	return Vector3.new(0, 0, 0)
end

function EvadeToPoint(Point, Spell)
	if Point.x ~= 0 and Point.y ~= 0 and Point.z ~= 0 then
		-- if myHero.ChampionName == "Yasuo" then
		-- 	if (Menu::UseW && Engine::SpellReady(W))
		-- 	{
		-- 		Engine::BlockAA = false
        --     }
        -- end
        Engine:MoveClick(Point)
		return 1
	end
	return 0
end

function Evade:PlayerHasOlafR()
	if myHero.BuffData:GetBuff("OlafRagnarok").Valid then
		return true
    end
	return false
end

function Evade:OnTick()
	DZone = "Outside"

	local CircleColor = 0x000000FF

	local precision = 361
	local EvadeDelay = 0.2

	local RadiusAddition = myHero.CharData.BoundingRadius*2.5
	
	local OnlyCC = false
	local EvadeActive = true
	local IgnoreCircular = true

	if Engine:IsKeyDown("HK_COMBO") then
		OnlyCC = true
		EvadeActive = true
	end

	if (OnlyCC) then
		if myHero.ChampionName == "Olaf" then
			if PlayerHasOlafR() then
				EvadeActive = false
			end
		end
	end

	local PlayerPos = myHero.Position

	local Missiles = ObjectManager.MissileList
	for I, Missile in pairs(Missiles) do
		if Missile.Team ~= myHero.Team then 
			local Spell = self.Spells[Missile.Name]
			if Spell ~= nil and Spell.Type == 0 then
				local StartPos, EndPos, StartScreen, EndScreen = Vector3.new(), Vector3.new(),Vector3.new(),Vector3.new()
				Evade:CalcLinearMissileStartEndPos(Missile, Missile.MissileStartPos, Missile.MissileEndPos, Spell, StartPos, EndPos);
				if Spell.Range <= 5000 then -- if "short spell"
					-- if Render:World2Screen(StartPos, StartScreen) or Render:World2Screen(EndPos, EndScreen) then -- only draw when on screen
					-- 	local corners3D = CalcLinearSpellHitbox3D(StartPos, EndPos, Spell);
					-- 	local corners2D = CalcLinearSpellHitbox2D(corners3D);
					-- 	-- ehhhh?? DrawLineHitbox(pDevice, corners2D);
					-- end
				end
				if Spell.Range > 5000 then --if global
					local corners3D = CalcLinearSpellHitbox3D(StartPos, EndPos, Spell)
					local corners2D = CalcLinearSpellHitbox2D(corners3D)
					-- ehhh ? DrawLineHitbox(pDevice, corners2D);
				end
				if OnlyCC and not Spell.CC then
					EvadeActive = false
				end
				-- //if (Spell->range <= 5000) // if "short spell"
				-- //{
				-- //	CalcLinearSpellStartEndPos(Missile->GetMissileStartPos(), Missile->GetMissileEndPos(), Spell, StartPos, EndPos); //always dodge full range of hitbox
				-- //}
				if EvadeActive and Prediction:PointOnLineSegment(Missile.MissileStartPos, Missile.MissileEndPos, PlayerPos, Spell.Radius + RadiusAddition * 3) then -- //If Player in Range of Skillshot
					if Prediction:WillCollideWithMinion(Missile.MissileStartPos, Missile.MissileEndPos, Spell.Radius) then
						if not Prediction:WillCollideWithMinion(Missile.MissileStartPos, Missile.MissileEndPos, Spell.Radius) then
							local AdvancedHitbox = Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, RadiusAddition);
							local Point = Evade:GetEvadePos(StartPos, EndPos, AdvancedHitbox, Spell, precision, RadiusAddition);
							EvadeToPoint(Point, Spell);
						end
					else
						local AdvancedHitbox = Evade:CalcLinearSpellHitbox3D(StartPos, EndPos, Spell, RadiusAddition);
						local Point = Evade:GetEvadePos(StartPos, EndPos, AdvancedHitbox, Spell, precision, RadiusAddition);
						EvadeToPoint(Point, Spell);
					end
				end
			end
		end
	end
end

function Evade:OnDraw()

end

function Evade:OnLoad()
    AddEvent("OnTick", function() Evade:OnTick() end)
	AddEvent("OnDraw", function() Evade:OnDraw() end)
	Evade:__init()
end

AddEvent("OnLoad", function() Evade:OnLoad() end)