include <../OpenSCAD_Lib/MakeInclude.scad>

puttyBlock = [50, 170, 30];

puttyblockVolume = puttyBlock.x * puttyBlock.y * puttyBlock.z;
echo(str("puttyblockVolume = ", puttyblockVolume));


module roundHolder()
{
    Z = 10;
    extraZ = 0;
	internalRadius = sqrt(puttyblockVolume/(3.1415927*Z));

    ID = 2*internalRadius;
    echo(str("Round-Holder ID = ", ID));

    wallThickness = 4;
    bottomThickness = 3;
    totalZ = Z + bottomThickness + extraZ;
    OD = ID+2*wallThickness;

    difference()
    {
        union()
        {
            cylinder(d=OD, h=totalZ);
            hangersHoleXform(OD=OD) hull()
            {
                cylinder(d=13, h=totalZ);
                tcy([0,-15,0], d=30, h=totalZ);
            }
        }
        tcy([0,0,bottomThickness], d=ID, h=100);

         hangersHoleXform(OD=OD) 
         {
            ropeHoleDia = 5.5;
            tcy([0,0,-1], d=ropeHoleDia, h=100);
            translate([0,0,totalZ/2]) doubleZ() translate([0,0,totalZ/2-ropeHoleDia/2-3]) cylinder(d1=0, d2=20, h=10);
         }
    }
}

module hangersHoleXform(OD)
{
    hangersXform(OD=OD, dY=6) children();
}

module hangersXform(OD, dY)
{
    y = OD/2+dY;
    echo(str("hangersXform() y = ", y));
    doubleX() rotate([0,0,30])
    {
        translate([0,y,0])
        {
            children();
        }
    }
}

module clip(d=0)
{
	//tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() roundHolder();
}
else
{
	roundHolder();
}
