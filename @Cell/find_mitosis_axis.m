function find_mitosis_axis(obj)
    N = obj.NodeCount;        
    axis = 1;
    dist_one = calc_point_dist(obj.MembranePoints{1,1},obj.MembranePoints{((N/2) + 1), 1});
    dist_two = calc_point_dist(obj.MembranePoints{N,1}, obj.MembranePoints{(N/2), 1});
    lowest_dist = (dist_one + dist_two)/2; 
    for i=2:(floorN/2)
        dist_one = calc_point_dist(obj.MembranePoints{i,1},obj.MembranePoints{((N/2) + i + 1), 1});
        dist_two = calc_point_dist(obj.MembranePoints{i-1,1}, obj.MembranePoints{(N/2) + i, 1});
        test_dist = (dist_one + dist_two)/2; 
        if test_dist < lowest_dist
           lowest_dist = test_dist;
           axis = i;
        end
    end
        
    obj.Mitosis_Axis = axis;
        
end

%{
    Determines between which set points the B and A mitosis groups should
    be split
%}