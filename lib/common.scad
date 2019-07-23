// 
// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-sa/4.0/
//


// rcube(size, r, center)
// rcube([width,depth,height], r, center)
// 
// cube with rounded corners

module rcube(dims_or_size, r, center = false) {
    dims = (dims_or_size[0] == undef) ? [dims_or_size, dims_or_size, dims_or_size] : dims_or_size;
    translate(center ? [-dims.x/2, -dims.y/2, -dims.z/2] : [0,0,0]) 
    union() {
        // cubes in x,y,z directions for the middle
        translate([r,r,0]) cube([dims.x - 2*r, dims.y - 2*r, dims.z]); 
        translate([r,0,r]) cube([dims.x - 2*r, dims.y, dims.z - 2*r]);
        translate([0,r,r]) cube([dims.x, dims.y - 2*r, dims.z - 2*r]);
        
        // cylinders for the vertices
        translate([r,r,r]) cylinder(dims.z - 2*r, r = r);
        translate([dims.x-r,r,r]) cylinder(dims.z - 2*r, r = r);
        translate([r,dims.y-r,r]) cylinder(dims.z - 2*r, r = r);
        translate([dims.x-r,dims.y-r,r]) cylinder(dims.z - 2*r, r = r);
        
        translate([r,r,r]) rotate([-90,0,0]) cylinder(dims.y - 2*r, r = r);
        translate([dims.x-r,r,r]) rotate([-90,0,0]) cylinder(dims.y - 2*r, r = r);
        translate([r,r,dims.z-r]) rotate([-90,0,0]) cylinder(dims.y - 2*r, r = r);
        translate([dims.x-r,r,dims.z-r]) rotate([-90,0,0]) cylinder(dims.y - 2*r, r = r);
        
        translate([r,r,r]) rotate([0,90,0]) cylinder(dims.x - 2*r, r = r);
        translate([r,r,dims.z-r]) rotate([0,90,0]) cylinder(dims.x - 2*r, r = r);
        translate([r,dims.y-r,r]) rotate([0,90,0]) cylinder(dims.x - 2*r, r = r);
        translate([r,dims.y-r,dims.z-r]) rotate([0,90,0]) cylinder(dims.x - 2*r, r = r);

        // spheres for the corners
        for (x = [r, dims.x - r]) {
            for (y = [r, dims.y - r]) {
                for (z = [r, dims.z - r]) {
                    translate([x,y,z]) sphere(r);
                }
            }
        }
    }
}


// rzcube(size, r, center)
// rzcube([width,depth,height], r, center)
// 
// cube with rounded corners only on the z-axis (top and bottom are flat)

module rzcube(dims_or_size, r, center = false) {
    dims = (dims_or_size[0] == undef) ? [dims_or_size, dims_or_size, dims_or_size] : dims_or_size;
    translate(center ? [-dims.x/2, -dims.y/2, -dims.z/2] : [0,0,0]) 
    union() {
        // cubes in x,y,z directions for the middle
        translate([r,r,0]) cube([dims.x - 2*r, dims.y - 2*r, dims.z]); 
        translate([r,0,0]) cube([dims.x - 2*r, dims.y, dims.z]);
        translate([0,r,0]) cube([dims.x, dims.y - 2*r, dims.z]);
        
        // cylinders for the vertices
        translate([r,r,0]) cylinder(dims.z, r = r);
        translate([dims.x-r,r,0]) cylinder(dims.z, r = r);
        translate([r,dims.y-r,0]) cylinder(dims.z, r = r);
        translate([dims.x-r,dims.y-r,0]) cylinder(dims.z, r = r);
    }
}


// h  - height
// id - inner diameter
// od - outer diameter
// d  - depth of hole
//
// post with optional inner opening (e.g., for a screw)

module post(h, od, id = 0, d = undef) {
    depth = (d == undef) ? h : d;
    difference() {
        cylinder(h, r=od/2);
        if (id > 0) {
            translate([0,0,h - depth]) cylinder(h, r=id/2);
        }
    }
}




