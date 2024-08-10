MantleMod = RegisterMod("Mantle Mod", 1)
local mod = MantleMod

-- function to print a debug message to the log file
function debugPrint(s)
    Isaac.DebugString("\n[MY DEBUG] "..s)
end

-- gives the player a holy card
function giveHolyCard()
    Isaac.GetPlayer():AddCard(Card.CARD_HOLY)
end

-- checks if the pickup subtype is equal to Mom's bed
function isMomsBed(subtype)
    -- 10 is the subtype code for Mom's bed
    return subtype == 10
end

-- checks if the pickup was a bed and the character is the lost
function mod:onPickup(pickup)
    if pickup.Type == EntityType.ENTITY_PICKUP and pickup.Variant == PickupVariant.PICKUP_BED and not isMomsBed(pickup.SubType) then
        local pType = Isaac.GetPlayer():GetPlayerType()
        if pType == PlayerType.PLAYER_THELOST or pType == PlayerType.PLAYER_THELOST_B and not pickup.Touched then
            giveHolyCard()
        end
    end
end

-- test function to spawn a bed on game start
function mod:onStart(continued)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BED, 10, Vector(320,280), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BED, 0, Vector(30,280), Vector(0,0), nil)
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onStart)
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.onPickup)