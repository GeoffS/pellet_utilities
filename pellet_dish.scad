include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

$fa=1;

baseOD = 70;
baseCZ = 3;
baseZ = 10;
baseFlatDia = baseOD - 2*baseCZ;

dishDia = 200;
dishZ = 4.9;

dishBottomZ = baseZ - dishZ;

pelletWellDia = 4.9; // Nominal 4.74mm
pelletWellZ = 3;
        
module itemModule()
{
	difference()
    {
        // Exterior:
        simpleChamferedCylinder(d=baseOD, h=baseZ, cz=baseCZ);

        // Form the dish:
        tsp([0,0,dishBottomZ+dishDia/2], d=dishDia);

        // Make the pellet-well:
        tcy([0,0,dishBottomZ-pelletWellZ], d=pelletWellDia, h=100);
        translate([0,0,dishBottomZ-pelletWellDia/2-1]) difference()
        {
            cylinder(d1=0, d2=10, h=5);
            tcy([0,0,-20+1.5], d=5, h=20);
        }
    }
}

module clip(d=0)
{
	// tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
