local MakePlayerCharacter = require "prefabs/player_common"

-- according to the assets, we should successfully load the character to our game
-- at least I think so
local assets = 
{
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

    Asset( "ANIM", "anim/nezha.zip" ),
	
	Asset( "IMAGE", "images/hud/nezhatab.tex" ),
    Asset( "ATLAS", "images/hud/nezhatab.xml" ),
	
	Asset("IMAGE", "images/inventoryimages/silker.tex"),
	Asset("ATLAS", "images/inventoryimages/silker.xml"),
}

local prefabs = {}

--what the character have at the beginning
local start_inv = {
	"spidereggsack",
	"spidereggsack",

}





--------------------------------------------------------------
------init--------------------------------------------------
local function init_small_statue(inst)
	-- set values 
	local stomach_val=200
	local stomach_decline_val=1
	local brain_val=150
	local brain_decline_val=1
	local heart_val=200
	local heart_decline_val=1
	local move_speed= 8
	local defence_val=1

	--attack values
	local attack_values=1

	--features


	-----set character value and features

	inst.components.health:SetMaxHealth(heart_val)
	inst.components.hunger:SetMax(stomach_val)
	inst.components.sanity:SetMax(brain_val)
	inst.components.locomotor.walkspeed = move_speed
	inst.components.locomotor.runspeed = move_speed

end

local function init_big_statue(inst)
	local stomach_val=200
	local stomach_decline_val=1
	local brain_val=150
	local brain_decline_val=1
	local heart_val=200
	local heart_decline_val=1
	local move_speed= 20

	local defence_val=1

	--attack values
	local attack_values=2


	-----set character value and features
	---values 
	inst.components.health:SetMaxHealth(heart_val)
	inst.components.hunger:SetMax(stomach_val)
	inst.components.sanity:SetMax(brain_val)
	inst.components.locomotor.walkspeed = move_speed
	inst.components.locomotor.runspeed = move_speed
end

---------------------------------------------------
-----------features-----------------------------------
--feature cheater
local function set_cheat_feature(inst)
	
	
end

--feature avoid fire
local function set_not_hurt_by_fire(inst)

end

--feature tough
local function set_tough_body(inst)

end

--feature of the big one   fool
local function set_fool_brain(inst)

end

--feature of the big one : attacking
local function set_attack_feature()

end

-----------------------------------------------
-- events-----------------------------------
local function on_full_moon_night(inst)
	init_big_statue(inst)
end


local function on_heart_val_change(inst,data)
	------judge heart is low or high
	-- print("here")
	local heart_val_of_character=inst.components.health:GetPercent()
	if heart_val_of_character < 0.05  then
		inst.components.health:StartRegen(TUNING.NEZHA_HP_Regen,1)
	elseif heart_val_of_character > 0.2 then
		inst.components.health:StopRegen()
	end
end

local function on_brain_val_low(inst)

end

local function on_brain_val_enough(inst)

end

local function on_brain_val_change(inst)
	local brain_val_of_character=1
	if brain_val_of_character <10 then
		on_brain_val_low(inst)
	elseif brain_val_of_character >50 then
		on_brain_val_enough(inst)
	end
end

--main function of the character
local function character_init(inst)
	-- character common feature
	init_big_statue(inst)
	-- inst.components.health:StartRegen(TUNING.NEZHA_HP_Regen,1)
	inst.MiniMapEntity:SetIcon( "nezha.tex" )

	--set cheat feature
	set_cheat_feature(inst)

	set_not_hurt_by_fire(inst)

	-- events
	-- I dont know which one is the full moon night event 
	------ inst:ListenForEvent( "nighttime", function() on_full_moon_night(inst) end , GetWorld())
	
	inst:ListenForEvent("healthdelta", on_heart_val_change)
	
	-- inst:ListenForEvent( "healthdelta", function() on_heart_val_change(inst) end , GetWorld())
	

	
	--get brain value on it change
	------ inst:ListenForEvent( "nighttime", function() on_full_moon_night(inst) end , GetWorld())
	------judge brain is low or high
	

