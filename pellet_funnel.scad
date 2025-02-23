include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

canOD = 66;
canZ = 23;
canCZ = 20;
canWallThickness = 3;

baseTopDia = 32;

canInteriorZ = canZ+canCZ-canWallThickness;
canInteriorCZ = canCZ-canWallThickness;

funnelZ = 15;

baseFunnelJoinerZ = 6;

module itemModule()
{
	// Base:
	difference()
	{
		union()
		{
			simpleChamferedCylinder(d=canOD+2*canWallThickness, h=canZ+canCZ, cz=canCZ);
			translate([0,0,canInteriorZ]) cylinder(d1=baseTopDia, d2=baseTopDia+2*funnelZ, h=funnelZ);
			translate([0,0,canInteriorZ+canWallThickness/2-baseFunnelJoinerZ/2]) cylinder(d=baseTopDia+8, h=baseFunnelJoinerZ);
			tcy([0,0,canInteriorZ+funnelZ], d=baseTopDia+2*funnelZ, h=canWallThickness);
		}

		tcy([0,0,canInteriorZ+funnelZ+canWallThickness-1], d=200, h=20);

		translate([0,0,-1]) simpleChamferedCylinder(d=canOD, h=canInteriorZ+1, cz=canInteriorCZ);

		cylinder(d=baseTopDia, h=100);

		translate([0,0,canInteriorZ]) 
		{
			
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
