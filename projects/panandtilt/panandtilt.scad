//
// pan and tilt esp-32 camera
// 
// pan and tilt:
// https://www.adafruit.com/product/1967
// https://www.adafruit.com/product/1968
// 
// AI-Thinker ESP32-CAM
// (e.g.,) https://www.banggood.com/Geekcreit-ESP32-CAM-WiFi-Bluetooth-Camera-Module-Development-Board-ESP32-p-1443851.html
// 
// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-sa/4.0/
//

include <../../lib/common.scad>

$fn=16;

// outer wall thickness
wall=1.8;
// dimensions of the esp32 module with some buffer
module_width = 27 + wall*4 + 1;
module_height = 40 + wall*2 + 1;
// module held in place by top overlapping seat by this amount
module_thick = 1.2;
// height the module sits off of the base (accounts for esp32 package)
module_seat = 4.5;

translate([-10, wall, 0]) rotate([0,0,90]) mount();
translate([45,0,0]) top();
bottom();

module top() {
    height = wall + 5;
    clip = 3.2;
    union() {
        difference() {
            union() {
                rcube([module_width,module_height,height+6],2);
            }
            translate([wall*2,wall*2,wall]) rcube([module_width-4*wall,module_height-4*wall,16],2);
            translate([-1,-1,height]) cube([module_width+2,module_height+2,20]);
            
            // sd card cutout
            translate([module_width/2-10,-1,wall+2]) cube([20,8,10]);
            
            // lens cutout
            translate([module_width/2,13,-1]) cylinder(10,r=4);
        }
        // side tabs
        difference() {
            union() {
                translate([0,10,height]) cube([wall-0.2,module_height-20,clip]);
                translate([wall-0.5,10,height+clip-1]) rotate([-90,0,0]) cylinder(module_height-20,r=0.95);
                translate([module_width-wall+0.2,10,height]) cube([wall-0.2,module_height-20,clip]);
                translate([module_width-wall+0.2,10,height+clip-1]) rotate([-90,0,0]) cylinder(module_height-20,r=0.95);
          }
            translate([wall/2,9,height+clip]) rotate([0,45,0]) cube([wall,module_height-20+2,wall]);
            translate([module_width-4*wall/2-0.5,9,height+clip-0.5]) rotate([0,45,0]) cube([wall,module_height-20+2,2*wall]);
        }
    }
}

module bottom() {

    union() {
        difference() {
            rcube([module_width,module_height,16],2);
            translate([-1,-1,wall+module_seat+module_thick]) cube([module_width+2,module_height+2,20]);
            translate([wall*2,wall,wall]) cube([module_width-4*wall,module_height-2*wall,20]);
            // side slots
            translate([-1,10,wall+1]) cube([wall+1,module_height-20,20]);
            translate([wall,10,wall+3]) rotate([-90,0,0]) cylinder(module_height-20,r=1);
            translate([module_width-wall,10,wall+1]) cube([wall+1,module_height-20,20]);
            translate([module_width-wall,10,wall+3]) rotate([-90,0,0]) cylinder(module_height-20,r=1);
            // mount cutout
            translate([module_width/2-(29-2*wall)/2,wall,-1]) cube([29-2*wall,29.85,16]);
            translate([2*wall+1.25,wall,wall+0.515]) rotate([0,90,0]) cylinder(29-2*wall,r=.515);
            // wifi cutouts
            wx = (module_width-10-4*wall)/2-1;
            translate([2*wall+5,module_height-11,-1]) cube([wx,2,wall+2]);
            translate([2*wall+5,module_height-8,-1]) cube([wx,2,wall+2]);
            translate([2*wall+5,module_height-5,-1]) cube([wx,2,wall+2]);
            translate([2*wall+7+wx,module_height-11,-1]) cube([wx,2,wall+2]);
            translate([2*wall+7+wx,module_height-8,-1]) cube([wx,2,wall+2]);
            translate([2*wall+7+wx,module_height-5,-1]) cube([wx,2,wall+2]);
            // sd card cutout
            translate([module_width/2-10,-1,wall+module_seat]) cube([20,4,10]);
        }
        // mount for esp32
        translate([2*wall,module_height-11,wall]) cube([3,11-wall,module_seat]);
        translate([module_width-2*wall-3,module_height-8,wall]) cube([3,8-wall,module_seat]);
        translate([2*wall,wall,wall]) cube([1.25,3,module_seat]);
        translate([2*wall,wall,module_seat]) cube([3.5,3,wall]);
        translate([2*wall+2.55,wall,module_seat+wall-0.25]) rotate([0, 150, 0]) cube([3.5,3,wall]);
        translate([module_width-2*wall-1.2,wall,wall]) cube([1.7,3,module_seat]);
        translate([module_width-2*wall-3.5,wall,module_seat]) cube([3.5,3,wall]);
        translate([module_width-2*wall-3.5,wall,module_seat]) rotate([0, 30, 0]) cube([3.5,3,wall]);
    }
}

module mount() {
    difference() {
        union() {
            difference() {
                union() {
                    rcube([29.85,29,16],2);
                }
                translate([-1,-1,14]) cube([32,32,20]);
                translate([wall,wall,wall]) rcube([29.85-2*wall,29-2*wall,16],2);
                translate([7.2,-0.8,10]) cube([15.6,1.7,5]);
                translate([7.2,29-0.8,10]) cube([15.6,1.7,5]);
                               
                servo();
            }

            clips();
        }
        // wire opening bottom
        translate([27,22,6]) rotate([0,90,0]) cylinder(4, r=3);
    }
}

module servo() {
    // servo connectors opening
    translate([-1,29/2-5,4]) cube([4,10,6.5]);
}

module clips() {
    translate([0,wall+0.2,13.5]) cube([wall,29-2*wall-0.4,wall+1.5]);
    translate([0,wall+0.2,14+wall+0.5]) rotate([-90,0,0]) cylinder(29-2*wall-0.4,r=.5);

    translate([29.85-wall*1.4,wall+0.2,wall]) cube([wall*1.4,29-2*wall-0.4,15]);
    translate([29.85,wall+0.2,14+wall+0.5]) rotate([-90,0,0]) cylinder(29-2*wall-0.4,r=.5);
    translate([wall-0.2,8,wall]) cylinder(15,r=1);
    translate([wall-0.2,29-8,wall]) cylinder(15,r=1);
}