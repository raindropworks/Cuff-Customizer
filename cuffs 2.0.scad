include <write/Write.scad>
include <bezier.scad>
use <bezier.scad>
use <Write.scad>

/*Cuff and Collar Customizer
Copyright 2023 Raindrop Works (cc-BY-SA 4.0)

Remade based on code by malprocrastination (https://www.thingiverse.com/thing:528239)
*/

/* TODO: Line 23 from original references studs, holes and hearts. Implementing seperately.
*/

/* [Render Settings] */
//Recommend leaving at lower settings until ready to make final design. The calculations can get pretty intensive.
Render_complexity = 30; //[30:Low Res,50:Normal Res,100:Hurt me Daddy]

/* [Cuff Sizing] */
//Select the diameter for the inside of the bracelet in mm
Cuff_Size = 70; // [10:200]
//Width of the cuffs in mm (how 'tall' the cuff is if laying flat on a table
Cuff_Width = 30; // [15:80]
//How far the cuff comes off your limb
Cuff_Thick = 10; // [5:40]

/* [Cuff Markings] */
//Personalize your cuffs with an inscription (and later studs, holes and hearts)
Accent_Style = 4; //[1:Text,4:Plain]

/* [Front Text] */
//Front text engraved or embossed on the cuff
Front_Text_Style = 1; //[1:Engrave,2:Emboss]
//How many lines (2 will take a larger width cuff to print decently)
Front_Text_Lines = 1; //[1:1 line,2:2 lines]
//Choose your font for the front
Front_font = "write/knewave.dxf"; //["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy,"write/braille.dxf":Braille,"write/knewave.dxf":Smooth]
//Enter your custom inscriptions
Front_inscription_1 = "My";
Front_inscription_2 = "Pet";
// font depth can be adjusted, if embossing a smaller number is best. If you are engraving try out 25 to cut the letters out entierly for an interesting effect
Front_font_depth = 3; // [0.5,1,2,3,5,8,25:25 - Cutout]
//Text (or accent) height should be less than the top surface width. Currently Selected:
Front_font_height = 15; // [7:30]
Front_font_bold = 0.5; // [0,0.5,1,1.5,2,2.5,3:3]

/* [Back Text] */
//Back text engraved or embossed on the cuff
Back_Text_Style = 3; //[1:Engrave,2:Emboss,3:None]
//Choose your font for the back
Back_font = "write/knewave.dxf"; //["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy,"write/braille.dxf":Braille,"write/knewave.dxf":Smooth]
//Enter your custom inscriptions
Back_inscription = "Rules";
// font depth can be adjusted, if embossing a smaller number is best. If you are engraving try out 25 to cut the letters out entierly for an interesting effect
Back_depth = 3; // [0.5,1,2,3,5,8,25:25 - Cutout]
//Text (or accent) height should be less than the top surface width. Currently Selected:
Back_font_height = 15; // [7:30]
Back_font_bold = 0.5; // [0,0.5,1,1.5,2,2.5,3:3]

/* [Attachment Points] */
//Would you like a leash connection on the front of the collar?
Leash_Ring = 0; //[0:No,1:Yes]

//Would you like a bracket to attach a string or rope?
Attachment_Bracket = 2; //[0:None,1:Left Side,2:Both Sides]

//Adjust the size of the attachment bracket
Attachment_Style = 10; //[0:None,5:Small,10:Medium,20:Thick]

//Adjust the size of the hole in the attachment braket to accomodate different size rope or string. Large is also useful for attaching 'U shackles'
Attachment_Hole_Size = 7; // [5:Small,7:Medium,10:Large]

//Convert customizer to usable variables
$fn=Render_complexity;
f_text_1 = Front_inscription_1;
f_text_2 = Front_inscription_2;
b_text = Back_inscription;
f_text_type = Front_Text_Type;
b_text_type = Back_Text_Type;
cuff_inside_d = Cuff_Size;
cuff_wall = Cuff_Thick;
cuff_width = Cuff_Width;
cuff_outside_d = cuff_inside_d+cuff_thick;
cuff_middle_d = (cuff_outisde_d+cuff_inside_d)/2;
cuff_hole_d = cuff_wall/2;
cuff_edge_radius = cuff_wall/3;
hinge_play = .75*1l;
hinge_hole_d = cuff_wall/2;
fudge = 0.05*1; //used to prevent 0 thickness issues
hinge_offset = cuff_wall/2+hinge_play;
attachment_hole_d = Attachment_Hole_Size;
attachment_z = Attachment_Style;
attachment_count = Attachment_Bracket;

//build_on_build_plate(); //Leave commented until the rest of the script is ready for testing

module build_on_build_plate() {
    // put the cuff together
			translate ([+cuff_middle_d/2,0,cuff_width/2]) 
				rotate (5,[0,0,1]) 
				translate ([-cuff_middle_d/2,0,0]) 
					make_cuff_side_1 ();
			translate ([0,0,cuff_width/2]) 
				make_cuff_side_2 ();
			translate ([cuff_middle_d/2,0,0]) 
				hinge_pin();
	}

module make_cuff_side_1 () { //cuff front
		

