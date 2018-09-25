

module in12socket(h = 5, pr = .6, cr = 3.5) {
    $fn = 16;
    
    difference() {
        
        union() {
            translate([5,8,0]) cylinder(r=4, h=h);
            translate([-5,8,0]) cylinder(r=4, h=h);
            translate([5,-8,0]) cylinder(r=4, h=h);
            translate([-5,-8,0]) cylinder(r=4, h=h);
            
            translate([-9,-8,0]) cube([18,16,h]);
            translate([-6,-12,0]) cube([12,24,h]);
        }
        
        union() {    
            translate([0,0,-1]) cylinder(r=cr,h=h+2);

            translate([0,+9,-1]) cylinder(r=pr,h=h+2);
            translate([0,-9,-1]) cylinder(r=pr,h=h+2);
            
            translate([+4,+8,-1]) cylinder(r=pr,h=h+2);
            translate([+4,-8,-1]) cylinder(r=pr,h=h+2);
            translate([-4,+8,-1]) cylinder(r=pr,h=h+2);
            translate([-4,-8,-1]) cylinder(r=pr,h=h+2);

            translate([+11.5/2,+9/2,-1]) cylinder(r=pr,h=h+2);
            translate([-11.5/2,+9/2,-1]) cylinder(r=pr,h=h+2);
            translate([+11.5/2,-9/2,-1]) cylinder(r=pr,h=h+2);
            translate([-11.5/2,-9/2,-1]) cylinder(r=pr,h=h+2);

            translate([+11.5/2,0,-1]) cylinder(r=pr,h=h+2);
            translate([-11.5/2,0,-1]) cylinder(r=pr,h=h+2);
        }
    }
}