function calc_inner(obj, K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, enviro_pressure, N)
    %{
        This method takes a single point and calculated the inner force acting on it 
    %}
    %A Nucleus point has 5 neighbors which influence its inner force
        %NN One
        [voigt_valOne, voigt_valOne_opp] = calc_voigt(obj, obj.NN_One,B_nmem, K_nmem, nucMem_l);
        %obj.NN_One.force = obj.NN_One.force + voigt_valOne_opp;
        
        %NN Two 
        [voigt_valTwo, voigt_valTwo_opp] = calc_voigt(obj, obj.NN_Two,B_nmem, K_nmem, nucMem_l);
        %obj.NN_Two.force = obj.NN_Two.force + voigt_valTwo_opp;
        
        %ONN One
        [voigt_valThree, voigt_valThree_opp] = calc_voigt(obj, obj.ONN_One, B_ncyt, K_ncyt, nucOpp_l);
        %obj.ONN_One.force = obj.ONN_One.force + voigt_valThree_opp;
        
        %ONN Two
        [voigt_valFour, voigt_valFour_opp] = calc_voigt(obj, obj.ONN_Two, B_ncyt, K_ncyt, nucOpp_l);
        %obj.ONN_Two.force = obj.ONN_Two.force + voigt_valFour_opp;
        
        %MN
        [voigt_valFive, voigt_valFive_opp] = calc_voigt(obj, obj.MN,B_cyst, K_cyst, cyt_l);
        %obj.MN.force = obj.MN.force + voigt_valFive_opp;
        %{
        THIS SECTION IS USED FOR TESTING PURPOSES
        if N == 12
            mult = -1;
            NN_One = mult*voigt_valOne;
            NN_Two = mult*voigt_valTwo;
            ONN_One = mult*voigt_valThree;
            ONN_Two = mult*voigt_valFour;
            MN = mult*voigt_valFive;
            total_force = mult*(voigt_valOne + voigt_valTwo + voigt_valThree + voigt_valFour + voigt_valFive);
            velocity = obj.velocity;
            velocity;
            position = obj.Position;
            position;
            %fprintf('Forces: \n NN_One:  %.30f, %.30f \n NN_Two: %.30f, %.30f \n ONN_One: %.30f, %.30f \n ONN_Two: %.30f, %.30f \n MN: %.30f, %30f \n Total Force: %.30f, %.30f \n\n Velocity: %.30f, %.30f \n Position: %.30f, %.30f \n', NN_One(1,1), NN_One(1,2), NN_Two(1,1), NN_Two(1,2), ONN_One(1,1), ONN_One(1,2), ONN_Two(1,1), ONN_Two(1,2), MN(1,1), MN(1,2), total_force(1,1), total_force(1,2), velocity(1,1), velocity(1,2), position(1,1), position(1,2) )
        end
        %}
        
        obj.force = (-1)*(voigt_valOne + voigt_valTwo + voigt_valThree + voigt_valFour + voigt_valFive);
         
end