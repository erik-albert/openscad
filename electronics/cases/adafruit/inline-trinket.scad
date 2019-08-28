include <../../../lib/common.scad>

//
// Inline Adafruit Trinket snap-fit case
// 
// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-sa/4.0/
//


// dimensions of an Adafruit Trinket mini or M0
trinket_width=15.25;
trinket_length=26.64;

// wall thickness
wall = 1.5;

// final case dimensions
bw = trinket_width+2*wall;
bl = trinket_length+8+2*wall;

// dimensions of the cable (non-usb) opening
sww = 5;
swh = 2;

$fn=16;
bottom_height = 4;

translate([25,0,0]) top();
bottom();

module bottom() {
    difference() {
        translate([-wall,-wall,-wall]) rcube([bw,bl,20], 2);
        translate([-1-wall,-1-wall,bottom_height]) cube([50,50,30]);
        translate([0,0,0]) rcube([bw-2*wall,bl-2*wall,20], 2);
        // opening for the servo wire
        translate([trinket_width/2-sww/2,bl-5,bottom_height-swh+0.001]) cube([sww,10,swh]);
        // opening for the usb connector
        translate([trinket_width/2-6,-wall-1,2.2]) cube([12,10,5]);
        // front corners not fitting
        cube([trinket_width,3,bottom_height+1]);
    }
    translate([1.525,6.5,0]) cylinder(4,d=2.1);
    translate([trinket_width-1.525,6.5,0]) cylinder(4,d=2.1);
    translate([0,3.5,0]) cube([trinket_width,4,3]);

    translate([0,23,0]) cube([2,6,3]);
    translate([trinket_width-2,23,0]) cube([2,6,3]);

    // clips for cover
    translate([-wall,4.01,bottom_height-0.1]) cube([wall,bl-7.8,2.1]);
    translate([trinket_width,4.01,bottom_height-0.1]) cube([wall,bl-7.8,2.1]);

    difference() {
        union() {
            translate([0,4.01,bottom_height+1.5]) rotate([-90,0,0]) cylinder(h=bl-7.8,d=1);
            translate([trinket_width,4.01,bottom_height+1.5]) rotate([-90,0,0]) cylinder(h=bl-7.8,d=1);
        }
        translate([0, 9, bottom_height]) cube([trinket_width,10,4]); 
    }
}

module top() {
    
    difference() {
        union() {
            difference() {
                translate([-wall,-wall,-wall]) rcube([bw,bl,20], 2);
                translate([-1-wall,-1-wall,bottom_height]) cube([50,50,30]);
                translate([0,0,0]) rcube([bw-2*wall,bl-2*wall,20], 2);
                // opening for the usb connector
                translate([trinket_width/2-6,-wall-1,2]) cube([12,10,5]);
            }
            
            translate([0,4.5,0]) cube([3,3,bottom_height]);
            translate([0,20.5,0]) cube([3,12,bottom_height]);
            translate([trinket_width-3,4.5,0]) cube([3,3,bottom_height]);
            translate([trinket_width-3,20.5,0]) cube([3,12,bottom_height]);
        }
        
        translate([-wall,4,bottom_height-2.1]) cube([wall,bl-8,2.1]);
        translate([trinket_width,4,bottom_height-2.1]) cube([wall,bl-8,2.1]);
        translate([0,4,bottom_height-1.5]) rotate([-90,0,0]) cylinder(h=bl-8,d=1.2);
        translate([trinket_width,4,bottom_height-1.5]) rotate([-90,0,0]) cylinder(h=bl-8,d=1.2);
    }
    
}
