//
// This model is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 International License.
// 
// You should have received a copy of the license along with this
// work. If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
//

// 
// customizable dip socket
//
// designed to hold standard machined DIP or Wirewrap pins with 1.83mm diameter
//

dip(16);


// pins   - number of pins (e.g., 10, 14, 28)
// pitch  - spacing between wholes in the pcb (e.g., 2.45 or 1.27)
// rs     - spacing between pin rows (e.g., 7.62, 10.16, or 15.24)
// cut    - should window be cut in the middle section?
// h1     - 'outer' height
// h2     - 'inner' height

module dip(pins, pitch = 2.54, rs = 7.16, cut = false, h1 = 4, h2 = 2) {
    r1 = 1.9/2;  // 1.83 with wiggle room
    r2 = 1.42/2; // 1.35 with wiggle room
    p = pins + pins % 2;  // ensure even number of pins
    
    difference() {
        translate([-pitch/2,-pitch/2,0]) cube([pitch * p/2, rs + pitch, h1]);
        
        union() {
            // pin 1 indicator cutout
            $fn=20; 
            translate([-pitch/2,rs/2,-1]) cylinder(h = h1+2, r = pitch/1.3);
            
            // lower middle section cutout
            translate([-pitch,pitch/2,h2]) cube([pitch * p/2 + pitch, rs-pitch, h1]);
            
            // pin holes
            for (i = [0:p/2-1]) {
                $fn=10; 
                cx = i * pitch;
                translate([cx, 0, -1]) cylinder(h = h1+2, r = r2);
                translate([cx, 0, h1-1]) cylinder(h = h1+1, r = r1);
                translate([cx, 0 + rs, -1]) cylinder(h = h1+1, r = r2);    
                translate([cx, 0 + rs, h1-1]) cylinder(h = h1+1, r = r1);    
            }
            
            // "window" cutout
            if (cut && p >= 12) {
                translate([1.5 * pitch, pitch/2, -1]) cube([(pins / 2 - 3.5) * pitch, rs-pitch, 2*h1]);
            }
            
        }
    }
}