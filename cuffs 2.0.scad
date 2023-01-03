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

/* [Back Text] */
//Back text engraved or embossed on the cuff
Back_Text_Style = 3; //[1:Engrave,2:Emboss,3:None]
//Choose your font for the back
Back_font = "write/knewave.dxf"; //["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy,"write/braille.dxf":Braille,"write/knewave.dxf":Smooth]
//Enter your custom inscriptions
Back_inscription = "Rules";
// font depth can be adjusted, if embossing a smaller number is best. If you are engraving try out 25 to cut the letters out entierly for an interesting effect
Back_depth = 3; // [0.5,1,2,3,5,8,25:25 - Cutout]

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