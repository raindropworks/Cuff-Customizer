use<write.scad>

//write(word="1234", h=H, t=T,rotate=ROTATE,space=SPACE,center=CENTER,font=FONT,bold=BOLD)

Fonts = [
    "BlackRose",
    "braille",
    "knewave",
    "Letters",
    "orbitron"
];

for (i=[0:1:len(Fonts)-1])
    translate([0, i*8.0, 0])
        write(str(Fonts[i]),t=3,h=5,center=true,font=str(Fonts[i],".dxf"));
