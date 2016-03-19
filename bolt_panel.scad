// Bolt experiment

// Inputs
holes = [2.4,2.6,2.8,3.0,3.2];
num_wide = 2;
num_depth = 3;
margin = 1;
depth = 5;
lip = 0.1;

// Method
maxsize = max(holes)+ margin; 
for(i = [0:1:len(holes)]) {
    radius = holes[i];
    x = i % num_wide;
    y = ceil((i-(num_wide-1))/num_wide) % num_depth;
    hole(radius, [x * maxsize, y * maxsize], depth + i*lip, maxsize);
}

module hole(radius, position, depth, size) { 
    translate([position[0], position[1], 0]) {
        difference() {
            cube([size, size, depth], center = true); 
            cylinder(h = depth + 1, radius = 5, center = true);
        }
    }
}
