
-- huo jian qiang
local assets =
{
    Asset("ANIM", "anim/nz_lance.zip"),
    Asset("ATLAS", "images/inventoryimages/nz_lance.xml")
}


local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "nz_lance", "swap_object")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()
    -- print("creating huo jian qiang !!!")
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddMiniMapEntity()
    -- inst.MiniMapEntity:SetIcon("nz_lance.tex")
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("nz_lance")
    inst.AnimState:SetBuild("nz_lance")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")

    inst:AddTag("irreplaceable")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(5*TUNING.HAMMER_DAMAGE)

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.CHOP)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	-- inst.components.inventoryitem.imagename = "nz_lance"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/nz_lance.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)


    return inst
end

return Prefab("nz_lance", fn, assets)
		