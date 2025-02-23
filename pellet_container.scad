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
        union()
        {
            translate([0,0,containerZ/2]) mirror([0,0,1]) simpleChamferedCylinder(d=containerOD, h=containerZ/2, cz=2);
            translate([0,0,containerZ/2]) simpleChamferedCylinder(d=containerOD, h=containerZ/2, cz=1);
        }

        // Base interior:
		translate([0,0,baseFloorZ]) 
        {
            translate([0,0,baseCylinderZ+nothing]) mirror([0,0,1]) simpleChamferedCylinder(d=baseID, h=baseCylinderZ+nothing, cz=1);
            translate([0,0,baseCylinderZ]) cylinder(d1=baseID, d2=0, h=baseID/2);
        }

        // Funnel:
        funnelOpeningDia = baseID - 1;
        translate([0,0,containerZ-funnelOpeningDia/2]) cylinder(d1=0, d2=funnelOpeningDia, h=funnelOpeningDia/2);
        tcy([0,0,containerZ-nothing], d=funnelOpeningDia, h=10);

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
