require("BuffLib")
require("Enums")
require("DamageLib")
require("SpellLib")
require("ItemLib")
require("ObjectLib")
require("VectorCalculations")
require("MapPositions")

local Kindred = {
    SelectedAlly = {},
    TargetingOptions = {
        "ON",
        "OFF",
    },
    WSpots = {
        --[[Pos.x:  7106.0
Pos.y:  48.527000427246
Pos.z:  5058.0]]
        Vector3.new(12250.0, 52.809356689453, 6358.0),
        Vector3.new(11586.0, 51.726753234863, 7098.0),
        Vector3.new(7684.0, 51.626106262207, 9928.0),
        Vector3.new(11094.0, 59.695953369141, 8470.0),
        Vector3.new(7464.0, 54.683773040771, 11320.0),
        Vector3.new(7332.0, 52.417633056641, 3516.0),
        Vector3.new(3644.0, 52.470272064209, 6338.0),
        Vector3.new(7106.0, 48.527000427246, 5058.0),
        Vector3.new(9446.0, -71.240600585938, 5622.0),
        Vector3.new(10818.0 , -65.779487609863, 5008.0),
        Vector3.new(5218.0, -71.240600585938, 9162.0),
        Vector3.new(4012.0, -71.240600585938, 9830.0),
        Vector3.new(3244.0, 51.902683258057, 7800.0),
        Vector3.new(2560.0, 51.779006958008, 8522.0),
        Vector3.new(10045.23046875, -71.240600585938, 4692.7612304688),
        Vector3.new(4692.0, -71.240600585938, 10058.0),
        Vector3.new(6427.234375, 56.369567871094, 12433.599609375),
        Vector3.new(8416.0, 50.525283813477, 2488.0),

    },
    QSpotsBotRed = {
        Vector3.new(8070.0, -71.240600585938, 6204.0), --River long bush bot
        Vector3.new(7884.0, 50.884880065918, 5902.0), 
        Vector3.new(7224.0, 52.451301574707, 5958.0), -- bot Chickens 1
        Vector3.new(7098.0, 57.330940246582, 5578.0),
        Vector3.new(9350.0, -71.240600585938, 4506.0), -- Dragon 1
        Vector3.new(9022.0, 52.721687316895, 4408.0),
        Vector3.new(9530.0, -69.45352935791, 4100.0), -- Dragon 2
        Vector3.new(9328.0, 60.449569702148, 3754.0),
        Vector3.new(9572.0, 60.616790771484, 3108.0), -- bot krug 1
        Vector3.new(9354.0, 49.222991943359, 2812.0),
        Vector3.new(8122.0, 51.550800323486, 3158.0), -- bot krug 2
        Vector3.new(8346.0, 51.130001068115, 2820.0),
        Vector3.new(4532.0, 95.748077392578, 3220.0), -- bot base 1 -- 1
        Vector3.new(4774.0, 50.801635742188, 3408.0),
        Vector3.new(5024.0, 51.859214782715, 2208.0), -- bot base 1 -- 2
        Vector3.new(4674.0, 95.748046875, 2208.0),
        Vector3.new(9672.0, -71.240600585938, 4908.0), -- Dragon 3
        Vector3.new(9722.0, -71.112106323242, 5208.0),
        Vector3.new(10472.0, -71.240600585938, 4358.0), -- Dragon 4
        Vector3.new(10822.0, -70.674560546875,  4408.0),
        --[[Pos.x:  6650.0
Pos.y:  48.56534576416
Pos.z:  3790.0]]
    },
    QSpotsBotRedMedium = {
        Vector3.new(8472.0, 51.130001068115, 2108.0), -- bot krug 3
        Vector3.new(8496.0, 49.450332641602, 1728.0),
        Vector3.new(8012.0, 53.720909118652, 3914.0), -- bot red 3
        Vector3.new(8284.0, 53.75074005127, 3622.0),
        Vector3.new(6424.0, 48.527183532715, 5098.0), -- bot Chickens 2
        Vector3.new(6790.0, 48.527000427246, 5218.0),
    },
    QSpotsBotRedHard = {
        Vector3.new(6650.0, 48.56534576416, 3790.0), -- bot red 2
        Vector3.new(6324.0, 49.666618347168, 3558.0),
        Vector3.new(7788.0, 53.666278839111, 4332.0), -- bot red 1
        Vector3.new(7694.0, 49.532539367676, 4722.0),
    },
    QSpotsBotBlue = {
        Vector3.new(10472.0, 64.102043151855, 8606.0), -- bot wolfs 1
        Vector3.new(10772.0, 63.136688232422, 8456.0),
        --Vector3.new(11072.0, 62.272243499756, 8156.0), -- bot wolfs 2
        --Vector3.new(11122.0, 52.203338623047, 7806.0),
        Vector3.new(11144.0, 52.205841064453, 7512.0), -- bot blue 1
        Vector3.new(11152.0, 51.724956512451, 7228.0),
        Vector3.new(10392.0, 51.977863311768, 6776.0), --bot blue 2
        Vector3.new(10728.0, 51.722599029541, 6928.0),
        Vector3.new(12872.0, 51.703861236572, 6958.0), --bot gromp 1
        Vector3.new(12658.0, 51.666847229004, 6624.0),
        Vector3.new(13172.0, 55.412246704102, 6108.0), -- bot gromp 2
        Vector3.new(12792.0, 51.723453521729, 6172.0),
        Vector3.new(11972.0, 52.381332397461, 5658.0), -- bot gromp 3
        Vector3.new(12278.0, 52.889419555664, 5572.0),
        Vector3.new(11922.0, 51.729400634766, 4758.0), -- bot tower 2 --1
        Vector3.new(11734.0, -71.240600585938, 4646.0),
        Vector3.new(12788.0, 52.769718170166, 4942.0), -- bot tower 2 --2
        Vector3.new(13072.0, 51.664863586426, 4858.0),
        Vector3.new(11630.0, 62.49870300293, 8674.0), -- bot wolf 3
        Vector3.new(11836.0, 50.306777954102, 8834.0),
        Vector3.new(12672.0, 52.306301116943, 9906.0), -- bot base 2 -- 2
        Vector3.new(12722.0, 91.429779052734, 10206.0),
        Vector3.new(11680.0, 91.429809570312, 10396.0), -- bot base 2 -- 1
        Vector3.new(11572.0, 52.306304931641, 10106.0),
        --[[Pos.x:  9722.0
Pos.y:  -71.112106323242
Pos.z:  5208.0]]
    },
    QSpotsTopBlue = {
        Vector3.new(4073.7048339844, 52.466514587402, 6456.3374023438), --top wolf 1
        Vector3.new(4324.0, 51.543388366699, 6258.0),
        --Vector3.new(3730.0161132812, 50.206153869629, 7098.5571289062), -- top wolf 2
        --Vector3.new(3773.7907714844, 52.459842681885, 6706.19921875),
        Vector3.new(4098.0, 50.70703125, 7982.0), -- top blue 1
        Vector3.new(4370.0, 48.717166900635, 8146.0),
        Vector3.new(3774.0, 52.108779907227, 7706.0), -- top blue 2
        Vector3.new(3752.0, 51.816219329834, 7406.0),
        Vector3.new(2874.0, 50.701881408691, 9078.0), -- top gromp 3
        Vector3.new(2524.0, 51.775066375732, 9106.0),
        Vector3.new(3168.0, 28.998699188232, 9764.0), -- top blue tower 1--2
        Vector3.new(3474.0, -64.667640686035, 9806.0),
        Vector3.new(3224.0, 52.292461395264, 6258.0), -- top wolf 3
        Vector3.new(3018.0, 57.047428131104, 6082.0),
        Vector3.new(3180.0, 54.075866699219, 4884.0), -- top base 1 -- 1
        Vector3.new(3088.0, 95.748031616211, 4550.0),
        Vector3.new(2124.0, 95.748046875, 4708.0), -- top base 1 -- 2
        Vector3.new(2124.0, 52.628303527832, 5058.0),
        --[[Pos.x:  11152.0
Pos.y:  51.724956512451
Pos.z:  7228.0]]
    },
    QSpotsTopBlueMedium = {
        Vector3.new(2094.0, 50.415542602539, 7870.0), -- top gromp 1
        Vector3.new(2256.0, 51.783241271973, 8204.0),
        Vector3.new(1682.0, 52.141666412354, 8764.0), -- top gromp 2
        Vector3.new(2024.0, 51.777198791504, 8756.0),
        Vector3.new(2170.0, 53.640686035156, 10064.0), -- top blue tower 1
        Vector3.new(1784.0, 52.83810043335, 10060.0),
    },
    QSpotsTopRed = {
        Vector3.new(8976.0, 56.47679901123, 12748.0), -- top red tower 1
        Vector3.new(9362.0, 52.693092346191, 12844.0),
        Vector3.new(7538.0, 52.87260055542, 8948.0), -- top chickens 1
        Vector3.new(7722.0, 52.447235107422, 9306.0),
        Vector3.new(8072.0, 51.590766906738, 9706.0), -- top chickens 2
        Vector3.new(8362.0, 50.382827758789, 9792.0),
        Vector3.new(6720.0, 53.829666137695, 11722.0), -- top krugs 1
        Vector3.new(6462.0, 56.47679901123, 12000.0),
        Vector3.new(5124.0, 56.835746765137, 11806.0), -- top krugs 3
        Vector3.new(5174.0, 56.47679901123, 12106.0),
        Vector3.new(5492.0, -72.768859863281, 10448.0), -- baron 2
        Vector3.new(5836.0, 54.618804931641, 10360.0),
        Vector3.new(10022.0, 52.306301116943, 11556.0), -- top base 2 -- 1
        Vector3.new(10322.0, 91.429779052734, 11706.0),
        Vector3.new(9772.0, 52.306304931641, 12506.0), -- top base 2 -- 2
        Vector3.new(10122.0, 91.429840087891, 12606.0),
        Vector3.new(5198.0, -71.240600585938, 9986.0), -- baron 3
        Vector3.new(5124.0, -70.360687255859, 9706.0),
        Vector3.new(4474.0, -70.927978515625, 10456.0), -- baron 4
        Vector3.new(4196.0, -71.240600585938, 10322.0),
        Vector3.new(7084.0, 52.872604370117, 8790.0), -- top river long bush
        Vector3.new(6808.0, -71.240600585938, 8588.0),
        --[[Pos.x:  8172.0
Pos.y:  50.753890991211
Pos.z:  11106.0]]
    },
    QSpotsTopRedMedium = {
        Vector3.new(6500.0, 56.667114257812, 11264.0), -- top red 3
        Vector3.new(6844.0, 55.999702453613, 11022.0),
        Vector3.new(6320.0, 52.83810043335, 13196.0), -- top krugs 2
        Vector3.new(6424.0, 55.185958862305, 12806.0),
        Vector3.new(5224.0, -71.240600585938, 10906.0), -- baron 1
        Vector3.new(5416.0, 56.830474853516, 11256.0),
        Vector3.new(8506.0, 52.592430114746, 11300.0), -- top red 2
        Vector3.new(8172.0, 50.753890991211, 11106.0),
    },
    QSpotsTopRedHard = {
        Vector3.new(7208.0, 51.679592132568, 10226.0), -- top red 1
        Vector3.new(7078.0, 56.033496856689, 10602.0),
    },
}

