include <../OpenSCAD_Lib/MakeInclude.scad>

puttyBlock = [50, 170, 30];

puttyblockVolume = puttyBlock.x * puttyBlock.y * puttyBlock.z;
echo(str("puttyblockVolume = ", puttyblockVolume));


module roundHolder()
{
    Z = 10;
    extraZ = 1;
	internalRadius = sqrt(puttyblockVolume/(3.1415927*Z));

    ID = 2*internalRadius;
    echo(str("Round-Holder ID = ", ID));

    wallThickness = 3;
    bottomThickness = 3;

    difference()
    {
        cylinder(d=ID+2*wallThickness, h=Z+bottomThickness+extraZ);
        tcy([0,0,bottomThickness], d=ID, h=100);
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
