

// rcube(size, r, center)
// rcube([width,depth,height], r, center)

module rcube(dims_or_size, r, center = false) {
    dims = (dims_or_size[0] == undef) ? [dims_or_size, dims_or_size, dims_or_size] : dims_or_size;
    echo(dims);
    translate([-dims.x/2, -dims.y/2, -dims.z/2]) 
    union() {
        // cubes in x,y,z directions for the middle
        translate([r,r,0]) cube([dims.x - 2*r, dims.y - 2*r, dims.z]); 
        translate([r,0,r]) cube([dims.x - 2*r, dims.y, dims.z - 2*r]);
        translate([0,r,r]) cube([dims.x, dims.y - 2*r, dims.z - 2*r]);
        
        // cylinders for the vertices
        translate([r,r,r]) cylinder(dims.x - 2*r, r = r);
        translate([dims.x-r,r,r]) cylinder(dims.x - 2*r, r = r);
        translate([r,dims.y-r,r]) cylinder(dims.x - 2*r, r = r);
        translate([dims.x-r,dims.y-r,r]) cylinder(dims.x - 2*r, r = r);
        
        translate([r,r,r]) rotate([-90,0,0]) cylinder(dims.x - 2*r, r = r);
        translate([dims.x-r,r,r]) rotate([-90,0,0]) cylinder(dims.x - 2*r, r = r);
        translate([r,r,dims.z-r]) rotate([-90,0,0]) cylinder(dims.x - 2*r, r = r);
        translate([dims.x-r,r,dims.z-r]) rotate([-90,0,0]) cylinder(dims.x - 2*r, r = r);
        
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


