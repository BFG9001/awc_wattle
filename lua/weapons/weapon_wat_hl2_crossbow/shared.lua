
AddCSLuaFile( "shared.lua" )

---------
SWEP.PrintName 					= "Crossbow"
SWEP.Category 					= "Wattle HL2"
SWEP.Base 						= "weapon_wattlebase_bullet"
SWEP.Spawnable 					= true
SWEP.AdminOnly 					= false
SWEP.m_WeaponDeploySpeed 		= 1

SWEP.Author 					= "Awcmon and BFG"
SWEP.Contact 					= ""
SWEP.Purpose 					= ""
SWEP.Instructions 				= ""

SWEP.ViewModel					= "models/weapons/c_crossbow.mdl"
SWEP.WorldModel					= "models/weapons/w_crossbow.mdl"
SWEP.ViewModelFlip 				= false
SWEP.ViewModelFOV 				= 57

SWEP.Weight 					= 5
SWEP.AutoSwitchFrom 			= false
SWEP.AutoSwitchTo 				= false

SWEP.BobScale 					= 0
SWEP.SwayScale 					= 0
SWEP.BounceWeaponIcon 			= true
SWEP.DrawWeaponInfoBox 			= true
SWEP.DrawAmmo 					= true
SWEP.DrawCrosshair 				= false
//SWEP.RenderGroup 				= 
SWEP.Slot 						= 1
SWEP.SlotPos 					= 1
//SWEP.WepSelection 				= 
SWEP.CSMuzzleFlashes 			= true
SWEP.CSMuzzleX 					= false

SWEP.Primary.ClipSize			= 1
SWEP.Primary.DefaultClip 		= 13
SWEP.Primary.Ammo 				= "XBowBolt"
SWEP.Primary.Automatic 			= false

SWEP.Secondary.ClipSize 		= -1
SWEP.Secondary.DefaultClip 		= -1
SWEP.Secondary.Ammo 			= "none"
SWEP.Secondary.Automatic 		= false

SWEP.UseHands 					= true
SWEP.AccurateCrosshair 			= false
---------
SWEP.HoldType = "crossbow"

SWEP.Primary.Damage 			= 420
SWEP.Primary.DamageFalloff		= 0.0005
SWEP.Primary.Sound				= Sound("Weapon_Crossbow.Single")
SWEP.Primary.NumShots			= 1
SWEP.Primary.Delay				= 60/130
SWEP.Primary.Cone				= 0.0015
SWEP.Primary.ClumpCone			= 0
SWEP.Primary.Tracer				= 0
SWEP.Primary.TracerName			= "Tracer"
SWEP.Primary.MuzzleEffects		= { "effect_wat_muzzle_flash", "effect_wat_muzzle_smoke", "effect_wat_muzzle_sparks" }

SWEP.RecoilPitchAdd 			= 15
SWEP.RecoilPitchMul 			= 0.5
SWEP.RecoilPitchMulAddMax		= 10
SWEP.RecoilYawAdd 				= 10
SWEP.RecoilYawMul 				= 0.05

SWEP.SpreadConeAdd 				= 0.1
SWEP.SpreadRecoveryTime 		= 0.6
SWEP.SpreadConeAddCrouch 		= 0.0015
SWEP.SpreadRecoveryTimeCrouch 	= 0.2

SWEP.SpreadModVel 				= 0
SWEP.SpreadModVelMax 			= 0
SWEP.SpreadModInAir				= 0.005
SWEP.SpreadModCrouch 			= 0.0002

SWEP.ReloadClipInTime			= 1

SWEP.VMPosOffset 				= Vector(0,0,-3)
SWEP.VMAngOffset				= Angle(0,0,0)
SWEP.SprintPos	 				= { Vector(3.522, -4.518, -0.754), Vector(3.522, -2.518, -0.754), Vector(3.522, -4.518, -0.754) }
SWEP.SprintAng					= { Angle(-9.03, 18.458, -1.721), Angle(-11.03, 20.458, -1.721), Angle(-9.03, 22.458, -1.721) }
SWEP.WalkPos 					= { Vector(-0.15,0,0), Vector(0,0,0.5), Vector(0.15,0,0) }
SWEP.WalkAng					= { Angle(-0.5,0.5,-1), Angle(0,0,0), Angle(-0.5,-0.5,1.5) }
SWEP.InspectPos 				= { Vector(16.149, -20, -4.721), Vector(-5.054, -13.341, -14.683) }
SWEP.InspectAng 				= { Angle(70, 14.902, 48.02), Angle(30.319, 44.328, -34.658) }
SWEP.IronSightsPos 				= Vector(-8.921, -2.708, 2.599)
SWEP.IronSightsAng 				= Angle(0.057, -0.029, 0)
SWEP.SwayPosDiv					= 30
SWEP.SwayAngDiv					= 15

