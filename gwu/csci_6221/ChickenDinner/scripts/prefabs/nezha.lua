local MakePlayerCharacter = require "prefabs/player_common"


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

local start_inv = {
	"spidereggsack",
	"spidereggsack",

}


local function updatestats(inst)
	if GetClock():IsDay() then
	 inst.Light:Enable(true)
        inst.Light:SetRadius(50)
        inst.Light:SetFalloff(10)
        inst.Light:SetIntensity(0.6)
        inst.Light:SetColour(180/255,195/255,150/255)
		inst.Lighton = true
	elseif GetClock():IsDusk() then
	 inst.Light:Enable(true)
        inst.Light:SetRadius(50)
        inst.Light:SetFalloff(10)
        inst.Light:SetIntensity(0.6)
        inst.Light:SetColour(180/255,195/255,150/255)
		inst.Lighton = true
	elseif GetClock():IsNight() then
	 inst.Light:Enable(true)
        inst.Light:SetRadius(50)
        inst.Light:SetFalloff(10)
        inst.Light:SetIntensity(0.6)
        inst.Light:SetColour(180/255,195/255,150/255)
		inst.Lighton = true
	end
end


local function master_postinit(inst)

	--****************************************************
	STRINGS.TABS.NEZHA = "Nezha"
	local nezhatab = {str = "NEZHA", sort=999, icon = "nezhatab.tex", icon_atlas = "images/hud/nezhatab.xml"}
	inst.components.builder:AddRecipeTab(nezhatab)
	
	-- local s01Recipe = Recipe("katanas", {Ingredient("goldnugget", 2),Ingredient("flint", 10),Ingredient("cutstone", 10)}, nezhatab, {SCIENCE = 0, MAGIC = 0, ANCIENT = 0})
	-- s01Recipe.atlas = "images/inventoryimages/katanas.xml"
	
	-- local s02Recipe = Recipe("silk", {Ingredient("butterflywings", 1)}, nezhatab, {SCIENCE = 0, MAGIC = 0, ANCIENT = 0}, nil, nil, nil, 10 )
	-- s02Recipe.atlas = "images/inventoryimages/silker.xml"
	
	--****************************************************
	
	
	
	inst.soundsname = "nezha"
	
	inst:AddTag("spiderwhisperer")
	inst.components.locomotor.triggerscreep = false
	
	inst.MiniMapEntity:SetIcon( "nezha.tex" )
	
	-- Stats	
	inst.components.health:SetMaxHealth(200)
	inst.components.hunger:SetMax(200)
	inst.components.sanity:SetMax(150)
	
	-- Movement speed (optional)
	inst.components.locomotor.walkspeed = 5
	inst.components.locomotor.runspeed = 8
	
	-- Health regen
	inst.components.health:StartRegen(TUNING.SPIDEY_HP_Regen,1)
	
	-- Damagea'd
    inst.components.combat:SetAttackPeriod(0.1)
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = TUNING.WILSON_HUNGER_RATE
	
	--Quick pickin'!
		local handle = inst.sg.sg.actionhandlers[ACTIONS.HARVEST]
	handle.deststate = function(inst) return "doshortaction" end
		local handle = inst.sg.sg.actionhandlers[ACTIONS.PICK]
	handle.deststate = function(inst) return "doshortaction" end
	
	--nightvision
	local light = inst.entity:AddLight()
	
    inst:ListenForEvent( "daytime", function() updatestats(inst) end , GetWorld())
  	inst:ListenForEvent( "dusktime", function() updatestats(inst) end , GetWorld())
  	inst:ListenForEvent( "nighttime", function() updatestats(inst) end , GetWorld())
	updatestats(inst)
	
end

return MakePlayerCharacter("nezha", prefabs, assets, master_postinit, start_inv)
