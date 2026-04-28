-- BronzePawn created by MeuchelManni
-- 
-- © 2006-2010 MeuchelManni.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.
--
-- Wowhead scales
------------------------------------------------------------

local ScaleProviderName = "Wowhead"

function BronzePawnWowheadScaleProvider_AddScales()


------------------------------------------------------------
-- Warrior
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"WarriorArms",
	BronzePawnWowheadScale_WarriorArms,
	"c79c6e",
	{
		["Strength"] = 100, ["HitRating"] = 90, ["ExpertiseRating"] = 85, ["CritRating"] = 80, ["Agility"] = 65, ["ArmorPenetration"] = 65, ["HasteRating"] = 50, ["Ap"] = 45, ["Armor"] = 1, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"WarriorFury",
	BronzePawnWowheadScale_WarriorFury,
	"c79c6e",
	{
		["ExpertiseRating"] = 100, ["Strength"] = 82, ["CritRating"] = 66, ["Agility"] = 53, ["ArmorPenetration"] = 52, ["HitRating"] = 48, ["HasteRating"] = 36, ["Ap"] = 31, ["Armor"] = 5, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"WarriorTank",
	BronzePawnWowheadScale_WarriorTank,
	"c79c6e",
	{
		["Stamina"] = 100, ["DodgeRating"] = 90, ["DefenseRating"] = 86, ["BlockValue"] = 81, ["Agility"] = 67, ["ParryRating"] = 67, ["BlockRating"] = 48, ["Strength"] = 48, ["ExpertiseRating"] = 19, ["HitRating"] = 10, ["ArmorPenetration"] = 10, ["CritRating"] = 7, ["Armor"] = 6, ["HasteRating"] = 1, ["Ap"] = 1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Paladin
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"PaladinHoly",
	BronzePawnWowheadScale_PaladinHoly,
	"f58cba",
	{
		["Intellect"] = 100, ["Mp5"] = 88, ["SpellPower"] = 58, ["CritRating"] = 46, ["HasteRating"] = 35, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"PaladinTank",
	BronzePawnWowheadScale_PaladinTank,
	"f58cba",
	{
		["Stamina"] = 100, ["Agility"] = 60, ["ExpertiseRating"] = 59, ["DodgeRating"] = 55, ["DefenseRating"] = 45, ["ParryRating"] = 30, ["Strength"] = 16, ["Armor"] = 8, ["BlockRating"] = 7, ["BlockValue"] = 6, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"PaladinRetribution",
	BronzePawnWowheadScale_PaladinRetribution,
	"f58cba",
	{
		["MeleeDps"] = 470, ["HitRating"] = 100, ["Strength"] = 80, ["ExpertiseRating"] = 66, ["CritRating"] = 40, ["Ap"] = 34, ["Agility"] = 32, ["HasteRating"] = 30, ["ArmorPenetration"] = 22, ["SpellPower"] = 9, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Hunter
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"HunterBeastMastery",
	BronzePawnWowheadScale_HunterBeastMastery,
	"abd473",
	{
		["RangedDps"] = 213, ["HitRating"] = 100, ["Agility"] = 58, ["CritRating"] = 40, ["Intellect"] = 37, ["Ap"] = 30, ["ArmorPenetration"] = 28, ["HasteRating"] = 21, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"HunterMarksman",
	BronzePawnWowheadScale_HunterMarksman,
	"abd473",
	{
		["RangedDps"] = 379, ["HitRating"] = 100, ["Agility"] = 74, ["CritRating"] = 57, ["ArmorPenetration"] = 40, ["Intellect"] = 39, ["Ap"] = 32, ["HasteRating"] = 24, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"HunterSurvival",
	BronzePawnWowheadScale_HunterSurvival,
	"abd473",
	{
		["RangedDps"] = 181, ["HitRating"] = 100, ["Agility"] = 76, ["CritRating"] = 42, ["Intellect"] = 35, ["HasteRating"] = 31, ["Ap"] = 29, ["ArmorPenetration"] = 26, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Rogue
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"RogueAssassination",
	BronzePawnWowheadScale_RogueAssassination,
	"fff569",
	{
		["MeleeDps"] = 170, ["Agility"] = 100, ["ExpertiseRating"] = 87, ["HitRating"] = 83, ["CritRating"] = 81, ["Ap"] = 65, ["ArmorPenetration"] = 65, ["HasteRating"] = 64, ["Strength"] = 55, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"RogueCombat",
	BronzePawnWowheadScale_RogueCombat,
	"fff569",
	{
		["MeleeDps"] = 220, ["ArmorPenetration"] = 100, ["Agility"] = 100, ["ExpertiseRating"] = 82, ["HitRating"] = 80, ["CritRating"] = 75, ["HasteRating"] = 73, ["Strength"] = 55, ["Ap"] = 50, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"RogueSubtlety",
	BronzePawnWowheadScale_RogueSubtlety,
	"fff569",
	{
		["MeleeDps"] = 228, ["ExpertiseRating"] = 100, ["Agility"] = 100, ["HitRating"] = 80, ["ArmorPenetration"] = 75, ["CritRating"] = 75, ["HasteRating"] = 75, ["Strength"] = 55, ["Ap"] = 50, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Priest
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"PriestDiscipline",
	BronzePawnWowheadScale_PriestDiscipline,
	"ffffff",
	{
		["SpellPower"] = 100, ["Mp5"] = 67, ["Intellect"] = 65, ["HasteRating"] = 59, ["CritRating"] = 48, ["Spirit"] = 22, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"PriestHoly",
	BronzePawnWowheadScale_PriestHoly,
	"ffffff",
	{
		["Mp5"] = 100, ["Intellect"] = 69, ["SpellPower"] = 60, ["Spirit"] = 52, ["CritRating"] = 38, ["HasteRating"] = 31, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"PriestShadow",
	BronzePawnWowheadScale_PriestShadow,
	"ffffff",
	{
		["HitRating"] = 100, ["ShadowSpellDamage"] = 76, ["SpellPower"] = 76, ["CritRating"] = 54, ["HasteRating"] = 50, ["Spirit"] = 16, ["Intellect"] = 16, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- DK
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightBloodDps",
	BronzePawnWowheadScale_DeathKnightBloodDps,
	"ff4d6b",
	{
		["MeleeDps"] = 360, ["ArmorPenetration"] = 100, ["Strength"] = 99, ["HitRating"] = 91, ["ExpertiseRating"] = 90, ["CritRating"] = 57, ["HasteRating"] = 55, ["Ap"] = 36, ["Armor"] = 1, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightBloodTank",
	BronzePawnWowheadScale_DeathKnightBloodTank,
	"ff4d6b",
	{
		["MeleeDps"] = 500, ["Stamina"] = 100, ["DefenseRating"] = 90, ["Agility"] = 69, ["DodgeRating"] = 50, ["ParryRating"] = 43, ["ExpertiseRating"] = 38, ["Strength"] = 31, ["ArmorPenetration"] = 26, ["CritRating"] = 22, ["Armor"] = 18, ["HitRating"] = 16, ["HasteRating"] = 16, ["BonusArmor"] = 11, ["Ap"] = 8, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightFrostDps",
	BronzePawnWowheadScale_DeathKnightFrostDps,
	"ff4d6b",
	{
		["MeleeDps"] = 337, ["HitRating"] = 100, ["Strength"] = 97, ["ExpertiseRating"] = 81, ["ArmorPenetration"] = 61, ["CritRating"] = 45, ["Ap"] = 35, ["HasteRating"] = 28, ["Armor"] = 1, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightFrostTank",
	BronzePawnWowheadScale_DeathKnightFrostTank,
	"ff4d6b",
	{
		["MeleeDps"] = 419, ["ParryRating"] = 100, ["HitRating"] = 97, ["Strength"] = 96, ["DefenseRating"] = 85, ["ExpertiseRating"] = 69, ["DodgeRating"] = 61, ["Agility"] = 61, ["Stamina"] = 61, ["CritRating"] = 49, ["Ap"] = 41, ["ArmorPenetration"] = 31, ["Armor"] = 5, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightUnholyDps",
	BronzePawnWowheadScale_DeathKnightUnholyDps,
	"ff4d6b",
	{
		["MeleeDps"] = 209, ["Strength"] = 100, ["HitRating"] = 66, ["ExpertiseRating"] = 51, ["HasteRating"] = 48, ["CritRating"] = 45, ["Ap"] = 34, ["ArmorPenetration"] = 32, ["Armor"] = 1, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Shaman
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"ShamanElemental",
	BronzePawnWowheadScale_ShamanElemental,
	"6e95ff",
	{
		["HitRating"] = 100, ["SpellPower"] = 60, ["HasteRating"] = 56, ["CritRating"] = 40, ["Intellect"] = 11, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"ShamanEnhancement",
	BronzePawnWowheadScale_ShamanEnhancement,
	"6e95ff",
	{
		["MeleeDps"] = 135, ["HitRating"] = 100, ["ExpertiseRating"] = 84, ["Agility"] = 55, ["Intellect"] = 55, ["CritRating"] = 55, ["HasteRating"] = 42, ["Strength"] = 35, ["Ap"] = 32, ["SpellPower"] = 29, ["ArmorPenetration"] = 26, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"ShamanRestoration",
	BronzePawnWowheadScale_ShamanRestoration,
	"6e95ff",
	{
		["Mp5"] = 100, ["Intellect"] = 85, ["SpellPower"] = 77, ["CritRating"] = 62, ["HasteRating"] = 35, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Mage
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"MageArcane",
	BronzePawnWowheadScale_MageArcane,
	"69ccf0",
	{
		["HitRating"] = 100, ["HasteRating"] = 54, ["ArcaneSpellDamage"] = 49, ["SpellPower"] = 49, ["CritRating"] = 37, ["Intellect"] = 34, ["FrostSpellDamage"] = 24, ["FireSpellDamage"] = 24, ["Spirit"] = 14, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"MageFire",
	BronzePawnWowheadScale_MageFire,
	"69ccf0",
	{
		["HitRating"] = 100, ["HasteRating"] = 53, ["FireSpellDamage"] = 46, ["SpellPower"] = 46, ["CritRating"] = 43, ["FrostSpellDamage"] = 23, ["ArcaneSpellDamage"] = 23, ["Intellect"] = 13, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"MageFrost",
	BronzePawnWowheadScale_MageFrost,
	"69ccf0",
	{
		["HitRating"] = 100, ["HasteRating"] = 42, ["FrostSpellDamage"] = 39, ["SpellPower"] = 39, ["ArcaneSpellDamage"] = 19, ["FireSpellDamage"] = 19, ["CritRating"] = 19, ["Intellect"] = 6, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Warlock
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"WarlockAffliction",
	BronzePawnWowheadScale_WarlockAffliction,
	"bca5ff",
	{
		["HitRating"] = 100, ["ShadowSpellDamage"] = 72, ["SpellPower"] = 72, ["HasteRating"] = 61, ["CritRating"] = 38, ["FireSpellDamage"] = 36, ["Spirit"] = 34, ["Intellect"] = 15, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"WarlockDemonology",
	BronzePawnWowheadScale_WarlockDemonology,
	"bca5ff",
	{
		["HitRating"] = 100, ["HasteRating"] = 50, ["FireSpellDamage"] = 45, ["ShadowSpellDamage"] = 45, ["SpellPower"] = 45, ["CritRating"] = 31, ["Spirit"] = 29, ["Intellect"] = 13, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"WarlockDestruction",
	BronzePawnWowheadScale_WarlockDestruction,
	"bca5ff",
	{
		["HitRating"] = 100, ["FireSpellDamage"] = 47, ["SpellPower"] = 47, ["HasteRating"] = 46, ["Spirit"] = 26, ["ShadowSpellDamage"] = 23, ["CritRating"] = 16, ["Intellect"] = 13, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------
-- Druid
------------------------------------------------------------

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DruidBalance",
	BronzePawnWowheadScale_DruidBalance,
	"ff7d0a",
	{
		["HitRating"] = 100, ["SpellPower"] = 66, ["HasteRating"] = 54, ["CritRating"] = 43, ["Spirit"] = 22, ["Intellect"] = 22, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DruidFeralDps",
	BronzePawnWowheadScale_DruidFeralDps,
	"ff7d0a",
	{
		["Agility"] = 100, ["ArmorPenetration"] = 90, ["Strength"] = 80, ["CritRating"] = 55, ["ExpertiseRating"] = 50, ["HitRating"] = 50, ["FeralAp"] = 40, ["Ap"] = 40, ["HasteRating"] = 35, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DruidFeralTank",
	BronzePawnWowheadScale_DruidFeralTank,
	"ff7d0a",
	{
		["Agility"] = 100, ["Stamina"] = 75, ["DodgeRating"] = 65, ["DefenseRating"] = 60, ["ExpertiseRating"] = 16, ["Strength"] = 10, ["Armor"] = 10, ["HitRating"] = 8, ["HasteRating"] = 5, ["Ap"] = 4, ["FeralAp"] = 4, ["CritRating"] = 3, ["MetaSocketEffect"] = 3600
	},
	1
)

BronzePawnAddPluginScale(
	ScaleProviderName,
	"DruidRestoration",
	BronzePawnWowheadScale_DruidRestoration,
	"ff7d0a",
	{
		["SpellPower"] = 100, ["Mp5"] = 73, ["HasteRating"] = 57, ["Intellect"] = 51, ["Spirit"] = 32, ["CritRating"] = 11, ["Stamina"] = .1, ["MetaSocketEffect"] = 3600
	},
	1
)

------------------------------------------------------------

-- BronzePawnWowheadScaleProviderOptions.LastAdded keeps track of the last time that we tried to automatically enable scales for this character.
if not BronzePawnWowheadScaleProviderOptions then BronzePawnWowheadScaleProviderOptions = { } end
if not BronzePawnWowheadScaleProviderOptions.LastAdded then BronzePawnWowheadScaleProviderOptions.LastAdded = 0 end

local _, Class = UnitClass("player")
if BronzePawnWowheadScaleProviderOptions.LastAdded < 1 then
	-- Enable round one of scales based on the player's class.
	if Class == "WARRIOR" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "WarriorFury"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "WarriorTank"), true)
	elseif Class == "PALADIN" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "PaladinHoly"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "PaladinTank"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "PaladinRetribution"), true)
	elseif Class == "HUNTER" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "HunterBeastMastery"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "HunterMarksman"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "HunterSurvival"), true)
	elseif Class == "ROGUE" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "RogueAssassination"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "RogueCombat"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "RogueSubtlety"), true)
	elseif Class == "PRIEST" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "PriestDiscipline"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "PriestHoly"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "PriestShadow"), true)
	elseif Class == "DEATHKNIGHT" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DeathKnightBloodDps"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DeathKnightBloodTank"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DeathKnightFrostDps"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DeathKnightFrostTank"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DeathKnightUnholyDps"), true)
	elseif Class == "SHAMAN" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "ShamanElemental"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "ShamanEnhancement"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "ShamanRestoration"), true)
	elseif Class == "MAGE" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "MageArcane"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "MageFire"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "MageFrost"), true)
	elseif Class == "WARLOCK" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "WarlockAffliction"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "WarlockDemonology"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "WarlockDestruction"), true)
	elseif Class == "DRUID" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DruidBalance"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DruidFeralDps"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DruidFeralTank"), true)
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "DruidRestoration"), true)
	end
end

if BronzePawnWowheadScaleProviderOptions.LastAdded < 2 then
	if Class == "WARRIOR" then
		BronzePawnSetScaleVisible(BronzePawnGetProviderScaleName(ScaleProviderName, "WarriorArms"), true)
	end
end

-- Don't reenable those scales again after the user has disabled them previously.
BronzePawnWowheadScaleProviderOptions.LastAdded = 2

-- After this function terminates there's no need for it anymore, so cause it to self-destruct to save memory.
BronzePawnWowheadScaleProvider_AddScales = nil

end -- BronzePawnWowheadScaleProvider_AddScales

------------------------------------------------------------

BronzePawnAddPluginScaleProvider(ScaleProviderName, BronzePawnWowheadScale_Provider, BronzePawnWowheadScaleProvider_AddScales)