---///MADE BY: Critic///---
---///CREDITS: Christoph and specially Scortch///---
---///EXTRA CREDITS: Demontime and MrWong///---

function Kindred:__init()

    self.ScriptVersion = "          --CCKindred Version: 1.5--"

    self.RangeQ = 340
    self.RangeW = 550
    self.RangeR = 500
    
    self.TimerStart = 0
    self.TimerStart2 = 0
    self.TimerStart3 = 0
    self.TimerStart4 = 0
    self.TimerStart5 = 0

    self.IsEvadeLoaded = false

    self.ChampionMenu = Menu:CreateMenu("Kindred")
    ---------------------------------------------
    self.KindredCombo           = self.ChampionMenu:AddSubMenu("Combo")
    self.KindredCombo:AddLabel("Check Spells for Combo:")
    -----------------COMBO-----------------------
    self.UseQCombo              = self.KindredCombo:AddCheckbox("Use Q in combo", 1)
    --self.DodgeQ                 = self.KindredCombo:AddCheckbox("Dodge Q", 1)
    self.GapcloseQ              = self.KindredCombo:AddSlider("Gapclose with Q if less than X enemies", 3,1,5,1)
    self.UseWCombo              = self.KindredCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo              = self.KindredCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo              = self.KindredCombo:AddCheckbox("Use R in combo", 1)
    -----------------R-SETTINGS------------------
    self.KindredR               = self.KindredCombo:AddSubMenu("R settings")
    self.KindredR:AddLabel("Manage R usage:")
    --.........................................--
    self.useRtoSave             = self.KindredR:AddCheckbox("Use R on myself", 1)
    self.useRonAlly             = self.KindredR:AddCheckbox("Use R on ally", 1)
    --.........................................--
    self.DontREnemy             = self.KindredR:AddCheckbox("Don't R enemy in R range (silder below)", 1)
    self.WHPSliderEnemyCombo    = self.KindredR:AddSlider("Don't R if enemy below % HP", 30,1,100,1)
    --.........................................--
    self.MoreAllies             = self.KindredR:AddCheckbox("Don't R if more allies than enemies in range", 1)
    self.MoreAlliesSlider       = self.KindredR:AddSlider("X more amount of allies", 2,1,4,1)
    -----------------AllyTargetSelector----------
    self.TargetSelector         = self.ChampionMenu:AddSubMenu("Force R selected allies")
	self.TargetOption           = self.TargetSelector:AddCombobox("Select allies", Kindred.TargetingOptions)
    -----------------Harass----------------------
    self.KindredHarass          = self.ChampionMenu:AddSubMenu("Harass")
    self.KindredHarass:AddLabel("Check Spells for Harass:")

    self.UseQHarass             = self.KindredHarass:AddCheckbox("Use Q in Harass", 1)
    self.HarassQMana            = self.KindredHarass:AddSlider("Minimum % mana to use Q", 45,1,100,1)   
    self.UseWHarass             = self.KindredHarass:AddCheckbox("Use W in Harass", 1)
    self.HarassWMana            = self.KindredHarass:AddSlider("Minimum % mana to use W", 75,1,100,1)
    self.UseEHarass             = self.KindredHarass:AddCheckbox("Use E in Harass", 1)
    self.HarassEMana            = self.KindredHarass:AddSlider("Minimum % mana to use E", 60,1,100,1)
    -----------------Lane/JungleClear------------
    self.ClearMenu              = self.ChampionMenu:AddSubMenu("Lane/JungleClear")
    self.ClearMenu:AddLabel("Spell options for Lane/jungle clear:")
    -----------------Lane------------------------
    self.LaneClearMenu          = self.ClearMenu:AddSubMenu("(BETA:) Lane/Jungle")

    self.LaneClearUseQ          = self.LaneClearMenu:AddCheckbox("Use Q in Laneclear", 1)
    self.QLaneClearSettings     = self.LaneClearMenu:AddSubMenu("Q Laneclear Settings")
    self.LaneClearQMana         = self.QLaneClearSettings:AddSlider("Minimum % mana to use Q", 35,1,100,1)

    self.LaneClearUseW          = self.LaneClearMenu:AddCheckbox("Use W in Laneclear", 1)
    self.WLaneClearSettings     = self.LaneClearMenu:AddSubMenu("W Laneclear Settings")
    self.LaneClearWMana         = self.WLaneClearSettings:AddSlider("Minimum % mana to use W", 30,1,100,1)

    self.LaneClearUseE          = self.LaneClearMenu:AddCheckbox("Use E in Laneclear", 1)
    self.ELaneClearSettings     = self.LaneClearMenu:AddSubMenu("E Laneclear Settings")
    self.LaneClearEMana         = self.ELaneClearSettings:AddSlider("Minimum % mana to use E", 25,1,100,1)
    -----------------DRAWINGS--------------------
    self.KindredDrawings        = self.ChampionMenu:AddSubMenu("Drawings")

    self.DrawQ                  = self.KindredDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawW                  = self.KindredDrawings:AddCheckbox("Use W in drawings", 1)
    self.DrawR                  = self.KindredDrawings:AddCheckbox("Use R in drawings", 1)
    self.ExtraDrawings          = self.KindredDrawings:AddSubMenu("Extra Drawings")
    self.DrawJungleCamp         = self.ExtraDrawings:AddCheckbox("Possibe Mark Positions", 1)
    self.DrawRTime              = self.ExtraDrawings:AddCheckbox("Draw R time", 1)
    self.DrawJungleMark         = self.ExtraDrawings:AddCheckbox("(Alpha)Track Jungle mark", 1)
    self.DrawCheatSheet         = self.ExtraDrawings:AddCheckbox("Draw mark cheatsheet", 1)
    self.DrawEnemyHitMark       = self.ExtraDrawings:AddCheckbox("Track enemy mark online", 1)

    Kindred:LoadSettings()
