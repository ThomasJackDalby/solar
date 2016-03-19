// Bolt experiment

// Inputs
holes = [2.4,2.6,2.8,3.0,3.2,3.5];
num_wide = 2;
num_depth = 3;
margin = 3;
depth = 5;
lip = 0.0;

// Method
maxsize = max(holes)+ margin * 2; 
echo(maxsize=maxsize);

for(i = [0:1:len(holes)-1]) {
    radius = holes[i];
    x = i % num_wide;
    y = ceil((i-(num_wide-1))/num_wide) % num_depth;
    hole(radius, [x * maxsize, y * maxsize], depth + i*lip, maxsize);
}

module hole(radius, position, depth, size) { 
    echo (radius=radius);
    echo(size=size);
    translate([position[0], position[1], 0]) {
        difference() {
            cube([size, size, depth], center = true); 
            cylinder($fn=10, h = depth + 1, r=radius, center = true);
        }
    }
}
