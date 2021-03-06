function calc_cell_force(obj)
    %{
        We begin by "unpacking" our working cell and retrieving all
        neessary data from it
        
    %}

    N = obj.NodeCount;

    %l_ad = working_cell.l_ad;
    K_cyst = obj.K_cyst; %Radial Spring Constant, kg/(s^2)
    B_cyst = obj.B_cyst; %Damping constsnts for radial springs, kg/s
    K_ncyt = obj.K_ncyt; %Nuc spring constants, kg/(s^2)
    B_ncyt = obj.B_ncyt; %Damping constants for nucleus springs, kg/s
    K_mmem = obj.K_mmem; %Cell membrane spring constants, kg/(s)^2
    B_mmem = obj.B_mmem; %Damping constants for cell membrane springs
    K_nmem = obj.K_nmem; %Nucleus membrane spring constants
    B_nmem = obj.B_nmem; %Damping constants for the springs
    
    %each cell has spring rest lengths for each component, these rest
    %lengths will be the lengths of the voigt points if the cell were
    %"ideal"
    cellMem_l = obj.cellMem_l;
    nucMem_l = obj.nucMem_l; 
    cyt_l = obj.cyt_l;
    nucOpp_l = obj.nucOpp_l;
    
    inner_pressure = obj.inner_pressure;
    external_pressure = obj.external_pressure;
    
    %Setting appropriate values for mitosis force calculation if necessary
    if obj.Mitosis_Flag == 1
        mitosis_mem_l = obj.mitosis_mem_l * (N/(N+1000));
        mitosis_nuc_l = obj.mitosis_nuc_l * ((N+1)/N);
        obj.find_div_axis();
    end

    for i=1:obj.NodeCount
        
        row = obj.rowNum;
        
        %CALCULATING INNER FORCE ACTING ON POINTS.
        
            obj.MembranePoints{i,1}.calc_inner(K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, external_pressure, i,row);
            obj.NucleusPoints{i,1}.calc_inner(K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, external_pressure, i);
        
        %CALCULATING CELL CELL FORCE ACTING ON POINTS.
        
        
        %CALCULATING CELL ECM FORCE ACTING ON POINTS.
        
        
        %CALCULATING EXTERNAL FORCE
        
        
        %CALCULATING MITOSIS FORCE
        
            
            %obj.mitosis_div_axis_points(1,1)
            %obj.MembranePoints{obj.mitosis_div_axis_points(1,1),1}.calc_mitosis(K_cyst, B_cyst, obj.mitosis_mem_l);
            %obj.MembranePoints{obj.mitosis_div_axis_points(1,2),1}.calc_mitosis(K_cyst, B_cyst, obj.mitosis_mem_l);
            %obj.MembranePoints{obj.mitosis_div_axis_points(1,3),1}.calc_mitosis(K_cyst, B_cyst, obj.mitosis_mem_l);
            %obj.MembranePoints{obj.mitosis_div_axis_points(1,4),1}.calc_mitosis(K_cyst, B_cyst, obj.mitosis_mem_l);
            
            if obj.Mitosis_Flag == 1
                
                %Mistosis Forces only act on a select few membrane points
                if obj.MembranePoints{i,1}.Mitosis_Group ~= 0
                    obj.MembranePoints{i,1}.calc_mitosis(K_cyst, B_cyst, mitosis_mem_l);
                end
                %Nucleus Forces act on all points. There directions is the
                %midpoint between the orthogonal vectors of the membrane
                %mitotic forces.
                obj.NucleusPoints{i,1}.calc_mitosis(K_ncyt, B_ncyt, mitosis_nuc_l);
            end
        
    end
end

%{
    This is a Cell function

    Purpose of this function is to calculate and write all forces acting on the
    children nodes of the Cell object calling this method. All forces
    acting on nodes will be written into the respective node's 'force'
    value.


    Inputs:

        obj: object that calls function

    Outputs:

        None.

    

%}