function calc_inner(obj, K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, enviro_pressure, N, row)
    %{
        This method takes a single point and calculated the inner force acting on it 
    %}
       %A Membrane point has 3 neighbors which influence its inner
       %force   
       
       %MN One
       [voigt_valOne, voigt_valOne_opp] = calc_voigt(obj, obj.MN_One,B_mmem, K_mmem, cellMem_l, N, row); %MN = Membrane Neighbor  
       %obj.MN_One.force = obj.MN_One.force + voigt_valOne_opp;
       
       %MN Two
       [voigt_valTwo, voigt_valTwo_opp] = calc_voigt(obj, obj.MN_Two,B_mmem, K_mmem, cellMem_l, N, row);   
       %obj.MN_Two.force = obj.MN_Two.force + voigt_valTwo_opp;
       
       %NN
       [voigt_valThree, voigt_valThree_opp] = calc_voigt(obj, obj.NN,B_cyst, K_cyst, cyt_l, N, row); %NN = Nucleus Neighbor
       %obj.NN.force = obj.NN.force + voigt_valThree_opp;
       
       %Cyto
       cyto_f_val = calc_cyto_force(obj, inner_pressure, enviro_pressure);
       
       %THIS SECTION IS USED FOR TESTING PURPOSES
       %{
       if N == row
            mult = -1;
            MN_One = mult*voigt_valOne;
            MN_Two = mult*voigt_valTwo;
            NN = mult*voigt_valThree;           
            total_force = mult*(voigt_valOne + voigt_valTwo + voigt_valThree);
            velocity = obj.velocity;
            velocity;
            position = obj.Position;
            position;
            fprintf('Forces: \n MN_One:  %.30f, %.30f \n MN_Two: %.30f, %.30f \n NN_One: %.30f, %.30f \n Total Force: %.30f, %.30f \n\n Velocity: %.30f, %.30f \n Position: %.30f, %.30f \n', MN_One(1,1), MN_One(1,2), MN_Two(1,1), MN_Two(1,2), NN(1,1), NN(1,2), total_force(1,1), total_force(1,2), velocity(1,1), velocity(1,2), position(1,1), position(1,2) )
            
        end
       %}
       obj.force = (-1)*(voigt_valOne + voigt_valTwo + voigt_valThree + cyto_f_val);
       
end

%{
    This is a MemPoint fuction.

    Purpose is to calculate all inner forces acting on the node that is calling
    this function and write them to the 'force' variable.

    Inputs:

        obj: object that calls function

        K_cyst: Cytoskeleton spring constant
 
        K_ncyt: Nucleus Cytoskeleton spring constant
 
        K_mmem: Membrane adjacent spring constant

        K_nmem: Nucleus adjacent neighbor spring constant
 
        B_cyst: Cytoskeleton dampening constant
 
        B_ncyt: Nucleus Cytoskeleton spring constant

        B_mmem: Membrane adjacent neighbor dampening constat
 
        B_nmem: Nucleus adjacent neighbor dampening constant
 
        cellMem_l: Membrane adjacent neighbor spring rest length
 
        nucMem_l: Nucleus adjacent neighbor spring rest length
 
        cyt_l: Cytoskeleton spring rest length
 
        nucOpp_l: Nucleus Cytoskeleton spring rest length
 
        inner_pressure: pressure within cell
 
        enviro_pressure: environmental pressure
 
        N: Used for testing purposes, can be filled by any integer value.

        
%}