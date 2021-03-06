
AddCSLuaFile( "shared.lua" )

---------
SWEP.PrintName 					= "SG552"
SWEP.Category 					= "Wattle CS:S"
SWEP.Base 						= "weapon_wattlebase_bullet"
SWEP.Spawnable 					= true
SWEP.AdminOnly 					= false
SWEP.m_WeaponDeploySpeed 		= 1

SWEP.Author 					= "Awcmon"
SWEP.Contact 					= ""
SWEP.Purpose 					= ""
SWEP.Instructions 				= ""

SWEP.ViewModel					= "models/weapons/cstrike/c_rif_sg552.mdl"
SWEP.WorldModel					= "models/weapons/w_rif_sg552.mdl"
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
SWEP.Slot 						= 2
SWEP.SlotPos 					= 1
//SWEP.WepSelection 				= 
SWEP.CSMuzzleFlashes 			= true
SWEP.CSMuzzleX 					= false

SWEP.Primary.ClipSize			= 30
SWEP.Primary.DefaultClip 		= 120
SWEP.Primary.Ammo 				= "smg1"
SWEP.Primary.Automatic 			= true

SWEP.Secondary.ClipSize 		= -1
SWEP.Secondary.DefaultClip 		= -1
SWEP.Secondary.Ammo 			= "none"
SWEP.Secondary.Automatic 		= false

SWEP.UseHands 					= true
SWEP.AccurateCrosshair 			= false
---------
SWEP.HoldType 					= "ar2"

SWEP.Primary.Damage 			= 35
SWEP.Primary.DamageFalloff		= 0.00025
SWEP.Primary.Sound				= Sound("Weapon_SG552.Single")
SWEP.Primary.NumShots			= 1
SWEP.Primary.Delay				= 60/666
SWEP.Primary.Cone				= 0.0005
SWEP.Primary.ClumpCone			= 0
SWEP.Primary.Tracer				= 0
SWEP.Primary.TracerName			= "effect_wat_tracer_smoke"
SWEP.Primary.MuzzleEffects		= { "effect_wat_muzzle_flash", "effect_wat_muzzle_smoke", "effect_wat_muzzle_sparks" }

SWEP.RecoilPitchAdd 			= 1.5
SWEP.RecoilPitchMul 			= 0.12
SWEP.RecoilPitchMulAddMax		= 10
SWEP.RecoilYawAdd 				= 0.5
SWEP.RecoilYawMul 				= 0.05

SWEP.SpreadConeAdd 				= 0.0045
SWEP.SpreadRecoveryTime 		= 0.6
SWEP.SpreadConeAddCrouch 		= 0.0015
SWEP.SpreadRecoveryTimeCrouch 	= 0.2

SWEP.SpreadModVel 				= 0.085
SWEP.SpreadModVelMax 			= 0.0002
SWEP.SpreadModInAir				= 0.075
SWEP.SpreadModCrouch 			= 0.0002

SWEP.ReloadClipInTime			= 1.5

SWEP.VMPosOffset 				= Vector(0,0,0)
SWEP.VMAngOffset				= Angle(0,0,0)
SWEP.SprintPos	 				= { Vector(0.5,-2.5-4,-4), Vector(0.5,-2.5-4,-4), Vector(0.5,-2.5-4,-4) }
SWEP.SprintAng					= { Angle(-12,32,-35), Angle(-6,35,-35), Angle(-12,38,-35) }
SWEP.WalkPos 					= { Vector(-0.5,0,-1)*0.5, Vector(0,-1,1)*0.5, Vector(0.5,0,-1)*0.5 }
SWEP.WalkAng					= { Angle(-0.5,1,-2)*0.5, Angle(0.5,0,2)*0.5, Angle(-0.5,-1,3)*0.5 }
SWEP.InspectPos 				= { Vector(8.883, -4, 0), Vector(-10.7, -1.153, 3.655) }
SWEP.InspectAng 				= { Angle(5.678, 38.159, 17.649), Angle(-7.246, -8.81, -23.761) }
SWEP.IronSightsPos 				= Vector(-7.841, -12.705, 2.559)
SWEP.IronSightsAng 				= Angle(0, 0, 0)
SWEP.SwayPosDiv					= 30
SWEP.SwayAngDiv					= 13

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

function SWEP:DrawScopeReticule(x, y)
	local wr = ScrW()/1280
	local hr = ScrH()/960
	
	local reddot = surface.GetTextureID( "sprites/redglow1" )
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetTexture( reddot	)
	local size = 30*wr
	surface.DrawTexturedRect( x-(size*0.5), y-(size*0.5), size, size )
end
