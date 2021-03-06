// Solar bracket

// Inputs

actual_panel_size = 50;
tolerance = 3;
panel_size = actual_panel_size + tolerance;
panel_height = 2.8;

panel_bevel = 1.8;
panel_edge = 2;
display_panel = false;

external_margin = 3;
internal_margin = 8;
total_height = 4;
total_size = panel_size + (external_margin * 2);
    
hole_diameter = 4;
hole_margin = 8;

// Method
module bracket() {
    difference() {
        union() {
            difference() {
                union() {
                    cube([total_size, total_size, total_height], false);
                    cylinder(d=hole_diameter+hole_margin, h=total_height, center=false);
                }
                union() {       
                    origin = external_margin + internal_margin;
                    translate([origin, origin, -0.5]) { 
                        size = panel_size - (internal_margin * 2);
                        cube([size, size, total_height+1], false); 
                    }
                    
                    translate([external_margin, external_margin, total_height - panel_height]) { 
                        cube([panel_size, panel_size, panel_height+1], false); 
                    }
                }
            }  
            
        }
        translate([0,0,-0.5]) {
            cylinder(d=hole_diameter, h=total_height+1, center=false);
        }
    }
}



module panel() {
    translate([external_margin,external_margin,total_height - panel_height]) { cube([panel_size, panel_size, panel_height-0.01], false); }
}


if (display_panel) color("gray") { panel(); }
color("orange") { bracket(); };