SWEP.UseIrons					= true
SWEP.UseScope					= true
SWEP.Zoom 						= 55
SWEP.SetFATOnShoot 				= false
SWEP.CVFireAnimIroned			= false

SWEP.DTFloats 					= {}
SWEP.DTBools 					= {}
SWEP.DTInts 					= {}

SWEP.ViewModelBoneMods = {}
SWEP.VElements = {}
SWEP.WElements = {}

function SWEP:PrimaryAttack()
	if(!IsValid(self)) then return end
	if ( !self:CanPrimaryAttack() && self.Owner:IsPlayer() ) then return end
	if ( self:GetReloading() ) then return end
	if ( self:IsSprinting() ) then return end
	
	if(self.Owner:IsPlayer()) then
		self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	end
	
	if ( self.Owner:IsNPC() ) then return end
	
	self:OnPrimaryAttack()
	
	local recTime
	local coneAdd
	
	recTime = self.SpreadRecoveryTime
	coneAdd = self.SpreadConeAdd
	
	self:SetCone( math.Clamp( self:GetCone() * math.exp( -(CurTime() - self:GetLST()) / ( math.log10(math.exp(1)) * recTime ) ), self.Primary.Cone, 1000 ) )

	//I'm so sorry
	//self:WatShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetCone() + self:SpreadMovementAdditive() )
	ply = self.Owner
	if(!self.Owner:IsNPC()) then
		math.randomseed(CurTime())
	end
	local dir = Vector(0,0,0)
	local cone = self:GetCone() + self:SpreadMovementAdditive() 
	if(ply:IsPlayer()) then
		dir = (self.Owner:GetAimVector():Angle() + self.Owner:GetViewPunchAngles()):Forward() + Vector(math.Rand(-cone, cone), math.Rand(-cone, cone), math.Rand(-cone, cone))
	else
		dir = ply:GetAimVector()
	end

	if SERVER then
		local bolt = ents.Create("crossbow_bolt")
		bolt:SetPos(self:GetOwner():GetShootPos())
		bolt:SetAngles(dir:Angle())
		bolt:SetOwner(self:GetOwner())
		bolt.WaTBowDamage = self.Primary.Damage
		//bolt.m_iDamage = self.Primary.Damage
		//bolt:SetKeyValue("m_iDamage", "200")
		bolt:Spawn()

		bolt:SetVelocity(bolt:GetAngles():Forward() * 3000)
	end

	self:SetCone(self:GetCone() + coneAdd)
	
	self:TakePrimaryAmmo( 1 )

	self:Recoil()
	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) -- View model animation
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation
	self.Weapon:EmitSound( self.Primary.Sound )
	
	if(self.SetFATOnShoot) then
		//self:SetFAT(CurTime() + self.Owner:GetViewModel():SequenceDuration())
		//self.FAT = CurTime() + self.Owner:GetViewModel():SequenceDuration()\
		self:SetFAT(CurTime() + self.Primary.Delay)
		self.FAT = CurTime() + self.Primary.Delay
	end
	
	self:SetLST( CurTime() )
end

SWEP.ReloadSound = Sound("weapons/crossbow/bolt_load2.wav")
function SWEP:OnReload()
	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		timer.Simple(.8, function()
			if IsValid(self) and (self:GetOwner():GetActiveWeapon() == self) then
				self:EmitSound( self.ReloadSound )
			end
		end)
	end
end

hook.Add("EntityTakeDamage", "WaTBoltFix", function(target, dmginfo)
	local inflictor = dmginfo:GetInflictor()
	if inflictor:GetClass() == "crossbow_bolt" and inflictor.WaTBowDamage then
		inflictor:EmitSound("weapons/crossbow/bolt_skewer1.wav")
		dmginfo:SetDamage(inflictor.WaTBowDamage)
	end
end)