	translate([0, -hinge_offset, 0]) {
		difference() {
			full_round_with_text (); //creates full ring, starts at line 786
			mask_half (side=1); //deletes excess material
		}

		if (f_text_type==0) { //adding embossed text
			translate ([0,0,font_height/8]) {
				writecylinder(inscription1,[0,0,0],cuff_outside_d/2,0,rotate=0,font=font,
					t=font_depth,h=font_height,bold=font_bold,center=true);
			}
		}
		translate([cuff_middle_d/2, -cuff_edge_radius, 0])
			rounded_cube([cuff_wall,cuff_edge_radius*2,cuff_width], radius=cuff_edge_radius);
		translate([-cuff_middle_d/2, -cuff_edge_radius, 0])
			rounded_cube([cuff_wall,cuff_edge_radius*2,cuff_width], radius=cuff_edge_radius);

	}
// create side 1 hinge
	translate([cuff_middle_d/2, 0, 0])
	difference() {
		hinge (side = 1);
		hinge_hole(side = 1);
	}
// create side 1 pin hole
	translate([-cuff_middle_d/2, 0, 0])
		difference() {
			hinge (side = 1);
			hinge_hole(side = 1);
		}
}

module make_cuff_side_2 () {
	translate([0, +hinge_offset, 0]) {
		difference() {
			full_round_with_text();
			mask_half (side=2);
		}
		if (b_text_type==0) { // emboss
			translate ([0,0,font_height/8]) {

				rotate (a=180,v=[0,0,1])
					writecylinder(inscription2,[0,0,0],cuff_outside_d/2,0,rotate=0,font=font,
						t=font_depth,h=font_height,bold=font_bold,center=true);
			}
		}
		translate([cuff_middle_d/2, cuff_edge_radius, 0])
			rounded_cube([cuff_wall,cuff_edge_radius*2,cuff_width], radius=cuff_edge_radius);

		translate([-cuff_middle_d/2, cuff_edge_radius, 0])
			rounded_cube([cuff_wall,cuff_edge_radius*2,cuff_width], radius=cuff_edge_radius);

// create attachement point
			attachment_point ();
	}

// create side 2 hinge
	translate([cuff_middle_d/2, 0, 0])
	difference() {
		hinge (side = 2);
		hinge_hole(side = 2);
	}

	translate([-cuff_middle_d/2, 0, 0])
	difference() {
		hinge (side = 2);
		hinge_hole(side = 2);
	}
}

module hinge_pin () {
echo (hinge_hole_d);
	translate([0,0,cuff_width/2])
		cylinder(r=hinge_hole_d/2,h=cuff_width,center=true);
}

module hinge (side =1) {
// create a hinge in the middle, something else will move it into position

	segment = cuff_width/3-hinge_play;

	length_of_filler = cuff_wall/2+hinge_offset+cuff_edge_radius;

	if (side == 1 ) {
		translate([0, 0, cuff_width/3+hinge_play/2])
			rounded_cylinder (rad=cuff_wall/2,corner_radius=cuff_edge_radius,height=segment);

		translate([0, 0, -cuff_width/3-hinge_play/2])
			rounded_cylinder (rad=cuff_wall/2,corner_radius=cuff_edge_radius,height=segment);

		translate([0, -length_of_filler/2+cuff_edge_radius, -cuff_width/3-hinge_play/2])
			rounded_cube ([cuff_wall,length_of_filler,segment],cuff_edge_radius);

		translate([0, -length_of_filler/2+cuff_edge_radius, cuff_width/3+hinge_play/2])
			rounded_cube ([cuff_wall,length_of_filler,segment],cuff_edge_radius);

	} else {

		translate([0, 0, 0])
			rounded_cyliner (rad=cuff_wall/2,corner_radius=cuff_edge_radius,height=cuff_width/3);

		translate([0, length_of_filler/2-cuff_edge_radius, 0])
			rounded_cube ([cuff_wall,length_of_filler,cuff_width/3],cuff_edge_radius);
	}
}

module hinge_hole (side = 1) { //drills holes through both hinge connections

	if (side == 1) {
		cylinder(r = hinge_hole_d/2, h = cuff_width+fudge, center = true);
	} else {
		cylinder(r = hinge_hole_d/2+hinge_play/2, h = cuff_width+fudge, center = true);

	}

}

module full_round_with_text() { //makes basic cuff shape for half, then applies text, sends back to main builder
	difference() {
		full_round_cuff();

		// engraving
		if (emboss_or_engrave==1) {
			translate ([0,0,font_height/8]) {
				writecylinder(inscription1,[0,0,0],cuff_outside_d/2,0,rotate=0,font=font,
					t=font_depth*2,h=font_height,bold=font_bold,center=true);

				rotate (a=180,v=[0,0,1])
					writecylinder(inscription2,[0,0,0],cuff_outside_d/2,0,rotate=0,font=font,
						t=font_depth*2,h=font_height,bold=font_bold,center=true);
			}
		}
	}


//embossing
		*if (emboss_or_engrave==0) {
			translate ([0,0,font_height/8]) {
				writecylinder(inscription1,[0,0,0],cuff_outside_d/2,0,rotate=0,font=font,
					t=font_depth,h=font_height,bold=font_bold,center=true);

				rotate (a=180,v=[0,0,1])
					writecylinder(inscription2,[0,0,0],cuff_outside_d/2,0,rotate=0,font=font,
						t=font_depth,h=font_height,bold=font_bold,center=true);
			}
		}


}

// Unique geometry modules

module rounded_cylinder(rad,corner_radius,height) {
rotate_extrude(convexity = 20)	
		translate([rad-corner_radius, height/2-corner_radius, 0])
			circle(r = corner_radius);
     
rotate_extrude(convexity = 20)
		translate([rad-corner_radius, -height/2+corner_radius, 0])
			circle(r = corner_radius);
            
cylinder(r=rad-corner_radius, h = height, center = true);

cylinder(r=rad, h = height-corner_radius*2, center = true);
}

module rounded_cube(size, radius) {
// Modified version of the function available in this library
// roundedBox([width, height, depth], float radius, bool sidesonly);
// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: BSD
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];

    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  
}