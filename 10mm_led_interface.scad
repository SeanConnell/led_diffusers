// Author: Sean Connell 
// What: This is a rough toy diffuser that press fits 10mm leds (with some minor adjustment based on your 3d printer)
// Intended to allow plugging in a bunch of leds into the diffuser.

//Try playing with these values to find your favorite look.
diffuser = 1; //thickness of diffuser
led_tip = 8; //width of the inner led tip. play with this to get the right amount of press fit force/friction
row = 5; //how many leds tall
col = 5; //how many leds wide
bottom_snap = 28; //offset of led emission to diffuser. Controls sharpness of light on diffuser
bottom = 6; //distance from LED tip inside of inner ring to diffuser. 

//you probably don't need to touch anything below this line
rowsize = 20 * row;
colsize = 20 * col;

quality = 100;
translate([0,0,led_tip + bottom + bottom_snap]) plate(diffuser);
translate([0,0, bottom + bottom_snap]) bored_plate(led_tip, 4.5);
translate([0,0, bottom_snap]) bored_plate(bottom, 6.5);
bored_plate(bottom_snap, 7);

module plate(height) {
    linear_extrude(height) {
        square(rowsize,colsize);
    }
}

module bored_plate(height, hole_radius) {
quality = 300;
    linear_extrude(height) {
        difference() {
           square([rowsize,colsize], center=false, $fn=quality);
           for (x = [1:2:col * 2]) {
               for( y= [1:2:row * 2]) {
                                  translate([x*10,y*10,0]) circle(r = hole_radius, $fn=quality);
                   
               }
           }
        }
  }      
}
