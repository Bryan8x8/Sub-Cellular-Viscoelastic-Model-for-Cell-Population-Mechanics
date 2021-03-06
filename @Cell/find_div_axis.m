function find_div_axis(obj)

    mem_one1 = obj.MembranePoints{obj.mitosis_div_axis_points(1,1),1};
    mem_one2 = obj.MembranePoints{obj.mitosis_div_axis_points(1,2),1};
    mem_two1 = obj.MembranePoints{obj.mitosis_div_axis_points(1,3),1};
    mem_two2 = obj.MembranePoints{obj.mitosis_div_axis_points(1,4),1};
    
    %we will find a centerline that lies between the lines of each mempoint
    %and their nucleus neighbor
    
    mem_one_uvec = calc_unit_vector(mem_one1, mem_one2);
    mem_one_dist = calc_point_dist(mem_one1, mem_one2);
    mem_one_point = mem_one1.Position + (mem_one_dist/2);
    
    nuc_one1 = mem_one1.NN;
    nuc_one2 = mem_one2.NN;
    nuc_one_uvec = calc_unit_vector(nuc_one1, nuc_one2);
    nuc_one_dist = calc_point_dist(nuc_one1, nuc_one2);
    nuc_one_point = nuc_one1.Position + (nuc_one_dist/2);
    
    one_vec = mem_one_point - nuc_one_point;
    
    
    mem_two_uvec = calc_unit_vector(mem_two1, mem_two2);
    mem_two_dist = calc_point_dist(mem_two1, mem_two2);
    mem_two_point = mem_two1.Position + (mem_two_dist/2);
    
    nuc_two1 = mem_two1.NN;
    nuc_two2 = mem_two2.NN;
    nuc_two_uvec = calc_unit_vector(nuc_two1, nuc_two2);
    nuc_two_dist = calc_point_dist(nuc_two1, nuc_two2);
    nuc_two_point = nuc_two1.Position + (nuc_two_dist/2);
    
    two_vec = mem_two_point - nuc_two_point;
    
    %we now rotate one_vec and two_vec by 90 and -90 degrees respectively
    %and this will them result them pointing at roughly the correct
    %direction that group one nuc points must travel.
    one_vec = rotate_vec(one_vec, 90);
    two_vec = rotate_vec(two_vec, 90);
    %the final step is to add both vectors then find the unit vector
    %from the origin to the sum of the vectors.
    one_two_vec = one_vec + two_vec;
    placeHold1 = MemPoint(one_two_vec(1,1), one_two_vec(1,2));
    placeHold2 = MemPoint(0, 0);
    %placehold1 and placehold2 are temporary wrappers for the vector
    %position and origin in order for us to use the calc_unit_vec function.
    %This is a design flaw and I should change calc_unit_vec to accepting
    %vector values rather then Cells, MemPoints, and NucPoints.
    obj.mitosis_nuc_force_vector = calc_unit_vector(placeHold1, placeHold2);
    %testing
    pos1 = obj.NucleusPoints{5,1}.Position;
    pos = obj.NucleusPoints{5,1};
    pos_dist = calc_point_dist(pos,pos.ONN_One);
    pos2 = pos_dist*obj.mitosis_nuc_force_vector + pos1;
    
    %line([pos1(1,1),pos2(1,1)],[pos1(1,2),pos2(1,2)],'Color','green');
    %hold;
    %render(obj);
end

%{
    This function will find the direction in which nucleus points will
    experience mitotic forces
%}