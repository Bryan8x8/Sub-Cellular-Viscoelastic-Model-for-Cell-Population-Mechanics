function unit_vec = calc_unit_vector(p1, p2)
    mag = calc_point_dist(p1,p2);
    vec = p2.Position-p1.Position;
    unit_vec = vec/mag;
end