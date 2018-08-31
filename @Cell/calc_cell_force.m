function calc_cell_force(obj)
    %{
        We begin by "unpacking" our working cell and retrieving all
        neessary data from it
        
    %}

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
    
    

    for i=1:obj.NodeCount
        
        row = obj.rowNum;
        %CALCULATING INNER FORCE ACTING ON POINTS.
        obj.MembranePoints{i,1}.calc_inner(K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, external_pressure, i,row);
        obj.NucleusPoints{i,1}.calc_inner(K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, external_pressure, i);
        
        %CALCULATING CELL CELL FORCE ACTING ON POINTS.
        
        
        %CALCULATING CELL ECM FORCE ACTING ON POINTS.
        
        
        %CALCULATING EXTERNAL FORCE
        
        
        %CALCULATING MITOSIS FORCE
        
        
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