include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

canOD = 66;
canZ = 23;
canCZ = 20;
canWallThickness = 3;

baseTopDia = 32;

canInteriorZ = canZ+canCZ-canWallThickness;
canInteriorCZ = canCZ-canWallThickness;

module itemModule()
{
	// Base:
	difference()
	{
		simpleChamferedCylinder(d=canOD+2*canWallThickness, h=canZ+canCZ, cz=canCZ);
		translate([0,0,-1]) simpleChamferedCylinder(d=canOD, h=canInteriorZ+1, cz=canInteriorCZ);
		cylinder(d=baseTopDia, h=100);
	}

	// Funnel:
	translate([0,0,canInteriorZ])
	{
		funnelZ = 15;
		difference() 
		{
			cylinder(d1=baseTopDia, d2=baseTopDia+2*funnelZ, h=funnelZ);
			translate([0,0,canWallThickness]) cylinder(d1=baseTopDia, d2=baseTopDia+2*funnelZ, h=funnelZ);
			tcy([0,0,-1], d=baseTopDia, h=100);
		}
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
