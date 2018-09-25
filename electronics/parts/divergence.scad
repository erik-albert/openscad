
intersection() {
    case();
//    translate([42,0,0]) cube([20,30,20]);
}

module case() {

    // aluminum width width
    a = 0.4826;
    
    w = 180.975;       // 7 1/8
    h = 35; //31.75;         // 1 1/4
    d = 47.625 - 2*a;  // 1 7/8
    
    // shell width
    s = 2;
    
    // post inset
    pi = 2.54;
    pd = pi*2;
    
    // screws
    m2diam = 1.75;
    d4_40 = 2.2606 + .22;  // 4-40 screw hole
    
    circuitheight = 5;
    b1height = s+16;

    // battery
    bl = 32;
    bh = 5; // 5 for 1200, 8.5 for 2000
    
    // power supply
    ps_len = 18.5; ps_wid = 17; ps_x = 84; ps_y = d/2-4;

    $fn = 20;

    union() {
        
        difference() {
            
            union() {
                // base plate
                cube([w, d, s]);
                
                // end walls
                cube([s,d,h]);
                translate([w-s, 0, 0]) cube([s,d,h]);
                
                // long walls
                cube([4,s,h]);
                translate([w-12-s, 0, 0]) cube([12,s,h]);
                translate([0, d-s, 0]) cube([w,s,h]);
                
                difference() {
                    translate([0, 0, 0]) cube([w,s,h]);
                    $fn=10;
                    translate([50,0,3]) rotate([90]) cylinder(r=20,h=10,center=true);                  
                    translate([38,0,3]) rotate([90]) cylinder(r=20,h=10,center=true);                  
                    translate([26,0,3]) rotate([90]) cylinder(r=20,h=10,center=true);                  
                }
            }
            
            // cutouts for posts
            translate([pi, pi, -0.1]) cylinder (r=pd/2-.1, h=h+0.2);
            translate([w-pi, pi, -0.1]) cylinder (r=pd/2-.1, h=h+0.2);
            translate([w/2, pi, -0.1]) cylinder (r=pd/2-.1, h=h+0.2);
            translate([w/2, d-pi, -0.1]) cylinder (r=pd/2-.1, h=h+0.2);
            translate([w-pi, d-pi, -0.1]) cylinder (r=pd/2-.1, h=h+0.2);
            translate([pi, d-pi, -0.1]) cylinder (r=pd/2-.1, h=h+0.2);
            
            // vents
            vl = w/4;
            vw = 3;
            vents((w-3*vl)/4, (d - 5*vw)/4, vl, vw, s);
            
            // power supply cutout
            translate([ps_x, ps_y, -1]) cube([ps_wid, ps_len+4, 10]);
            
            // control board 1 cutout
            translate([s/2,s/2,b1height]) cube([3,d-2*s,1.6]);
            
            // buttons cutout
            translate([w-30-2.54, -1, h-5 - (10-2.54)]) rotate([-90]) cylinder(r=2, h=10);
            translate([w-50+2.54, -1, h-5 - (10-2.54)]) rotate([-90]) cylinder(r=2, h=10);

        }
        
        // middle wall support
        translate([w/2-s/2,0,0]) rotate([90,0,90]) linear_extrude(2) polygon(points=[[4,0],[8,0],[6,10],[4,10]]);

        // battery
        bx = 9.8; // inner wall
        translate([s+bl, d-s-bx, 0]) cube([s,bx,bh+s]);
        translate([s,0,s+bh]) cube([5,d,s/2]);
        translate([bl-1,d-s-bx,s+bh]) cube([5,bx,s/2]);
        translate([0,d-s-8,s+bh]) cube([bl+s,8,s/2]);
        translate([0,0,s+bh]) linear_extrude(height = s/2) polygon(points=[[s,d-20],[s+20,d-s],[s,d-s]]);
       
        // angled battery supports
        translate([s,0,s+bh]) rotate([-90]) linear_extrude(height = d) polygon(points=[[0,0],[0,1],[2,0]]);
        translate([0,d-s,s+bh]) rotate([-90,0,-90]) linear_extrude(height = bl+s) polygon(points=[[0,0],[0,1],[2,0]]);
        translate([s+bl,d,s+bh]) rotate([90,180]) linear_extrude(height = bx+s) polygon(points=[[0,0],[0,1],[2,0]]);

        // posts
        difference() {
            union() {
                translate([pi, pi, 0]) post(pd, d4_40, h);
                translate([w-pi, pi, 0]) post(pd, d4_40, h);
                translate([w/2, pi, 0]) post(pd, d4_40, h);
                translate([w/2, d-pi, 0]) post(pd, d4_40, h);        
                translate([w-pi, d-pi, 0]) post(pd, d4_40, h);
                translate([pi, d-pi, 0]) post(pd, d4_40, h);
            }
            
            // control board 1 cutout
            translate([s/2,d/2-20.5,b1height]) cube([5,41,1.6]);
            // control board 2
            translate([w/2-2.5,d/2-22,17]) cube([5,44,6]);
        }
                
