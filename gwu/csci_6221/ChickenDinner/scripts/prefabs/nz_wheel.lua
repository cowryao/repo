--feng huo lun
local assets =
{

	Asset("ANIM","anim/nz_wheel.zip"),
	Asset("ATLAS", "images/inventoryimages/nz_wheel.xml")

}

local function OnDropped(inst)
	-- inst.entity:SetParent(nil)
	-- inst.Physics:SetActive(true)
	-- if inst.pos_task then
	-- 	inst.pos_task:Cancel()
	-- 	inst.pos_task = nil
	-- end
end

local function ondepletedfn(inst)
	local driver = inst.components.drivable and inst.components.drivable.driver
	if driver then
		driver.components.driver:OnDismount(true)
	end
	inst:SetCold()
end

local function onhealthdelta(inst,a,b)
	local function IsCross(aa,bb,c)
		return aa < c and bb >= c 
	end
	local say
	if IsCross(a,b,.5) then
		say = 1
	elseif IsCross(a,b,.25) then
		say = 2
	elseif IsCross(a,b,.1) then
		say = 3
	end
	local driver = inst.components.drivable.driver
	if driver and say then
		if driver.prefab == 'monkey_king' then
			local lines = MK_MOD_LANGUAGE_SETTING and 
			{
				'OoO','OoO','OoO',
			} or
			{
				'俺老孙的筋斗云开始晃了',
				'这云怕是载不起俺老孙了',
				'俺老孙该落地了',
			}
			driver.components.talker:Say(lines[say])
		else
			local lines = MK_MOD_LANGUAGE_SETTING and 
			{
				'','','',
			} or
			{
				'I want to get back to the ground.',
				"I don't want to fall",
				'Get me out of here!',
			}
			driver.components.talker:Say(lines[say])
		end
	end
end

local function on_equip(inst,owner)
	owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function on_unequip(inst,owner)
	owner.AnimState:OverrideSymbol("swap_body", "armor_wood", "swap_body")
end


local function init_wheel()
	print("spawning wheel !!!!")
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddFollower()
	MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("nz_wheel")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetRayTestOnBB(true)

	inst.Transform:SetEightFaced()
	inst:AddTag("irreplaceable")
	inst:AddComponent("inspectable")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/nz_wheel.xml"
	inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
		

	inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.ARMORWOOD, TUNING.ARMORWOOD_ABSORPTION)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip( on_equip )
	inst.components.equippable:SetOnUnequip( on_unequip )

	return inst
end



return Prefab("nz_wheel", init_wheel, assets)
