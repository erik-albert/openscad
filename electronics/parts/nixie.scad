//
// This model is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 International License.
// 
// You should have received a copy of the license along with this
// work. If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
//

in14spacer();

// IN-14 nixie tube spacer. Compatible with machined DIP or wire wrap
// terminals to make a nixie tube socket.
//
// height - spacer height between board and tube
// lip    - height of lip around edge

module in14spacer(height = 5, lip = 1) {
    pr1 = 1.9/2;  // 1.83 with wiggle room
    pr2 = 1.42/2; // 1.35 with wiggle room
    $fn = 42;

    difference() {
        color("grey") cylinder(h = height+lip, r = 9.25);
        
        // carve out the lip
        translate([0,0,height]) cylinder(h = lip/2+0.1, r = 8.5);
        translate([0,0,height+lip/2]) cylinder(h = lip+0.1, r = 8.75);
        
        for (i = [0:13]) {
            $fn = 10;
            cx = 5.5 * cos(360/13 * i);
            cy = 5.5 * sin(360/13 * i);

            color("green") translate([cx, cy, -1]) cylinder(h = height+2, r = pr2);
            color("purple") translate([cx, cy, height-1]) cylinder(h = 1.1, r = pr1);
        }
    }
}