        // trinket
        trinket_center = bl + 2*s + 13;
        trinket_width = 17.78;
        trinket_spacing = 13.97;
        translate([trinket_center-4,0,0]) cube([10,30,s]);
        color("red") {
            translate([trinket_center-trinket_spacing/2,1,s]) cylinder(r=1, h=s+circuitheight+1);
            translate([trinket_center+trinket_spacing/2,1,s]) cylinder(r=1, h=s+circuitheight+1);
            translate([trinket_center-trinket_width/2,0,s]) cube([17.78,2,circuitheight]);
            translate([trinket_center-3,0,s]) cube([6,6,circuitheight]);
            translate([trinket_center,26.5,s]) post(4,m2diam,circuitheight);
        }
        
        // clock
        clockx = 61; clocky = d-s-26; clockd = 25.8; clockw = 26.67;
        translate([clockx+21.7-2.54,clocky+2.54,s/2]) cube([7,12,s], center=true);
        color("purple") {
            translate([clockx+21.7-2.54,clocky+clockd-2.54,s]) post(4,0,circuitheight);
            translate([clockx+2.54,clocky+clockd-2.54,s]) post(4,m2diam,circuitheight);
            translate([clockx+21.7-2.54,clocky+2.54,s]) post(4,m2diam,circuitheight);
        }
        
        // expander board
        expx = w-8; expy = d-5.5; 
        exph = 36.25; expl = 56.25; // board is 40x60
        color("blue") {
            translate([expx,expy,s]) post(4,m2diam,circuitheight);
            translate([expx-expl,expy,s]) post(4,m2diam,circuitheight);
            translate([expx,expy-exph,s]) post(4,m2diam,circuitheight);
            translate([expx-expl,expy-exph,s]) post(4,m2diam,circuitheight);
        }
        
        // power supply
        color("green") {
            difference() {
                translate([2+ps_x+ps_wid-5, ps_y, 0]) cube([5, ps_len+4, circuitheight]);
                translate([2+ps_x-7+ps_wid, ps_y+2, circuitheight-1-s]) cube([5, ps_len, 5]);
                translate([2+ps_x-6+ps_wid, ps_y+2, circuitheight-1-s]) cube([5, ps_len, 2]);
            }
            
            difference() {
                translate([ps_x-1, ps_y, 0]) cube([2, ps_len+4, circuitheight]);
                translate([ps_x-1.1, ps_y+2, circuitheight-1-s]) cube([3, ps_len, 1.1]);
                translate([ps_x-1.1, ps_y+2.15, circuitheight-s]) cube([3, ps_len-0.3, 3]);
            }
        }
        
        // control board 1
        color("brown") {
            translate([56,d/2+17,b1height-3]) rotate([-45]) cube([5, 6, 3]);
            
            difference() {
                translate([56,d/2+17,b1height-3]) cube([5, 6, 3]);
                translate([61-2.54,d/2+20-2.54,b1height-3]) cylinder(r=1.5, h=5);
            }
            translate([61-2.54,d/2+20-2.54,b1height-3]) post(3,m2diam,h=s+bh+1+5-10);
        }
        
        // control board 2
        color("aquamarine") {
            //translate([w/2-30,d/2-20,17]) cube([60,40,1.5]);

            translate([w/2+30,d/2+17,s+12]) rotate([-45]) cube([5, 6, 3]);
            difference() {
                translate([w/2+30,d/2+17,14]) cube([5, 6, 3]);
                translate([w/2+30+2,d/2+20-2,13]) cylinder(r=1.5, h=5);
            }
            translate([w/2+30+2,d/2+20-2,14]) post(3,m2diam,h=s+bh+1+5-10);
        }   
        
        color("DarkSlateGray") {
            translate([w-30-2.54, s, h-5]) rotate([-90]) post(4,m2diam,4.5);
            translate([w-50+2.54, s, h-5]) rotate([-90]) post(4,m2diam,4.5);
        }


    }
}

module post(od, id, h) {
    difference() {
        cylinder(r=od/2, h=h);
        translate([0,0,-0.1]) cylinder(r=id/2, h=h+0.2);
    } 
}

module vents(vxs, vxy, vl, vw, vh) {
    for (j = [1:4]) {
        for (i = [1:3]) {
            translate([i*vxs+(i-1)*vl, j*vxy, -0.1]) cube([vl, vw, vh+0.2]);
        }
    }
}