end

function Kindred:SaveSettings()
    SettingsManager:CreateSettings("Kindred")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    ----------------------------------------------
    --SettingsManager:AddSettingsGroup("Qmodes")
    --SettingsManager:AddSettingsInt("Use Q to mouse", self.QToMouse.Value)
    --SettingsManager:AddSettingsInt("Use Q to target", self.QToTarget.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Rsettings")
    SettingsManager:AddSettingsInt("Use R on myself", self.useRtoSave.Value)
    SettingsManager:AddSettingsInt("Use R on ally", self.useRonAlly.Value)
    --SettingsManager:AddSettingsInt("Use R when you or ally below % HP", self.WHPSliderAllyCombo.Value)
    SettingsManager:AddSettingsInt("Don't R enemy in R range (silder below)", self.DontREnemy.Value)
    SettingsManager:AddSettingsInt("Don't R if enemy below % HP", self.WHPSliderEnemyCombo.Value)
    SettingsManager:AddSettingsInt("Don't R if more allies than enemies in range", self.MoreAllies.Value)
    SettingsManager:AddSettingsInt("X more amount of allies", self.MoreAlliesSlider.Value)
    SettingsManager:AddSettingsInt("ONOFF", self.TargetOption.Selected)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use W", self.HarassWMana.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.HarassEMana.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("Use Q in Laneclear", self.LaneClearUseQ.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneClearQMana.Value)
    SettingsManager:AddSettingsInt("Use W in Laneclear", self.LaneClearUseW.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use W", self.LaneClearWMana.Value)
    SettingsManager:AddSettingsInt("Use E in Laneclear", self.LaneClearUseE.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.LaneClearEMana.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
    SettingsManager:AddSettingsInt("Possibe Mark Positions", self.DrawJungleCamp.Value)
    SettingsManager:AddSettingsInt("Draw R time", self.DrawRTime.Value)
    SettingsManager:AddSettingsInt("Track jungle mark", self.DrawJungleMark.Value)
    SettingsManager:AddSettingsInt("Draw mark cheatsheet",  self.DrawCheatSheet.Value)
    SettingsManager:AddSettingsInt("Track enemy mark online", self.DrawEnemyHitMark.Value)
end

function Kindred:LoadSettings()
    SettingsManager:GetSettingsFile("Kindred")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    ----------------------------------------------
    --self.QToMouse.Value     = SettingsManager:GetSettingsInt("Qmodes", "Use Q to mouse")
    --self.QToTarget.Value    = SettingsManager:GetSettingsInt("Qmodes", "Use Q to target")
    ----------------------------------------------
    self.useRtoSave.Value           = SettingsManager:GetSettingsInt("Rsettings", "Use R on myself")
    self.useRonAlly.Value           = SettingsManager:GetSettingsInt("Rsettings", "Use R on ally")
    --self.WHPSliderAllyCombo.Value   = SettingsManager:GetSettingsInt("Rsettings", "Use R when you or ally below % HP")
    self.DontREnemy.Value           = SettingsManager:GetSettingsInt("Rsettings", "Don't R enemy in R range (silder below)")
    self.WHPSliderEnemyCombo.Value  = SettingsManager:GetSettingsInt("Rsettings", "Don't R if enemy below % HP")
    self.MoreAllies.Value           = SettingsManager:GetSettingsInt("Rsettings", "Don't R if more allies than enemies in range")
    self.MoreAlliesSlider.Value     = SettingsManager:GetSettingsInt("Rsettings", "X more amount of allies")
    self.TargetOption.Selected     = SettingsManager:GetSettingsInt("Rsettings", "ONOFF")
    ----------------------------------------------
    self.UseQHarass.Value           = SettingsManager:GetSettingsInt("Harass", "Use Q in Harass")
    self.HarassQMana.Value          = SettingsManager:GetSettingsInt("Harass", "Minimum % mana to use Q")
    self.UseWHarass.Value           = SettingsManager:GetSettingsInt("Harass", "Use W in Harass")
    self.HarassWMana.Value          = SettingsManager:GetSettingsInt("Harass", "Minimum % mana to use W")
    self.UseEHarass.Value           = SettingsManager:GetSettingsInt("Harass", "Use E in Harass")
    self.HarassEMana.Value          = SettingsManager:GetSettingsInt("Harass", "Minimum % mana to use E")
    ----------------------------------------------
    self.LaneClearUseQ.Value        = SettingsManager:GetSettingsInt("Laneclear", "Use Q in Laneclear")
    self.LaneClearQMana.Value       = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    self.LaneClearUseW.Value        = SettingsManager:GetSettingsInt("Laneclear", "Use W in Laneclear")
    self.LaneClearQMana.Value       = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use W")
    self.LaneClearUseE.Value        = SettingsManager:GetSettingsInt("Laneclear", "Use E in Laneclear")
    self.LaneClearQMana.Value       = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use E")
    ----------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R in drawings")
    self.DrawJungleCamp.Value = SettingsManager:GetSettingsInt("Drawings", "Possibe Mark Positions")
    self.DrawRTime.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R time")
    self.DrawJungleMark.Value = SettingsManager:GetSettingsInt("Drawings", "Track jungle mark")
    self.DrawCheatSheet.Value = SettingsManager:GetSettingsInt("Drawings", "Draw mark cheatsheet")
    self.DrawEnemyHitMark.Value = SettingsManager:GetSettingsInt("Drawings", "Track enemy mark online")
    if Evade ~= nil then
        self.IsEvadeLoaded = true
    else
        print('enable evade for Dodge Q')
    end
end

function Kindred:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Kindred:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Kindred:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * (myHero.Level - 2) / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        if FinalArmor <= 0 then
            FinalArmor = 0
        end
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Kindred:HasInfinityEdge()
	return myHero.CritMod >= 0.6
end

function Kindred:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Kindred:EnemyVSAlly(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.IsTargetable then
            if Hero.Team ~= myHero.Team then
                if self:GetDistance(Hero.Position , Position) < Range then
                    Count = Count + 1
                end
            else
                if self:GetDistance(Hero.Position , Position) < Range then
                    Count = Count - 1
                end
            end
        end
    end
    return Count
end

function Kindred:AlliesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsTargetable then
            if self:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Kindred:CheckCollision(startPos, endPos, r)
    local distanceP1_P2 = self:GetDistance(startPos,endPos)
    local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
    local unitPos = myHero.Position
    local distanceP1_Unit = self:GetDistance(startPos,unitPos)
    if distanceP1_Unit <= distanceP1_P2 then
        local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
        if self:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
            return true
        end
    end
    return false
end

function Kindred:QCastPos()
	local PlayerPos 	= GameHud.MousePos
	local TargetPos 	= myHero.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -340
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Kindred:Qdodge()
    if self.IsEvadeLoaded then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do
            if Hero.Team ~= myHero.Team then
                if self.DodgeQ.Value == 1 then
                    local Missiles = ObjectManager.MissileList
                    for I, Missile in pairs(Missiles) do
                        if Missile.Team ~= myHero.Team then 
                            local Info = Evade.Spells[Missile.Name]
                            local dodgepos = Evade:GetDodgePos()
                            if Info ~= nil and Info.Type == 0 then
                                if Info.CC == 1 then
                                    if self:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius + 70) then
                                        if Engine:SpellReady("HK_SPELL1") then
                                            Engine:CastSpell("HK_SPELL1",  dodgepos)
                                            print("Dodged1")
                                            return
                                        end
                                    end
                                else 
                                    if myHero.Health <= myHero.MaxHealth / 100 * 35 then
                                        if self:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius + 70) then
                                            if Engine:SpellReady("HK_SPELL1") then
                                                Engine:CastSpell("HK_SPELL1",  dodgepos)
                                                print("Dodged2")
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Kindred:Combo()
    if self.UseECombo.Value == 1 and Engine:SpellReady('HK_SPELL3') and Engine:SpellReady("HK_SPELL1") == false then
        local target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
        if target then
            local DMGBefore = (myHero.BaseAttack + myHero.BonusAttack) * (1 + myHero.CritChance) * 4 + (40 + 140 / 17 * (myHero.Level - 1))
            local Kraken = 0
            --print(myHero:GetSpellSlot(0).Cooldown - GameClock.Time)
            local QCD = myHero:GetSpellSlot(0).Cooldown - GameClock.Time
            if QCD < 2 then
                DMGBefore = DMGBefore + 35 + myHero:GetSpellSlot(0).Level * 25 + myHero.BonusAttack * 0.75
            end
            if myHero.CritChance >= 0.19 then
                Kraken = 50 + myHero.BonusAttack * 0.4
            end
            if (target.Health) / target.MaxHealth <= 0.4 then
                DMGBefore = DMGBefore * 1.08
            else
                if (target.Health) / target.MaxHealth <= 0.5 then
                    DMGBefore = DMGBefore * 1.04
                end
            end
            local TotalDMG = Kindred:GetDamage(DMGBefore, true, target)
            local TargetCurrentHP = (target.Health - TotalDMG - Kraken) / target.MaxHealth
            if TargetCurrentHP <= 0 then
                TargetCurrentHP = 0
            end
            --print(TotalDMG)
            --print(TargetCurrentHP, 0.15 + myHero.CritChance/2)
            if TargetCurrentHP <= 0.15 + (myHero.CritChance/2) then
                if ((os.clock() - Orbwalker.AttackTimer) > Orbwalker.LastWindup * 2.75 and (os.clock() - Orbwalker.AttackTimer) < Orbwalker.LastWindup * 3) then
                    --print("EFORDMG")
                    return Engine:ReleaseSpell("HK_SPELL3", target.Position, 1)
                end
            end
            if target.BuffData:HasBuffOfType(BuffType.Slow) == false and target.BuffData:HasBuffOfType(BuffType.Asleep) == false and target.BuffData:HasBuffOfType(BuffType.Charm) == false and target.BuffData:HasBuffOfType(BuffType.Knockup) == false and target.BuffData:HasBuffOfType(BuffType.Stun) == false and target.BuffData:HasBuffOfType(BuffType.Taunt) == false then
                if self:GetDistance(myHero.Position, target.Position) > Orbwalker.OrbRange - 35 then
                    if ((os.clock() - Orbwalker.AttackTimer) > Orbwalker.LastWindup * 2.75 and (os.clock() - Orbwalker.AttackTimer) < Orbwalker.LastWindup * 3) then
                        --print("EOUTOFRANGE")
                        return Engine:ReleaseSpell("HK_SPELL3", target.Position, 1)
                    end
                end
            end
        end
    end

    if self.UseWCombo.Value == 1 and Engine:SpellReady('HK_SPELL2') and Engine:SpellReady("HK_SPELL1") == false and Orbwalker.Attack == 0 then
        local WBuff = myHero.BuffData:GetBuff("kindredwclonebuffvisible")
        local target = Orbwalker:GetTarget("Combo", 800+300)
        if target and WBuff.Valid == false then
            if (myHero.Health / myHero.MaxHealth) > (target.Health / target.MaxHealth) then
                return Engine:ReleaseSpell("HK_SPELL2", target.Position, 0)
            else
                if self:GetDistance(myHero.Position, target.Position) < 500 then
                    return Engine:ReleaseSpell("HK_SPELL2", myHero.Position, 0)
                else
                    return Engine:ReleaseSpell("HK_SPELL2", nil, 0)
                end
            end
        end
    end

	if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange + 300)
        if Target then
            local HeroList = ObjectManager.HeroList
            for i, Hero in pairs(HeroList) do
                if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                    if self:GetDistance(Hero.Position, self:QCastPos()) < 350 then
                        if Hero.AttackRange < 300 then
                            return nil
                        end
                    end
                end
            end
            if self:EnemyVSAlly(self:QCastPos(), Orbwalker.OrbRange) > 1 then
                return nil
            end
            if self:GetDistance(Target.Position, self:QCastPos()) > Orbwalker.OrbRange then
                if ((myHero.Health / myHero.MaxHealth) * 2) > (Target.Health / Target.MaxHealth) then
                    return nil
                end
                if Target.Health <= Target.MaxHealth / 100 * 15 then
                    return nil
                end
            end
            if self:GetDistance(Target.Position, myHero.Position) > (Orbwalker.OrbRange) then
                if self:EnemiesInRange(self:QCastPos(), 1000) >= self.GapcloseQ.Value then
                    return nil
                end
                if Engine:IsNotWall(self:QCastPos()) == false then
                    return nil
                end
                if self:GetDistance(Target.Position, self:QCastPos()) <= Orbwalker.OrbRange then
                    Engine:CastSpell("HK_SPELL1", nil ,1)
                    return nil
                end
            end
            --print("OKAY")
            if ((os.clock() - Orbwalker.AttackTimer) > Orbwalker.LastWindup * 2.75 and (os.clock() - Orbwalker.AttackTimer) < Orbwalker.LastWindup * 3) then
                return Engine:CastSpell("HK_SPELL1", nil ,0)	
            end
		end
    end
end

function Kindred:SortToNearest(Table)
    local Cache = {}
    for _, Object in pairs(Table) do
        Cache[#Cache + 1] = { 
			Comp = Object,
			Object = Object
		}
    end
    if #Cache > 1 then
        table.sort(Cache, function (left, right)
            return self:GetDistance(myHero.Position, left.Comp) < self:GetDistance(myHero.Position, right.Comp)
        end)
    end

	local SortedTable = {}

	for _, SortObject in pairs(Cache) do
        SortedTable[#SortedTable + 1] = SortObject.Object
    end

    return SortedTable
end

function Kindred:Harass()
    --Orbwalker.Enabled = 0
    if self.UseQHarass.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local RedbuffLocationbot = Vector3.new(7416.0, 51.169342041016, 3846.0)
        local BluebuffLocationbot = Vector3.new(13394.0, 52.306301116943, 7564.0)
        local BluebuffLocationtop = Vector3.new(1512.0, 52.838272094727, 7302.0)
        local RedbuffLocationtop = Vector3.new(7126.0, 54.808044433594, 11466.0)
        if self:GetDistance(myHero.Position, RedbuffLocationbot) <= 3500 then
            for x, q in pairs(self.QSpotsBotRed) do
                for i, q2 in pairs(self.QSpotsBotRed) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 30 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 45 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 420 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
            for x, q in pairs(self.QSpotsBotRedMedium) do
                for i, q2 in pairs(self.QSpotsBotRedMedium) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 25 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 35 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 500 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
            for x, q in pairs(self.QSpotsBotRedHard) do
                for i, q2 in pairs(self.QSpotsBotRedHard) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 35 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 30 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 500 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
        end
        if self:GetDistance(myHero.Position, RedbuffLocationtop) <= 3500 then
            for x, q in pairs(self.QSpotsTopRed) do
                for i, q2 in pairs(self.QSpotsTopRed) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 30 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 45 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 450 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
            for x, q in pairs(self.QSpotsTopRedMedium) do
                for i, q2 in pairs(self.QSpotsTopRedMedium) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 25 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 35 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 450 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
            for x, q in pairs(self.QSpotsTopRedHard) do
                for i, q2 in pairs(self.QSpotsTopRedHard) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 35 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 30 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 450 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
        end
        if self:GetDistance(myHero.Position, BluebuffLocationbot) <= 3500 then
            for x, q in pairs(self.QSpotsBotBlue) do
                for i, q2 in pairs(self.QSpotsBotBlue) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 30 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 45 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 420 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
        end
        if self:GetDistance(myHero.Position, BluebuffLocationtop) <= 3300 then
            for x, q in pairs(self.QSpotsTopBlue) do
                for i, q2 in pairs(self.QSpotsTopBlue) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 30 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 40 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 420 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
            for x, q in pairs(self.QSpotsTopBlueMedium) do
                for i, q2 in pairs(self.QSpotsTopBlueMedium) do
                    if self:GetDistance(myHero.Position, q) <= 200 and self:GetDistance(myHero.Position, q) >= 25 then
                        Orbwalker.Enabled = 0
                        Orbwalker:IssueMove(q)
                    end
                    if self:GetDistance(myHero.Position, q2) < 600 then
                        if self:GetDistance(myHero.Position, q) <= 35 then
                            if self:GetDistance(q, q2) > 50 and self:GetDistance(q, q2) < 500 then
                                Engine:CastSpell("HK_SPELL1", q2 ,1)
                                --Orbwalker.Enabled = 1
                                return
                            end
                        end
                    end
                end
            end
        end
    end

    if self.UseWHarass.Value == 1 and Engine:SpellReady('HK_SPELL2') and not Engine:SpellReady('HK_SPELL1')  then
        local WBuff = myHero.BuffData:GetBuff("kindredwclonebuffvisible")
        local WHarassCondition = myHero.MaxMana / 100 * self.HarassWMana.Value
        if myHero.Mana >= WHarassCondition and WBuff.Valid == false then
            local Heros     = ObjectManager.HeroList
            for i, Hero in pairs(Heros) do
                if Hero.Team ~= myHero.Team and Hero.IsDead == false and not Hero.IsVisible then
                    if self:GetDistance(Hero.Position, myHero.Position) < 500 then
                        Engine:CastSpell("HK_SPELL2", Hero.Position)
                        return
                    end
                end
            end
        end
    end

    if self.UseEHarass.Value == 1 and Engine:SpellReady('HK_SPELL3') then
        local EHarassCondition = myHero.MaxMana / 100 * self.HarassEMana.Value
        if myHero.Mana >= EHarassCondition then
            local target = Orbwalker:GetTarget("Harass", 750)
            if target then
                if self:GetDistance(myHero.Position, target.Position) <= Orbwalker.OrbRange then
                    Engine:CastSpell("HK_SPELL3", target.Position ,1)
                    return
                end
            end
        end
    end
end

function Kindred:EnemiesInRange2(Position, Range)
    local Enemies = {} 
    local HeroList = ObjectManager.HeroList
    for _,Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Kindred:GetRTarget()
    local Heros     = ObjectManager.HeroList
    local Turrets   = ObjectManager.TurretList
    local Missiles  = ObjectManager.MissileList
    for _, Hero in pairs(Heros) do
        if myHero.Team == Hero.Team and Orbwalker:GetDistance(Hero.Position, myHero.Position) < 500 then
            local Enemies = self:EnemiesInRange2(Hero.Position, 1200)
            if #Enemies > 0 then
                for _, Enemy in pairs(Enemies) do
                    local IsDashing         = Enemy.AIData.Dashing
                    local DashPosition      = Enemy.AIData.TargetPos
                    if Orbwalker:GetDistance(Hero.Position, DashPosition) <= 300 and IsDashing == true then --Ally gets dashed
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local ArmorMod  = 100 / (100 + Hero.Armor)
                        local APDamage  = Enemy.AbilityPower
                        local MRMod     = 100 / (100 + Hero.MagicResist)
                        if (Hero.Health < (ADDamage * ArmorMod) * 3) or (Hero.Health < (APDamage * MRMod) * 3) then
                            return Hero
                        end
                    end

                    if Orbwalker:GetDistance(Hero.Position, Enemy.Position) <= 300 and string.len(Enemy.ActiveSpell.Info.Name) > 0 then --Ally in Melee Range
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local ArmorMod  = 100 / (100 + Hero.Armor)
                        local APDamage  = Enemy.AbilityPower
                        local MRMod     = 100 / (100 + Hero.MagicResist)
                        if (Hero.Health < (ADDamage * ArmorMod) * 3) or (Hero.Health < (APDamage * MRMod) * 3) then
                            return Hero
                        end
                    end
                end
            end
        end
    end
    for _, Missile in pairs(Missiles) do
        local Source = Heros[Missile.SourceIndex] or Turrets[Missile.SourceIndex]
        local Target = Heros[Missile.TargetIndex]
        if Source and Target and Source.Team ~= myHero.Team and Target.Team == myHero.Team then
            local ADDamage  = Source.BaseAttack + Source.BonusAttack
            local ArmorMod  = 100 / (100 + Target.Armor)
            local APDamage  = Source.AbilityPower
            local MRMod     = 100 / (100 + Target.MagicResist)
            if (Target.Health < (ADDamage * ArmorMod) * 3) or (Target.Health < (APDamage * MRMod) * 3) then
                return Target
            end
        end
        if Source and Source.Team ~= myHero.Team then
            for _, Hero in pairs(Heros) do
                if myHero.Team == Hero.Team and Orbwalker:GetDistance(Hero.Position, myHero.Position) < 500 then
                    local StartPos  = Missile.MissileStartPos
                    local EndPos    = Missile.MissileEndPos
                    if Prediction:PointOnLineSegment(StartPos, EndPos, Hero.Position, Missile.MissileInfo.Data.MissileWidth + Hero.CharData.BoundingRadius) then
                        local HealthPercent = Hero.Health / Hero.MaxHealth
                        if HealthPercent < 0.2 and Orbwalker:GetDistance(Hero.Position, Missile.Position) < 300 then
                            return Hero
                        end
                    end
                end
            end
        end
    end
    return nil
end


function Kindred:SavemyHeroR()
    if self.UseRCombo.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local target = Orbwalker:GetTarget("Combo", 1200)
        if target then
            local DontREnemyHP = target.MaxHealth / 100 * self.WHPSliderEnemyCombo.Value
            local XAllies = self:AlliesInRange(myHero.Position, 700) - self:EnemiesInRange(myHero.Position, 700)
            if self.MoreAllies.Value == 1 and XAllies >= self.MoreAlliesSlider.Value then return end
            if self.DontREnemy.Value == 1 and target.Health < DontREnemyHP then return end
            if self.useRtoSave.Value == 1 then
                if self:EnemiesInRange(myHero.Position, 700) >= 1 then
                    if self:GetRTarget() ~= nil then
                        if self:GetRTarget() == myHero then
                            Engine:CastSpell("HK_SPELL4", nil ,1)
                            return
                        end
                    end
                end
            end
        end
    end
end

function Kindred:SaveAllyR()
    if self.useRonAlly.Value == 1 and self.UseRCombo.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local target = Orbwalker:GetTarget("Combo", 1200)
        if target then
            local DontREnemyHP = target.MaxHealth / 100 * self.WHPSliderEnemyCombo.Value
            local XAllies = self:AlliesInRange(myHero.Position, 700) - self:EnemiesInRange(myHero.Position, 700)
            if self.MoreAllies.Value == 1 and XAllies >= self.MoreAlliesSlider.Value then return end
            if self.DontREnemy.Value == 1 and self:GetDistance(myHero.Position, target.Position) <= 600 and target.Health < DontREnemyHP then return end
            local HeroList = ObjectManager.HeroList
            for k, Ally in pairs(HeroList) do
                if Ally.Team == myHero.Team and not Ally.IsDead and Ally.IsTargetable then
                    if self:EnemiesInRange(Ally.Position, 700) >= 1 and self:GetDistance(myHero.Position, Ally.Position) <= 500 then
                        if self:GetRTarget() ~= nil then
                            if self:GetRTarget() == Ally then
                                Engine:CastSpell("HK_SPELL4", nil ,1)
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

function Kindred:ForceR()
    if self.useRonAlly.Value == 1 and self.TargetOption.Selected == 0 and self.UseRCombo.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local target = Orbwalker:GetTarget("Combo", 1200)
        if target then
            local HeroList = ObjectManager.HeroList
            for k, Ally in pairs(HeroList) do
                if Ally.Team == myHero.Team and not Ally.IsDead and Ally.IsTargetable then
                    local TickOnAlly = self.SelectedAlly[Ally.Index].Value
                    if self:EnemiesInRange(Ally.Position, 700) >= 1 and self:GetDistance(myHero.Position, Ally.Position) <= 500 then
                        if TickOnAlly == 1 then
                            if self:GetRTarget() ~= nil then
                                if self:GetRTarget() == Ally then
                                    Engine:CastSpell("HK_SPELL4", nil ,1)
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Kindred:Laneclear()
    local WBuff = myHero.BuffData:GetBuff("kindredwclonebuffvisible")

    if Engine:SpellReady('HK_SPELL1') and self.LaneClearUseQ.Value == 1 and ((os.clock() - Orbwalker.AttackTimer) > Orbwalker.LastWindup * 2.75 and (os.clock() - Orbwalker.AttackTimer) < Orbwalker.LastWindup * 3) then
        local target = Orbwalker:GetTarget("Laneclear", Orbwalker.OrbRange + 240)
        local LQSliderValue = self.LaneClearQMana.Value
        if target then
            if WBuff.Count_Alt == 0 then
                local QLaneCondition = myHero.MaxMana / 100 * LQSliderValue
                if myHero.Mana >= QLaneCondition then
                    if self:GetDistance(myHero.Position, target.Position) <= Orbwalker.OrbRange + 240 then
                        Engine:CastSpell("HK_SPELL1", nil ,1)
                        return
                    end
                end
            else
                local QLaneCondition = myHero.MaxMana / 100 * LQSliderValue
                if myHero.Mana >= QLaneCondition then
                    if self:GetDistance(myHero.Position, target.Position) <= Orbwalker.OrbRange + 240 then
                        for i, k in pairs(self.WSpots) do
                            if self:GetDistance(k, myHero.Position) <= 850 then
                                if self:GetDistance(k, self:QCastPos()) <= 750 then
                                    Engine:CastSpell("HK_SPELL1", self:QCastPos() ,1)
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if Engine:SpellReady('HK_SPELL2') and self.LaneClearUseW.Value == 1 and Orbwalker.Attack == 0 then
        local target = Orbwalker:GetTarget("Laneclear", 800)
        local LWSliderValue = self.LaneClearWMana.Value
        if target and WBuff.Count_Alt == 0 then
            local WLaneCondition = myHero.MaxMana / 100 * LWSliderValue
            if myHero.Mana >= WLaneCondition then
                for i, k in pairs(self.WSpots) do
                    if self:GetDistance(k, myHero.Position) <= 500 then
                        if self:GetDistance(k, target.Position) <= 600 then
                            Engine:CastSpell("HK_SPELL2", k ,1)
                            return
                        end
                    end
                end
            end
        end
    end

    local CampNames = {
        "SRU_Blue1.1.1",
        "SRU_Murkwolf2.1.1",
        "SRU_Razorbeak3.1.1",
        "SRU_Red4.1.1",
        "SRU_Krug5.1.1",
        "SRU_Dragon_Air6.1.1",
        "SRU_Dragon_Fire6.2.1",
        "SRU_Dragon_Water6.3.1",
        "SRU_Dragon_Earth6.4.1",
        "SRU_Dragon_Elder6.5.1",
        "SRU_Blue7.1.1",
        "SRU_Murkwolf8.1.1",
        "SRU_Razorbeak9.1.1",
        "SRU_Red10.1.1",
        "SRU_Krug11.1.1",
        "SRU_Baron12.1.1",
        "SRU_Gromp13.1.1",
        "SRU_Gromp14.1.1",
        "Sru_Crab15.1.1",
        "Sru_Crab16.1.1",
        "SRU_RiftHerald17.1.1",
        }
    if self.LaneClearUseE.Value == 1 and Engine:SpellReady('HK_SPELL3') and Orbwalker.Attack == 0 then
        local eRange = Orbwalker.OrbRange + 30
        local target = Orbwalker:GetTarget("Laneclear", eRange)
        local LESliderValue = self.LaneClearEMana.Value
        if target then
            local ELaneCondition = myHero.MaxMana / 100 * LESliderValue
            if myHero.Mana >= ELaneCondition then
                for I, Name in pairs(CampNames) do
                    if Name == target.Name then
                        if target.Health > (myHero.BonusAttack + myHero.BaseAttack) * 4 then
                            Engine:CastSpell("HK_SPELL3", target.Position ,1)
                            return
                        end
                    end
                end
            end
        end
    end
end


function Kindred:DrawJungleCampMarks()
    --local JungleTimer =
    local MarkCount = myHero.BuffData:GetBuff("kindredmarkofthekindredstackcounter")
    --print(MarkCount.Count_Int)
    if MarkCount.Count_Int < 1 then
        Render:DrawString("( )", 1718.25, 891, 92, 255, 5, 255) --TopScuttle R
        Render:DrawString("( )", 1824, 968, 92, 255, 5, 255) --BotScuttle R
    end
    if myHero.Team == 100 then
        if MarkCount.Count_Int > 0 and MarkCount.Count_Int < 4 then
            Render:DrawString("( )", 1718.25, 891, 92, 255, 5, 255) --TopScuttle R
            Render:DrawString("( )", 1824, 968, 92, 255, 5, 255) --BotScuttle R
            Render:DrawString("( )", 1776.5, 891, 92, 255, 5, 255) --RedRaptors R
            Render:DrawString("( )", 1861, 946, 92, 255, 5, 255) --RedGromp R
        end
        if MarkCount.Count_Int > 3 and MarkCount.Count_Int < 8 then
            Render:DrawString("( )", 1834.5, 912, 92, 255, 5, 255) --RedWolf R
            Render:DrawString("( )", 1754, 844, 92, 255, 5, 255) --RedKrug R
            Render:DrawString("( )", 1835.4, 937, 92, 255, 5, 255) --RedBLUE R
            Render:DrawString("( )", 1764.3, 867, 92, 255, 5, 255) --RedRED R
        end
    else 
        if MarkCount.Count_Int > 0 and MarkCount.Count_Int < 4 then
            Render:DrawString("( )", 1718.25, 891, 92, 255, 5, 255) --TopScuttle R
            Render:DrawString("( )", 1824, 968, 92, 255, 5, 255) --BotScuttle R
            Render:DrawString("( )", 1765, 965, 92, 255, 5, 255) --BlueRaptors R
            Render:DrawString("( )", 1680, 912, 92, 255, 5, 255) --BlueGromp R
        end
        if MarkCount.Count_Int > 3 and MarkCount.Count_Int < 8 then
            Render:DrawString("( )", 1708, 945, 92, 255, 5, 255) --BlueWolf R
            Render:DrawString("( )", 1787, 1012, 92, 255, 5, 255) --BlueKrug R
            Render:DrawString("( )", 1707.4, 919, 92, 255, 5, 255) --BlueBLUE R
            Render:DrawString("( )", 1775.7, 987, 92, 255, 5, 255) --BlueRED R
        end
    end
    if MarkCount.Count_Int > 7 then
        Render:DrawString("( )", 1815, 980, 92, 255, 5, 255) --Dragons R
        Render:DrawString("( )", 1728, 875, 92, 255, 5, 255) --Baron/Herald R
    end
    Render:DrawString("JungleMark Map Positions:", 1650, 650, 255, 255, 255, 255)
    Render:DrawString("ON", 1875, 650, 92, 255, 5, 255)
end


function Kindred:CheatSheetTimer()
    if self.DrawCheatSheet.Value == 1 then

        local RTime = 35 - GameClock.Time + self.TimerStart4
        local RString = string.format("%.2f", RTime)
        if RTime <= 0 then
            self.TimerStart4 = GameClock.Time
        end
        local StartMark = 200 - GameClock.Time
        if StartMark < 0 then
            Render:DrawString(RString, 1650, 380, 92, 255, 5, 255)
        end
    end
end

function Kindred:DrawHitMark(target)
    --kindredmarkofthekindredtimer
    --kindredhittracker
    local PassiveTimerBuff = target.BuffData:GetBuff("kindredmarkofthekindredtimer").Count_Alt
    if PassiveTimerBuff > 0 then
        --local KindredHit = target.BuffData:GetBuff("kindredhittracker").Count_Alt
        local MarkString = ""

        local PassiveTime = 6 - GameClock.Time + self.TimerStart5
        if PassiveTime <= 0 then
            self.TimerStart5 = GameClock.Time
        end
        MarkString = string.format("%.2f", PassiveTime)
        
        local MarkOnTarget = "KindredMark:"

        local VecOut = Vector3.new()
        if Render:World2Screen(target.Position, VecOut) then
            Render:DrawString(MarkOnTarget, VecOut.x + 50 , VecOut.y - 50, 255, 255, 255, 255)
            Render:DrawString(MarkString, VecOut.x + 50 , VecOut.y - 35, 92, 255, 5, 255)
        end
    end
end

function Kindred:DrawJungleTimer()
    local MarkBuff = myHero.BuffData:GetBuff("kindredhitlistmonsteractivetracker")
    if self.DrawJungleMark.Value == 1 then
        if MarkBuff.Count_Alt > 0 then
            self.TimerStart2 = 0
        end
        if MarkBuff.Count_Alt > 0 then return end

        local MarkTime = 41 - GameClock.Time + self.TimerStart2
        local TimeString = string.format("%.2f", MarkTime)
        if MarkTime <= 0 then
            self.TimerStart2 = GameClock.Time
        end

        local StartMark = 200 - GameClock.Time
        if StartMark < 0 then
            Render:DrawString("Next JungleMark Online In:", 665, 50, 225, 225, 225, 225)
            Render:DrawString(TimeString, 900, 50, 92, 255, 5, 255)
        end
    end
end

function Kindred:RTimer()
    local RBuff = myHero.BuffData:GetBuff("KindredRNoDeathBuff")
    if RBuff.Count_Alt > 0 then
        
        local RTime = 4 - GameClock.Time + self.TimerStart
        local RString = string.format("%.2f", RTime)
        if RTime <= 0 then
            self.TimerStart = GameClock.Time
        end
        Render:DrawString(RString, 750, 500, 92, 255, 5, 255)
    end
end

function Kindred:MonsterHealthTest()
    local Minions = ObjectManager.MinionList
    for I, Minion in pairs(Minions) do
        if Minion.Team ~= myHero.Team and Minion.Team == 300 then
            if self:GetDistance(Minion.Position, myHero.Position) < 900 then
                if Minion.Health <= 450 and Minion.Health > 0 and Minion.MaxHealth > 500 then
                    print(Minion.ChampionName, ": SmitedABLE", GameClock.Time)
                    return Engine:CastSpell("HK_SUMMONER1", nil, 0)
                end
            end
        end
    end
end
            

function Kindred:OnTick()
    --print(myHero.BuffData:GetBuff("kindredmarkofthekindredstackcounter").Count_Float)
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        --Kindred:MonsterHealthTest()
        local HeroList = ObjectManager.HeroList
        for i,Ally in pairs(HeroList) do 
			if Ally.Team == myHero.Team and string.len(Ally.ChampionName) > 1 then
				if self.SelectedAlly[Ally.Index] == nil then
                    local Name = Ally.ChampionName
					self.SelectedAlly[Ally.Index] = self.TargetSelector:AddCheckbox(Name, 1)
				end
			end
        end

        if not Engine:SpellReady("HK_SPELL1") then
            Orbwalker.Enabled = 1
        end

        if Engine:IsKeyDown("HK_COMBO") then
                --Kindred:Qdodge()
            Kindred:Combo()
            Kindred:SavemyHeroR()
            Kindred:SaveAllyR()
            Kindred:ForceR()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if Orbwalker.Attack == 0 then
                Kindred:Harass()
                return
            end
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            return Kindred:Laneclear()
        end
    end
end

function Kindred:DrawDmg()
    local HeroList = ObjectManager.HeroList
    for _,Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			local Damages = {}
			table.insert( Damages, {
				Damage = DamageLib.Kindred:AADmg(myHero, Hero, self:HasInfinityEdge()) * 3,
				Color = Colors.Pink,
			})

			if Engine:SpellReady(SpellKey.Q) then
				table.insert( Damages, {
					Damage = DamageLib.Kindred:GetQDmg(Hero),
					Color = Colors.Blue,
				})
			end

			if ItemLib.Galeforce:InInventory() and Engine:SpellReady(ItemLib.Galeforce:ItemKey()) then
				table.insert(Damages, {
					Damage = DamageLib.Galeforce:GetDmg(Hero),
					Color = Colors.Turqoise,
				})
			end

			if Engine:SpellReady(SpellKey.W) then
				table.insert(Damages, {
					Damage = DamageLib.Kindred:GetWDmg(Hero) * 4,
					Color = Colors.PurpleDarker,
				})
            end
            
            if Engine:SpellReady(SpellKey.E) then
				table.insert(Damages, {
					Damage = DamageLib.Kindred:GetEDmg(myHero, Hero, self:HasInfinityEdge()),
					Color = Colors.PinkDark,
				})
			end

            DamageLib:DrawDamageIndicator(Damages, Hero)
        end
    end
end

   
function Kindred:OnDraw()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team then
            if self.DrawEnemyHitMark.Value == 1 then
                if Hero.IsTargetable then
                    self:DrawHitMark(Hero)
                end
            end
        end
    end
    

    --Render:DrawCircle(myHero.ActiveSpell.CastPos, 50 ,100,150,255,255)
 
    if self.DrawJungleMark.Value == 1 then
        self:DrawJungleTimer()
    end
    if self.DrawRTime.Value == 1 then
        self:RTimer()
    end
    if self.DrawJungleCamp.Value == 1 then
        self:DrawJungleCampMarks()
    else
        Render:DrawString("JungleMark Map Positions:", 1650, 650, 255, 255, 255, 255)
        Render:DrawString("OFF", 1875, 650, 255, 0, 0, 255)
    end
    if self.DrawCheatSheet.Value == 1 then
        Render:DrawString("0: Scutt", 1650, 400, 255, 255, 255, 255)
        Render:DrawString("1-3: Scutt, Raptor, Gromp", 1650, 415, 255, 255, 255, 255)
        Render:DrawString("4-7: Krug, Blue , Wolf, Red", 1650, 430, 255, 255, 255, 255)
        Render:DrawString("8: Baron, Dragons", 1650, 445, 255, 255, 255, 255)
        self:CheatSheetTimer()
    end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RangeQ ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RangeW ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RangeR ,100,150,255,255)
    end
    local outVec = Vector3.new()
    for i, k in pairs(self.WSpots) do
        if Render:World2Screen(k, outVec) then
            Render:DrawCircle(k, 80,100,150,100,255)
        end
    end
    for x, q in pairs(self.QSpotsBotRed) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 255, 51, 153, 255)
        end
    end
    for x, q in pairs(self.QSpotsBotRedMedium) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 252, 252, 0, 255)
        end
    end
    for x, q in pairs(self.QSpotsBotRedHard) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 252, 0, 0, 255)
        end
    end
    for x, q in pairs(self.QSpotsBotBlue) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 255, 51, 153, 255)
        end
    end
    for x, q in pairs(self.QSpotsTopBlue) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 255, 51, 153, 255)
        end
    end
    for x, q in pairs(self.QSpotsTopBlueMedium) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 252, 252, 0, 255)
        end
    end
    for x, q in pairs(self.QSpotsTopRed) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 255, 51, 153, 255)
        end
    end
    for x, q in pairs(self.QSpotsTopRedMedium) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 252, 252, 0, 255)
        end
    end
    for x, q in pairs(self.QSpotsTopRedHard) do
        if Render:World2Screen(q, outVec) then
            Render:DrawCircle(q, 50, 252, 0, 0, 255)
        end
    end
    local Pos = myHero.Position
    local Vec = Vector3.new(Pos.x, Pos.y, Pos.z)
    --local Target = Orbwalker:GetTarget("Combo", 1000)
    --if Target then
        --Target.BuffData:ShowAllBuffs()
    --end
    --myHero.BuffData:ShowAllBuffs()
    --print("Pos.x: ", Pos.x)
    --print("Pos.y: ", Pos.y)
    --print("Pos.z: ", Pos.z)
    --print(myHero.CritMod)
    --print("Vector3.new(",Pos.x,", ", Pos.y,", ", Pos.z,"),")
    --[[local BluebuffLocation = Vector3.new(7416.0, 51.169342041016, 3846.0)
    Render:DrawCircle(BluebuffLocation, 3500,255,150,255,255)
    local BluebuffLocationbot = Vector3.new(13394.0, 52.306301116943, 7564.0)
    Render:DrawCircle(BluebuffLocationbot, 3500,255,150,255,255)
    local BluebuffLocationtop = Vector3.new(1512.0, 52.838272094727, 7302.0)
    Render:DrawCircle(BluebuffLocationtop, 3300,255,150,255,255)
    local RedbuffLocationtop = Vector3.new(7126.0, 54.808044433594, 11466.0)
    Render:DrawCircle(RedbuffLocationtop, 3500,255,150,255,255)]]
    --self:DrawDmg()
end

function Kindred:OnLoad()
    if(myHero.ChampionName ~= "Kindred") then return end
    AddEvent("OnSettingsSave" , function() Kindred:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Kindred:LoadSettings() end)
    

    Kindred:__init()
    AddEvent("OnDraw", function() Kindred:OnDraw() end)
    AddEvent("OnTick", function() Kindred:OnTick() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Kindred:OnLoad() end)