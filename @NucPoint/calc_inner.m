function calc_inner(obj, K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, enviro_pressure)
    %{
        This method takes a single point and calculated the inner force acting on it 
    %}
    %A Nucleus point has 5 neighbors which influence its inner force
        voigt_valOne = calc_voigt(obj, obj.NN_One,B_nmem, K_nmem, nucMem_l);
        voigt_valTwo = calc_voigt(obj, obj.NN_Two,B_nmem, K_nmem, nucMem_l);
        voigt_valThree = calc_voigt(obj, obj.ONN_One,B_ncyt, K_ncyt, nucOpp_l);
        voigt_valFour = calc_voigt(obj, obj.ONN_Two,B_ncyt, K_ncyt, nucOpp_l);
        voigt_valFour = calc_voigt(obj, obj.ONN_Two,B_ncyt, K_ncyt, nucOpp_l);
        voigt_valFive = calc_voigt(obj, obj.MN,B_cyst, K_cyst, cyt_l);
        %don't forget to include liquid force
        %liquid force might not apply here....
        obj.force = voigt_valOne + voigt_valTwo + voigt_valThree + voigt_valFour + voigt_valFive
    
end