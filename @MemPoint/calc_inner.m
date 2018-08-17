function calc_inner(obj, K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, enviro_pressure)
    %{
        This method takes a single point and calculated the inner force acting on it 
    %}
       %A Membrane point has 3 neighbors which influence its inner
       %force      
       voigt_valOne = calc_voigt(obj, obj.MN_One,B_mmem, K_mmem, cellMem_l); %MN = Membrane Neighbor      
       voigt_valTwo = calc_voigt(obj, obj.MN_Two,B_mmem, K_mmem, cellMem_l);     
       voigt_valThree = calc_voigt(obj, obj.NN,B_cyst, K_cyst, cyt_l); %NN = Nucleus Neighbor
       cyto_f_val = calc_cyto_force(obj, inner_pressure, enviro_pressure);
       obj.force = voigt_valOne + voigt_valTwo + voigt_valThree + cyto_f_val;
      
        

    
end