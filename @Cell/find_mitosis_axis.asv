function find_mitosis_axis(obj)
    N = obj.NodeCount;        
    axis = 1;
    dist_one = calc_point_dist(obj.MembranePoints{1,1},obj.MembranePoints{(floor(N/2) + 1), 1});
    dist_two = calc_point_dist(obj.MembranePoints{N,1}, obj.MembranePoints{floor(N/2), 1});
    lowest_dist = (dist_one + dist_two)/2; 
    for i=2:floor(N/2)
        dist_one = calc_point_dist(obj.MembranePoints{i,1},obj.MembranePoints{(floor(N/2) + i), 1});
        dist_two = calc_point_dist(obj.MembranePoints{i-1,1}, obj.MembranePoints{floor(N/2) + i - 1, 1});
        test_dist = (dist_one + dist_two)/2; 
        if test_dist < lowest_dist
           lowest_dist = test_dist;
           axis = i;
        end
    end
    
    %cell with an odd number of nodes must account for an extra axis
    %no this may not be necessary....
    %{
    if mod(N,2) ~= 0
        dist_one = calc_point_dist(obj.MembranePoints{N,1},obj.MembranePoints{((N/2) + 1), 1});
        dist_two = calc_point_dist(obj.MembranePoints{N-1,1}, obj.MembranePoints{(N/2), 1});
        test_dist = (dist_one + dist_two)/2; 
        if test_dist < lowest_dist
           lowest_dist = test_dist;
           axis = floor(N/2) + 1;
           
        end
    end
    %}   
  
    obj.Mitosis_Axis = axis;
    
    if axis == 1
        
        obj.MembranePoints{1,1}.Mitosis_Group = 1;
        obj.MembranePoints{N,1}.Mitosis_Group = 1;
        obj.MembranePoints{floor(N/2),1}.Mitosis_Group = 2;
        obj.MembranePoints{floor(N/2)+1,1}.Mitosis_Group = 2;
        obj.mitosis_div_axis_points = [1 N floor(N/2) floor(N/2)];
        
    else
        obj.MembranePoints{axis,1}.Mitosis_Group = 1;
        obj.MembranePoints{axis-1,1}.Mitosis_Group = 1;
        obj.MembranePoints{axis+floor(N/2),1}.Mitosis_Group = 2;
        obj.MembranePoints{axis+floor(N/2)-1,1}.Mitosis_Group = 2;
        obj.mitosis_div_axis_points = [axis axis-1 axis+floor(N/2) axis+floor(N/2)-1]; 
    end
    
    %setting axis.
    
    %we will now loop through the nucleus points and assign them their
    %groups
    
    for i=1:N
        
        if i >= axis && i < axis + floor(N/2) -1  
            
            obj.NucleusPoints{i,1}.Mitosis_Group = 1;
       
        elseif i < axis || i >= axis + floor(N/2)
            
            obj.NucleusPoints{i,1}.Mitosis_Group = 2;
            
       end 
           
    end
    
    %we end by setting mitosis spring settings
    obj.mitosis_mem_l = obj.cyt_l;
    obj.mitosis_nuc_l = obj.nucOpp_l;

end

%{
    Determines between which set points the B and A mitosis groups should
    be split and marks the nodes as either group 1(A), 2(B), a 0 indicates
    that the nodes are not currently undergoing mitosis and do not require
    mitotic forces applied to it.
%}