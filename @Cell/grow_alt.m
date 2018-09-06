function grow_alt(obj)

    %{
        Growth information given in the paper is vague at best. Many of the
        calculations given by the paper only work if the cell is in an
        "ideal" state. Paper contradicts itself by allowing cells to grow
        even when "unideal". 

        This growth function has been built to tackle some of the issues
        the paper does not address

        This growth function places a new node directly in between two
        adjancent nodes that have been randomly selected. The new node's
        parameter values are an average of it's neighboring nodes. We do
        this because the cell will eventually balance itself out on it's
        own due to the new forces generated by the newly added nodes. 

        We also assume that cell and nucleus mass grows by the following
        ratios respectively (N_nuc + 1) and (M_nuc + 1)

        We will use some of the growth calculations given in the paper to
        create new "ideal" cell conditions after growth in order to adjust
        rest lengths for the springs in the voigt subunits
    %}
    %we begin by determing the position in which the new nodes will be
    %added 
    grow_pos = randi([1,obj.NodeCount],1);
    
    obj.Rest_Vol = obj.Rest_Vol * ((obj.NodeCount + 1)/obj.NodeCount)^2;
    %determining new circumference lengths, and from those new radius
    %lengths. It's important to note that recalc radius won't increment the
    %nodecount and that it must be done after the recalculation occures
    
    obj.recalc_radius("inc");
    obj.recalc_springs("inc");
    obj.NodeCount = obj.NodeCount + 1;
    
    %now that a new radius has been determined we can recalculate spring
    %lengths as it requires the radius to be accruate prior to
    %recalculation
    
    
    %now, we will create two default nodes to be added
    nPoint = NucPoint(1,1);
    mPoint = MemPoint(1,1);
    nPoint.ParentCell = obj;
    mPoint.ParentCell = obj;
    
    %adding cell row with default Points.
    obj.addCellRow_alt(grow_pos, mPoint, nPoint)
    
    %we now set connections
    obj.setConnections()
    
    %Now what the appropriate connections are set we can begin to calculate
    %their positions. We will begin with the membrane node
    
    MN_One = obj.MembranePoints{grow_pos+1,1}.MN_One;
    MN_Two = obj.MembranePoints{grow_pos+1,1}.MN_Two;
    obj.rowNum = grow_pos +1;
    %Lets establish a displacment vector at the origin equivalent to the
    %one between MN one and two
    
    dist_vec = MN_One.Position - MN_Two.Position;
    length = ((dist_vec(1,1)^2) + (dist_vec(1,2))^2)^(1/2);
    unit_vec = dist_vec./length;
    
    obj.MembranePoints{grow_pos+1,1}.Position = MN_Two.Position + (unit_vec * (length/2));
    obj.MembranePoints{grow_pos+1,1}.mass = MN_One.mass;
    obj.MembranePoints{grow_pos+1,1}.velocity = (MN_One.velocity + MN_Two.velocity)/2;
    
    %Repeat the positioning process for the nucleus node
    
    NN_One = obj.NucleusPoints{grow_pos+1,1}.NN_One;
    NN_Two = obj.NucleusPoints{grow_pos+1,1}.NN_Two;
    
    %Lets establish a displacment vector at the origin equivalent to the
    %one between MN one and two
    
    dist_vec = NN_One.Position - NN_Two.Position;
    length = ((dist_vec(1,1)^2) + (dist_vec(1,2))^2)^(1/2);
    unit_vec = dist_vec./length;
    
    obj.NucleusPoints{grow_pos+1,1}.Position = NN_Two.Position + (unit_vec * (length/2));
    obj.NucleusPoints{grow_pos+1,1}.mass = NN_One.mass;
    obj.NucleusPoints{grow_pos+1,1}.velocity = (NN_One.velocity + NN_Two.velocity)/2;
    
    
    %Now it is time to make a final adustment to the new node positions
    %at this point each new node is sitting perfectly inbetween it's two
    %neighbors, from this position it's length from the cell center must be
    %adjusted
    
    %we will begin by adjusting the nucleus first

    NN1_len = calc_point_dist(obj, NN_One);
    NN2_len = calc_point_dist(obj, NN_Two);
    N_len = calc_point_dist(obj, obj.NucleusPoints{grow_pos+1,1});
    NN_avg = (NN1_len + NN2_len)/2;
    N_uVec = calc_unit_vector(obj, obj.NucleusPoints{grow_pos+1,1});
    N_add = N_uVec*(NN_avg - N_len);
    obj.NucleusPoints{grow_pos+1,1}.Position = obj.NucleusPoints{grow_pos+1,1}.Position + N_add;
    
    %making membrane adjustment
    
    MN1_len = calc_point_dist(obj, MN_One);
    MN2_len = calc_point_dist(obj, MN_Two);
    M_len = calc_point_dist(obj, obj.MembranePoints{grow_pos+1,1});
    MN_avg = (MN1_len + MN2_len)/2;
    M_uVec = calc_unit_vector(obj, obj.NucleusPoints{grow_pos+1,1});
    M_add = M_uVec*(MN_avg - M_len);
    obj.MembranePoints{grow_pos+1,1}.Position = obj.MembranePoints{grow_pos+1,1}.Position + M_add;
    
    
end