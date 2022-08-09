if ( SERVER ) then
	SWEP.Weight          		= 0
	SWEP.AutoSwitchTo			= false
	SWEP.AutoSwitchFrom			= false
end

if ( CLIENT ) then
	SWEP.PrintName			= "Hände"
	SWEP.Slot				= 0
    SWEP.SlotPos         	= 0
    SWEP.DrawAmmo			= false
	SWEP.ViewModelFOV       = 10
	SWEP.DrawCrosshair		= false
	SWEP.WepSelectIcon    	= surface.GetTextureID( "weapons/weapon_hands" )

	function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

  		-- Set us up the texture
  		surface.SetDrawColor( 255, 255, 255, alpha )
  		surface.SetTexture( self.WepSelectIcon )

  		-- Lets get a sin wave to make it bounce
  		local fsin = 0

  			if ( self.BounceWeaponIcon == true ) then
    			fsin = math.sin( CurTime() * 10 ) * 5
  			end

  		-- Borders
 		 y = y + 10
  		x = x + 10
  		wide = wide - 20

  		-- Draw that mother
  		surface.DrawTexturedRect( x + (fsin), y - (fsin),  wide-fsin*2 , ( wide / 2 ) + (fsin) )

  		-- Draw weapon info box
  		self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
	end
end

SWEP.Author			= "OAWC"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.HoldType				= "normal"
SWEP.Category			    = "Other"

SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true


SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true


SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "None"

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = true
SWEP.Secondary.Ammo         = "None"
SWEP.DrawAmmo = false

SWEP.FistHitDistance = 48
SWEP.SwepMode = "Hands"


local phys_pushscale = GetConVar( "phys_pushscale" )
local SwingSound = Sound( "WeaponFrag.Throw" )
local HitSound = Sound( "Flesh.ImpactHard" )


function SWEP:Initialize()
	self:SetHoldType( "normal" )

	self.DRGTime = 0
	self.DRGRange = 150
end

function SWEP:SetupDataTables()
	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )
end

function SWEP:UpdateNextIdle()
	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )
end

function SWEP:Think()
	if self.SwepMode == "Hands" then
		self:SetHoldType( "normal" )
		if self.Drag and (not self.Owner:KeyDown(IN_ATTACK) or not IsValid(self.Drag.Entity)) then
			self.Drag = nil
		end
	elseif self.SwepMode == "Fist" then
		self:SetHoldType("fist")
		local vm = self.Owner:GetViewModel()
		local curtime = CurTime()
		local idletime = self:GetNextIdle()
		if ( idletime > 0 && CurTime() > idletime ) then
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
			self:UpdateNextIdle()
		end
		local meleetime = self:GetNextMeleeAttack()
		if ( meleetime > 0 && CurTime() > meleetime ) then
			self:DealDamage()
			self:SetNextMeleeAttack( 0 )
		end
		if ( SERVER && CurTime() > self:GetNextPrimaryFire() + 0.1 ) then
			self:SetCombo( 0 )
		end
	end
end


function SWEP:OnDrop()
   self:Remove()
end

function SWEP:ShouldDropOnDie()
   return false
end

function SWEP:PrimaryAttack()
	if self.SwepMode == "Hands" then

		local Pos = self.Owner:GetShootPos()
		local Aim = self.Owner:GetAimVector()

		local Tr = util.TraceLine{
			start = Pos,
			endpos = Pos +Aim *self.DRGRange,
			filter = player.GetAll(),
		}

		local HitEnt = Tr.Entity
		if self.Drag then
			HitEnt = self.Drag.Entity
		else
			if not IsValid( HitEnt ) or HitEnt:GetMoveType() ~= MOVETYPE_VPHYSICS or HitEnt:IsVehicle() or HitEnt:GetNWBool( "NoDrag", false ) or OAWC.Config.DragBlackList[HitEnt:GetClass()] or IsValid( HitEnt:GetParent() ) then
				return
			end

			if not self.Drag then
				self.Drag = {
					OffPos = HitEnt:WorldToLocal(Tr.HitPos),
					Entity = HitEnt,
					Fraction = Tr.Fraction,
				}
			end
		end

		if CLIENT or not IsValid( HitEnt ) then return end

		local Phys = HitEnt:GetPhysicsObject()

		if IsValid( Phys ) then
			local Pos2 = Pos +Aim *self.DRGRange *self.Drag.Fraction
			local OffPos = HitEnt:LocalToWorld( self.Drag.OffPos )
			local Dif = Pos2 -OffPos
			local Nom = (Dif:GetNormal() *math.min(1, Dif:Length() /100) *500 -Phys:GetVelocity()) *Phys:GetMass()

			Phys:ApplyForceOffset( Nom, OffPos )
			Phys:AddAngleVelocity( -Phys:GetAngleVelocity() /4 )
		end
	end
	if self.SwepMode == "Fist" then
		if (self.Reloadtimer || 0) > CurTime() then return end
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		local anim = "fists_left"
		if ( right ) then anim = "fists_right" end
		if ( self:GetCombo() >= 2 ) then
			anim = "fists_uppercut"
		end

		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

		self:EmitSound( SwingSound )

		self:UpdateNextIdle()
		self:SetNextMeleeAttack( CurTime() + 0.2 )

		self:SetNextPrimaryFire( CurTime() + 0.9 )
		self:SetNextSecondaryFire( CurTime() + 0.9 )
		self.Reloadtimer = CurTime() + 1

	end
