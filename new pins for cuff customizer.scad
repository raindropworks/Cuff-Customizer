//Improved pins and new locking option for the 'Cuff & Collar customizer' by malprocrastination (https://www.thingiverse.com/thing:528239)
// Copyright 2023 Raindrop Works (CC-BY-SA 4.0) v1.0a

// To use: You will need to use the customizer from the above link to make the cuff/collar. This only replaces the 'lock pin' from that design. Copy the cuff width from that customizer into this one.

// Changelog
// v1.0a Reversed the z translations so it's not upside down anymore

//Cuff width from customizer:
Cuff_Width = 30; // [15:80]

//Fudge factor to shrink to allow smooth fit:
Fudge = 97; //[95:105]

//Making extended pin for padlock?
Padlock_option = 1;// [0:No,1:Yes]
//Diameter of padlock shackle (in mm):
Padlock_hole = 5;// [3.0:15.0]

//Adjust the size of the attachment bracket
//Attachment_Style = 10; //[0:None,5:Small,10:Medium,20:Thick]

//Adjust the size of the hole in the attachment braket to accomodate different size rope or string
//Attachment_Hole_Size = 7; // [5:Small,7:Medium,10:Large]
cuff_wall = Cuff_Width/4;
hinge_hole_d = cuff_wall/2;
cuff_width = Cuff_Width;
fudge = Fudge/100;
pin_head_d = hinge_hole_d+5;
lock=Padlock_option;
lock_hole=3.5*1.2; //add 20% to allow for shackle curve

//base pin
cylinder (r=(hinge_hole_d/2)*fudge,h=cuff_width,center=true, $fn=100);
//pin cap
translate([0,0,-(cuff_width/2)])
    cylinder (r=pin_head_d/2,h=(cuff_width/20),center=true, $fn=100);

 //lock pin (increase length by triple shackle hole, then add ball to end, hole at the center of ball
 if (lock == 1) {
     translate([0,0,cuff_width/2])
     difference() {
            union() {
            cylinder(r=(hinge_hole_d/2)*fudge,h=lock_hole*4,center=true, $fn=100);
            translate([0,0,lock_hole*2])
                sphere(r = (hinge_hole_d/2)*fudge, $fn=100);
            }
            translate([-(pin_head_d/2),0,lock_hole*1.51])    
                rotate([0,90,0])
                    cylinder(r=lock_hole/2,h=pin_head_d*1.5, $fn=100);
        }
     }