end

return MakePlayerCharacter("nezha", prefabs, assets, character_init, start_inv)


--------these are spidey functions as refer-----------------
-- local function updatestats(inst)
-- 	if GetClock():IsDay() then
-- 	 inst.Light:Enable(true)
--         inst.Light:SetRadius(50)
--         inst.Light:SetFalloff(10)
--         inst.Light:SetIntensity(0.6)
--         inst.Light:SetColour(180/255,195/255,150/255)
-- 		inst.Lighton = true
-- 	elseif GetClock():IsDusk() then
-- 	 inst.Light:Enable(true)
--         inst.Light:SetRadius(50)
--         inst.Light:SetFalloff(10)
--         inst.Light:SetIntensity(0.6)
--         inst.Light:SetColour(180/255,195/255,150/255)
-- 		inst.Lighton = true
-- 	elseif GetClock():IsNight() then
-- 	 inst.Light:Enable(true)
--         inst.Light:SetRadius(50)
--         inst.Light:SetFalloff(10)
--         inst.Light:SetIntensity(0.6)
--         inst.Light:SetColour(180/255,195/255,150/255)
-- 		inst.Lighton = true
-- 	end
-- end

-- local function master_postinit(inst)

-- 	--****************************************************
-- 	-- STRINGS.TABS.NEZHA = "Nezha"
-- 	local nezhatab = {str = "NEZHA", sort=999, icon = "nezhatab.tex", icon_atlas = "images/hud/nezhatab.xml"}
-- 	inst.components.builder:AddRecipeTab(nezhatab)
	
-- 	local s01Recipe = Recipe("katanas", {Ingredient("goldnugget", 2),Ingredient("flint", 10),Ingredient("cutstone", 10)}, nezhatab, {SCIENCE = 0, MAGIC = 0, ANCIENT = 0})
-- 	s01Recipe.atlas = "images/inventoryimages/katanas.xml"
	
-- 	local s02Recipe = Recipe("silk", {Ingredient("butterflywings", 1)}, nezhatab, {SCIENCE = 0, MAGIC = 0, ANCIENT = 0}, nil, nil, nil, 10 )
-- 	s02Recipe.atlas = "images/inventoryimages/silker.xml"
	
-- 	--****************************************************
	
	
	
-- 	inst.soundsname = "nezha"
	
-- 	inst:AddTag("spiderwhisperer")
-- 	inst.components.locomotor.triggerscreep = false
	
-- 	inst.MiniMapEntity:SetIcon( "nezha.tex" )
	
-- 	-- Stats	
-- 	inst.components.health:SetMaxHealth(200)
-- 	inst.components.hunger:SetMax(200)
-- 	inst.components.sanity:SetMax(150)
	
-- 	-- Movement speed (optional)
-- 	inst.components.locomotor.walkspeed = 5
-- 	inst.components.locomotor.runspeed = 8
	
-- 	-- Health regen
-- 	inst.components.health:StartRegen(TUNING.SPIDEY_HP_Regen,1)
	
-- 	-- Damagea'd
--     inst.components.combat:SetAttackPeriod(0.1)
	
-- 	-- Hunger rate (optional)
-- 	inst.components.hunger.hungerrate = TUNING.WILSON_HUNGER_RATE
	
-- 	--Quick pickin'!
-- 		local handle = inst.sg.sg.actionhandlers[ACTIONS.HARVEST]
-- 	handle.deststate = function(inst) return "doshortaction" end
-- 		local handle = inst.sg.sg.actionhandlers[ACTIONS.PICK]
-- 	handle.deststate = function(inst) return "doshortaction" end
	
-- 	--nightvision
-- 	local light = inst.entity:AddLight()
	
--     inst:ListenForEvent( "daytime", function() updatestats(inst) end , GetWorld())
--   	inst:ListenForEvent( "dusktime", function() updatestats(inst) end , GetWorld())
--   	inst:ListenForEvent( "nighttime", function() updatestats(inst) end , GetWorld())
-- 	updatestats(inst)
	
-- end