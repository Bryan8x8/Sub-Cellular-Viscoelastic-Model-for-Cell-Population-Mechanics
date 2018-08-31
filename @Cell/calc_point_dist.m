function dist = calc_point_dist(p1, p2)
    pos_one = p1.Position;
    pos_two = p2.Position;
    dist = ((pos_one(1,2) - pos_two(1,2))^2 + (pos_one(1,1)- pos_two(1,1))^2)^(1/2);
    
end

%{
    Takes two points(NucPoint, MemPoint, or Cell) and determines the distance between them
%}