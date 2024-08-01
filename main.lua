MantleMod = RegisterMod("Mantle Mod", 1)
local mod = MantleMod

function mod:onPickup(pickup)

end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.onPickup)