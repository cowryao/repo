-- qiankunquan 
local assets=
{
    Asset("ANIM", "anim/nz_ring.zip"),
}

    
local prefabs =
{
}

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "nz_ring", "swap_item")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")
end

local function OnHitOwner(inst)
    inst.components.floatable:SetAnimationFromPosition()
    --inst.components.rechargeable:StartRecharging()
    --inst:RemoveComponent('projectile')
    --inst:RemoveTag("projectile")
    --inst:RemoveTag('thrown')
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function OnThrown(inst, owner, target)
    if target ~= owner then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_throw")
        inst:RemoveTag('return')
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
            --inst.components.rechargeable:StartRecharging()
            --inst:RemoveComponent('projectile')
            --inst:RemoveTag('projectile')
            --inst:RemoveTag('thrown')
            inst:RemoveTag('return')
            catcher:PushEvent("catch")
        end
    end
end

local function ReturnToOwner(inst, owner)
    if owner then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_return")
        inst.components.projectile:Throw(owner, owner)
        inst:AddTag('return')
    end
end

local function OnHit(inst, owner, target)
    if owner == target then
        OnHitOwner(inst)
    else
        ReturnToOwner(inst, owner)
    end
    local impactfx = SpawnPrefab("impact")
    if impactfx then
        local follower = impactfx.entity:AddFollower()
        follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
        impactfx:FacePoint(inst.Transform:GetWorldPosition())
    end
    --强制硬直
    if target and target.sg and not target:HasTag('player') then
        if not target.components.health:IsDead() then
            target.sg:GoToState('hit')
        end
    end
end


local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst .entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst:AddTag('irreplaceable')

    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("nz_ring.tex")
    
    anim:SetBank("nz_ring")
    anim:SetBuild("nz_ring")
    anim:PlayAnimation("idle")
    anim:SetRayTestOnBB(true)
    
    if rawget(_G, 'MakeInventoryFloatable') then
        MakeInventoryFloatable(inst, 'idle_water', 'idle')
    end
    
    --inst:AddTag("projectile")
    --inst:AddTag("thrown")
    inst:AddTag('irreplaceable')
    inst:AddTag("sharp")
    inst:AddTag("pointy")
    --inst:AddTag("rechargeable")
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(233-200-30-3)
    inst.components.weapon.modes = 
    {
        RANGE = {damage = 51, ranged = true, attackrange = TUNING.BOOMERANG_DISTANCE, hitrange = TUNING.BOOMERANG_DISTANCE + 2},--远程伤害
        NORMAL ={damage = 17, ranged = false,attackrange = -0.3, hitrange = 1} ,--近战距离, 近战伤害
        RETURN = {damage = 51, ranged = true, attackrange = TUNING.BOOMERANG_DISTANCE, hitrange = TUNING.BOOMERANG_DISTANCE + 2},
    }
    inst.components.weapon.variedmodefn = function(weapon)
        if not weapon.components.projectile then
            return weapon.components.weapon.modes.NORMAL
        --[[
        elseif weapon.components.projectile.target == GetPlayer() then
            return weapon.components.weapon.modes.RETURN
        --]]
        elseif weapon:HasTag('return') then
            return weapon.components.weapon.modes.RETURN 
        else
            --print(weapon.components.projectile.target)
            return weapon.components.weapon.modes.RANGE
        end
    end
    -------

    inst:AddComponent("inspectable")
    
    inst.SetProjectile = function()
    inst:AddComponent("projectile")
    inst:AddTag('projectile')
    inst:AddTag('thrown')
    inst.components.projectile:SetSpeed(15) --飞行速度
    inst.components.projectile:SetCanCatch(true)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(ReturnToOwner)
    inst.components.projectile:SetOnCaughtFn(OnCaught)
    inst.components.projectile:SetLaunchOffset(Vector3(0, 0.2, 0))
    end

    inst:SetProjectile()

    --inst:AddComponent("rechargeable")
    --inst.components.rechargeable:SetRechargeTime(5)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/monkey_king_item.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    --[[
    inst:ListenForEvent('rechargechange',function()
        if inst.components.rechargeable:GetPercent() >= 1 then
            inst:SetProjectile()
        end
    end)
    --]]
    --懒得写保存函数了
    
    return inst
end

return Prefab("nz_ring", fn, assets,prefabs)
