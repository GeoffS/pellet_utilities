include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

canOD = 66;
canZ = 23;
canCZ = 20;
canWallThickness = 2;

baseTopDia = 32;

canInteriorZ = canZ+canCZ-canWallThickness;
canInteriorCZ = canCZ-canWallThickness;

funnelZ = 40;

baseFunnelJoinerZ = 6;

module itemModule()
{
	// Base:
	difference()
	{
		hull()
		{
			cylinder(d=canOD+20, h=canZ);
			topRingZ = 10;
			tcy([0,0,canInteriorZ+funnelZ+canWallThickness-topRingZ], d=baseTopDia+2*funnelZ, h=topRingZ-2);
		}

		translate([0,0,-1]) simpleChamferedCylinder(d=canOD, h=canInteriorZ+1, cz=canInteriorCZ);

		cylinder(d=baseTopDia, h=100);

		translate([0,0,canInteriorZ]) translate([0,0,canWallThickness]) cylinder(d1=baseTopDia, d2=baseTopDia+2*funnelZ, h=funnelZ);

		translate([0,0,-100+canOD/2+2]) cylinder(d1=200, d2=0, h=100);
	}
}

module clip(d=0)
{
	tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