end

if CLIENT then
	if SWEP.SwepMode == "Hands" then
		local x, y = ScrW() /2, ScrH() /2
		local MainCol = Color( 255, 255, 255, 255 )
		local Col = Color( 255, 255, 255, 255 )

		function SWEP:DrawHUD()
			if IsValid( self.Owner:GetVehicle() ) then return end
			local Pos = self.Owner:GetShootPos()
			local Aim = self.Owner:GetAimVector()

			local Tr = util.TraceLine{
				start = Pos,
				endpos = Pos +Aim *self.DRGRange,
				filter = player.GetAll(),
			}

			local HitEnt = Tr.Entity
			if IsValid( HitEnt ) and HitEnt:GetMoveType() == MOVETYPE_VPHYSICS and
				not self.rDag and
				not HitEnt:IsVehicle() and
				not IsValid( HitEnt:GetParent() ) and
				not HitEnt:GetNWBool( "NoDrag", false ) then

				self.DRGTime = math.min( 1, self.DRGTime +2 *FrameTime() )
			else
				self.DRGTime = math.max( 0, self.DRGTime -2 *FrameTime() )
			end

			if self.DRGTime > 0 then
				Col.a = MainCol.a *self.DRGTime
				if self.SwepMode == "Hands" then
					draw.SimpleText("Heben","DermaLarge",x,y,Col,EXT_ALIGN_CENTER)
				end
			end

			if self.Drag and IsValid( self.Drag.Entity ) then
				local Pos2 = Pos +Aim *100 *self.Drag.Fraction
				local OffPos = self.Drag.Entity:LocalToWorld( self.Drag.OffPos )
				local Dif = Pos2 -OffPos

				local A = OffPos:ToScreen()
				local B = Pos2:ToScreen()

				surface.DrawRect( A.x -2, A.y -2, 4, 4, MainCol )
				surface.DrawRect( B.x -2, B.y -2, 4, 4, MainCol )
				surface.DrawLine( A.x, A.y, B.x, B.y, MainCol )
			end
		end
	end
end

function SWEP:SecondaryAttack()
	if self.SwepMode == "Fist" then
		self:PrimaryAttack( true )
	end
end

local delay = 0
function SWEP:Reload()
	if delay < CurTime() then
		if self.SwepMode == "Hands" then
			self.SwepMode = "Fist"
			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
			vm:SetWeaponModel("models/weapons/c_arms.mdl", self)
		elseif self.SwepMode == "Fist" then
			self.SwepMode = "Hands"
			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_holster" ) )
			timer.Simple(0.3, function()
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "nil" ) )
			end)
			vm:SetWeaponModel("models/weapons/c_arms.mdl", self)
		end
		delay = CurTime() + 0.2
	end
end

function SWEP:DealDamage()
	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())
	self.Owner:LagCompensation( true )
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.FistHitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )
	if ( !IsValid( tr.Entity ) ) then
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.FistHitDistance,
			filter = self.Owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		self:EmitSound( HitSound )
	end

	local hit = false
	local scale = phys_pushscale:GetFloat()

	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()

		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )

		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( math.random( 8, 12 ) )

		if ( anim == "fists_left" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 * scale + self.Owner:GetForward() * 9998 * scale ) -- Yes we need those specific numbers
		elseif ( anim == "fists_right" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * -4912 * scale + self.Owner:GetForward() * 9989 * scale )
		elseif ( anim == "fists_uppercut" ) then
			dmginfo:SetDamageForce( self.Owner:GetUp() * 5158 * scale + self.Owner:GetForward() * 10012 * scale )
			dmginfo:SetDamage( math.random( 12, 24 ) )
		end

		SuppressHostEvents( NULL ) -- Let the breakable gibs spawn in multiplayer on client
		tr.Entity:TakeDamageInfo( dmginfo )
		SuppressHostEvents( self.Owner )

		hit = true

	end

	if ( IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos )
		end
	end

	if ( SERVER ) then
		if ( hit && anim != "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end

	self.Owner:LagCompensation( false )
end



function SWEP:Deploy()
	if self.SwepMode == "Fist" then
		local speed = GetConVarNumber( "sv_defaultdeployspeed" )

		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
		vm:SetPlaybackRate( speed )

		self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() / speed )
		self:SetNextSecondaryFire( CurTime() + vm:SequenceDuration() / speed )
		self:UpdateNextIdle()

		if ( SERVER ) then
			self:SetCombo( 0 )
		end

		return true
	end
	if SERVER and IsValid(self.Owner) then
		self.Owner:DrawViewModel(false)
	end
   return true
end

function SWEP:Holster()
	if self.SwepMode == "Fist" then
		self:SetNextMeleeAttack( 0 )
	end
   return true
end
