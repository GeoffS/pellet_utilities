include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

funnelToBaseDia = 40;

containerOD = 120;
containerZ = 100;
containerWallThickness = 2;

baseFloorZ = 2;
baseID = containerOD - 2*containerWallThickness;
baseCylinderZ = 20;

module itemModule()
{
	// Base:
	difference()
	{
        // Exterior:
		cylinder(d=containerOD, h=containerZ);

        // Base interior:
		translate([0,0,baseFloorZ]) 
        {
            cylinder(d=baseID, h=baseCylinderZ+nothing);
            translate([0,0,baseCylinderZ]) cylinder(d1=baseID, d2=0, h=baseID/2);
        }

        // Funnel:
        translate([0,0,containerZ-baseID/2]) cylinder(d1=0, d2=baseID, h=baseID/2);
        tcy([0,0,containerZ-nothing], d=baseID, h=10);

        // Opening between funnel and container:
		tcy([0,0,10], d=funnelToBaseDia, h=100);
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
