// Base unit

// Inputs
tol = 3;
board_size = 50 + tol;
board_height = 3;

capaciter_length = 30;
capaciter_diameter = 7.5;

face_size = 4;
edge_size = 6;
corner_size = 8;

lid_holes_depth = 5;
lid_holes_diameter = 3.8;

rest_size = 3;

base_thickness = 2;
board_section_height = 5;
cap_section_height = 10;

// Parameters
face_xysize = board_size + (2 * face_size);
edge_xysize = board_size + (2 * edge_size);

face_offset = corner_size - face_size;
edge_offset = corner_size - edge_size;

rest_height = base_thickness + capaciter_diameter + 4;

total_height = base_thickness + capaciter_diameter + board_height + 10;
points = [[0,0], [1,0], [1,1], [0,1]];
angles = [0,90,180, 270];

// Method
difference() {
    union() {
        // faces
        translate([face_offset, face_offset, 0]) {
            cube([face_xysize, face_xysize, total_height], false);
        }
        
        // bottom edges
        translate([edge_offset, edge_offset, 0]) {
           cube([edge_xysize, edge_xysize, edge_size], false);
        }
        
        // side edges
        for(i = [0:3]) {
                translate([edge_offset + (edge_size + board_size) * points[i][0], edge_offset + (edge_size + board_size) * points[i][1], 0]) { 
                    cube([edge_size, edge_size, total_height], false);
                }
        }
        
        // corners
        for(i = [0:3]) {
                translate([(corner_size + board_size) * points[i][0], (corner_size + board_size) * points[i][1], 0]) { 
                    cube([corner_size, corner_size, corner_size], false);
                }
        }
    }
    
    #union() {
        // Hollow out for board
        translate([face_offset + face_size, face_offset + face_size, base_thickness]) {
           cube([board_size, board_size, total_height], false);
        }
        
        // side holes     
        lid_holes_offset = edge_offset + (edge_size/2);
        for(i = [0:3]) {
            
                translate([lid_holes_offset + (edge_size + board_size) * points[i][0], lid_holes_offset + (edge_size + board_size) * points[i][1], total_height - lid_holes_depth]) { 
                        cylinder(d=lid_holes_diameter, h=lid_holes_depth + 1, center=false, $fn=10);
                }
        }
    }
}

// Create rests for board

for(i = [0:3]) {
    translate([face_offset + face_size + board_size * points[i][0], face_offset + face_size + board_size * points[i][1], 0]) {
        rotate([0,0,angles[i]]) {
            prism(rest_size, rest_height); 
        }
    }
}

module prism(side, height) {
    linear_extrude(height=height, center=false, twist=0, scale=1, slices=1) {
        polygon([[0,0], [side, 0], [0, side]]); 
    }   
}
