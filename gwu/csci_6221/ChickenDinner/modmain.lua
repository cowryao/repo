local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS
local Action = GLOBAL.Action

TUNING.NEZHA_HP_Regen = GetModConfigData("Nezha_Hp_Regen")
TUNING.NEZHA_Small_Stomach_Val = GetModConfigData("Nezha_small_stomach_val")
TUNING.NEZHA_Small_Brain_Val = GetModConfigData("Nezha_small_brain_val")
TUNING.NEZHA_Small_Heart_Val = GetModConfigData("Nezha_small_heart_val")
TUNING.NEZHA_Big_Stomach_Val = GetModConfigData("Nezha_big_stomach_val")
TUNING.NEZHA_Big_Brain_Val = GetModConfigData("Nezha_big_brain_val")
TUNING.NEZHA_Big_Heart_Val = GetModConfigData("Nezha_big_heart_val")
TUNING.NEZHA_Small_Stomach_Decline_Rate = GetModConfigData("Nezha_small_stomach_decline_rate")
TUNING.NEZHA_Small_Brain_Decline_Rate = GetModConfigData("Nezha_small_brain_decline_rate")
TUNING.NEZHA_Small_Heart_Decline_Rate = GetModConfigData("Nezha_small_heart_decline_rate")
TUNING.NEZHA_Big_Stomach_Decline_Rate = GetModConfigData("Nezha_big_stomach_decline_rate")
TUNING.NEZHA_Big_Brain_Decline_Rate = GetModConfigData("Nezha_big_brain_decline_rate")
TUNING.NEZHA_Big_Heart_Decline_Rate = GetModConfigData("Nezha_big_heart_decline_rate")
TUNING.NEZHA_Small_Move_Speed = GetModConfigData("Nezha_small_move_speed")
TUNING.NEZHA_Big_Move_Speed = GetModConfigData("Nezha_big_move_speed")
TUNING.NEZHA_Small_Defence_Val = GetModConfigData("Nezha_small_defence_val")
TUNING.NEZHA_Big_Defence_Val = GetModConfigData("Nezha_big_defence_val")
TUNING.NEZHA_Small_Attack_Val = GetModConfigData("Nezha_small_attack_val")
TUNING.NEZHA_Big_Attack_Val = GetModConfigData("Nezha_big_attack_val")




STRINGS.NAMES.NZ_LANCE = "huo jian qiang"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NZ_LANCE = "Oops."
STRINGS.NAMES.NZ_RING = "qian kun quan"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NZ_LANCE = "WUUUU."
STRINGS.NAMES.NZ_WHEEL = "feng huo lun"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NZ_WHEEL = "Hii Ha."
-- STRINGS.NAMES.KATANAS = "Spiderpool's Katanas"
-- STRINGS.CHARACTERS.GENERIC.DESCRIBE.KATANAS = "a set of sharpened swords."


PrefabFiles = {
	"nezha",
	"nz_lance",
	"nz_wheel",
	"nz_ring",

}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/nezha.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/nezha.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/nezha.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/nezha.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/nezha_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/nezha_silho.xml" ),

    Asset( "IMAGE", "bigportraits/nezha.tex" ),
    Asset( "ATLAS", "bigportraits/nezha.xml" ),

	Asset( "IMAGE", "images/map_icons/nezha.tex" ),
	Asset( "ATLAS", "images/map_icons/nezha.xml" ),

    -- Asset("SOUNDPACKAGE", "sound/nezha.fev"),
    -- Asset("SOUND", "sound/nezha.fsb"),
	----------------------------------------------------
	Asset("ATLAS", "images/inventoryimages/nezhatab.xml"),
	Asset("ATLAS", "images/inventoryimages/silker.xml"),
}

-- RemapSoundEvent( "dontstarve/characters/nezha/death_voice", "nezha/nezha/death_voice" )
-- RemapSoundEvent( "dontstarve/characters/nezha/hurt", "nezha/nezha/hurt" )
-- RemapSoundEvent( "dontstarve/characters/nezha/talk_LP", "nezha/nezha/talk_LP" )

-- The character select screen lines
GLOBAL.STRINGS.CHARACTER_TITLES.nezha = "The Nezha"
GLOBAL.STRINGS.CHARACTER_NAMES.nezha = "Nezha"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.nezha = "*Health Regen\n*Don't fear fire\n*Big and Small status"
GLOBAL.STRINGS.CHARACTER_QUOTES.nezha = "\"Oh! everyone\""

-- Custom speech strings
GLOBAL.STRINGS.CHARACTERS.NEZHA = require "speech_nezha"

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.MALE, "Nezha")

AddMinimapAtlas("images/map_icons/nezha.xml")
AddModCharacter("nezha")

AddPrefabPostInit("nz_lance")
AddPrefabPostInit('nz_wheel')
AddPrefabPostInit("nz_ring")


AddSimPostInit(nz_lance)
AddSimPostInit(nz_wheel)
AddSimPostInit(nz_ring)

-- local testing_1= GetModConfigData("test_options_01")

---------------- test of spawn a creature----------
local Test_On= GetModConfigData("Test_On")

local DEBUG_KEY = GLOBAL.assert(GLOBAL.KEY_P)
local DEBUG_KEY_SKIP_Time = GLOBAL.assert(GLOBAL.KEY_O)

local function SpawnCreature()
	local player = GLOBAL.GetPlayer()
	local x, y, z = player.Transform:GetWorldPosition()
	local creature = GLOBAL.SpawnPrefab("forest/animals/beefalo")
	creature.Transform:SetPosition( x, y, z )
end

local function SkipTime()
	GLOBAL.GetClock():NextPhase()
end

-----------Mod main method --------------------------
local function AfterLoadingTheWorld(player)
	local player_controller= player.components.playercontroller
	if player_controller then
		 player_controller.OnControl=(
			function()
				local onControl= player_controller.OnControl
				return function(self, ...)
					if not (DEBUG_KEY and GLOBAL.TheInput:IsKeyDown(DEBUG_KEY)) then
						return onControl(self, ...)
					end
				end
			end)()
	end
	-- SpawnCreature()
	if Test_On =="on" then
		GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_P, SpawnCreature)
		GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_O, SkipTime)

	end


end



--[NEW] Tell the engine to run the function "SpawnCreature" as soon as the player spawns in the world.
AddSimPostInit(AfterLoadingTheWorld)
