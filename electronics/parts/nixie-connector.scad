include <nixie.scad>

difference() {
    in14spacer ();

    $fn=3;
    translate([0,0,-1]) cylinder(h=8, r=2.5);
}
