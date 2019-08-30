// 
// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 
// International License.
//
// https://creativecommons.org/licenses/by-sa/4.0/
//
// Raspberry Pi 4 B Reference:
// https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_4b_4p0.pdf
//

include <../../../lib/common.scad>

pi4();

module pi4(dim = [56,85,4], bar = 7, lift = 3.5, tap = 2.5, screws = true) {
    $fn = 16;

    difference() {
        rzcube(dim,3);
        translate([bar,bar,-1]) rzcube([dim.x-2*bar,dim.y-2*bar,dim.z*2],3);  
    }

    translate([3.5,3.5,0]) post(h=dim.z+lift, od=6, id=tap);
    translate([dim.x-3.5,3.5,0]) post(h=dim.z+lift, od=6, id=tap);
    translate([3.5,3.5+58,0]) post(h=dim.z+lift, od=6, id=tap);
    translate([dim.x-3.5,3.5+58,0]) post(h=dim.z+lift, od=6, id=tap);

    translate([dim.x/2,dim.y-3.5,0]) cylinder(h=dim.z+lift, d=6);

    if (!screws) {
        translate([3.5,3.5,0]) cylinder(h=dim.z+lift+2, d=2.5);
        translate([dim.x-3.5,3.5,0]) cylinder(h=dim.z+lift+2, d=2.5);
        translate([3.5,3.5+58,0]) cylinder(h=dim.z+lift+2, d=2.5);
        translate([dim.x-3.5,3.5+58,0]) cylinder(h=dim.z+lift+2, d=2.5);
    }
}