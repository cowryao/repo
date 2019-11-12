-- qiankunquan 
local assets=
{
    Asset("ANIM", "anim/nz_ring.zip"),
    Asset("ATLAS", "images/inventoryimages/nz_ring.xml")
}


local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "nz_ring", "swap_item")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")

    local current_sanity_percent = owner.components.sanity:GetPercent()
	owner.components.sanity:SetMax(180)
	owner.components.sanity:SetPercent(current_sanity_percent)
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 

    local current_sanity_percent = owner.components.sanity:GetPercent()
	owner.components.sanity:SetMax(150)
	owner.components.sanity:SetPercent(current_sanity_percent)
end

local function OnDropped(inst)
    inst.AnimState:PlayAnimation("idle")
end

local function OnThrown(inst, owner, target)
    if target ~= owner then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_throw")
    end
    inst.AnimState:PlayAnimation("flying", true)
end

local function OnCaught(inst, catcher)
    if catcher then
        if catcher.components.inventory then
            if inst.components.equippable and not catcher.components.inventory:GetEquippedItem(inst.components.equippable.equipslot) then
                catcher.components.inventory:Equip(inst)
            else
                catcher.components.inventory:GiveItem(inst)
            end
            catcher:PushEvent("catch")
        end
    end
end

local function ReturnToOwner(inst, owner)
    if owner then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_return")
        inst.components.projectile:Throw(owner, owner)
    end
end

local function OnHit(inst, owner, target)
    if owner == target then
        OnDropped(inst)
    else
        ReturnToOwner(inst, owner)
    end
    local impactfx = SpawnPrefab("impact")
    if impactfx then
        local follower = impactfx.entity:AddFollower()
        follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
        impactfx:FacePoint(inst.Transform:GetWorldPosition())
    end

end


local function fn(Sim)
    print("creatring ring!!!!")
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    
    inst.AnimState:SetBank("boomerang")
    inst.AnimState:SetBuild("nz_ring")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("thrown")

    inst:AddTag("irreplaceable")
    -- inst:AddTag("sharp")
    -- inst:AddTag("pointy")
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetRange(TUNING.BOOMERANG_DISTANCE, TUNING.BOOMERANG_DISTANCE+2)
    -------
    inst:AddTag("sharp")

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE)

    inst:AddComponent("inspectable")

    inst:AddTag("projectile")
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(10)
    inst.components.projectile:SetCanCatch(true)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(ReturnToOwner)
    inst.components.projectile:SetOnCaughtFn(OnCaught)

    local hit_everyone = inst.components.projectile.Hit
	function inst.components.projectile:Hit(target)
		if target == self.owner and target.components.catcher then
			target:PushEvent("catch", {projectile = self.inst}) 
			self.inst:PushEvent("caught", {catcher = target})
			self:Catch(target)
			target.components.catcher:StopWatching(self.inst)
		else
			hit_everyone(self, target)
		end
	end
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/nz_ring.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)


    return inst
end

return Prefab("nz_ring", fn, assets)
