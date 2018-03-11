local Terror = {}
local optionAutoSunder = Menu.AddOption({"Hero Specific", "Terror"}, "Auto Sunder", "Auto cast sunder on enemies 
if the health is less than 25%")

function Terror.OnUpdate()
   if Menu.IsEnabled(optionAutoSunder) then
        Terror.AutoSunder()
    end
end
function Terror.AutoSunder()
    local myHero = Heroes.GetLocal()
    if not myHero then return end
    if NPC.GetUnitName(myHero) ~= "npc_dota_hero_terrorblade" then return end
    local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
			
    if not hero then return end
    if NPC.IsLinkensProtected(hero) or NPC.IsIllusion(hero) or NPC.HasModifier(hero, "modifier_item_lotus_orb") then return end
	local sunder = NPC.GetAbility(myHero, "terrorblade_sunder")
    local myHealth = Entity.GetHealth(myHero)
    local enemyHealth = Entity.GetHealth(hero)
    if myHealth <= Entity.GetMaxHealth(myHero) * 0.25 then
        if enemyHealth > Entity.GetMaxHealth(hero) * 0.75 then
            if Ability.IsReady(sunder) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(sunder)) then
                Ability.CastTarget(sunder, hero)
            end
        end
    end
end	

return Terror
