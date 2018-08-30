function tri_area = triangle_area(p1,p2,p3)

%p1 is origin
p1 = [p1.Position 0];
p2 = [p2.Position 0];
p3 = [p3.Position 0];

tri_area = cross((p2 - p1),(p3 - p1)) * 2;

end