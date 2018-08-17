function populatePoints(obj)
    N = obj.NodeCount;
    x_origin = obj.Position(1,1);
    y_origin = obj.Position(1,2);
    R_nuc = obj.R_Nuc;
    R_cell = obj.R_Mem;
    memnode_mass = (obj.M_cell/N);
    nucnode_mass = (obj.M_nuc/N);
    radDist = (2*pi)/N;
    connectDist = floor(N/3);

    nuc_points = zeros(N,2);
    rad = 0;
    
    %populating spring rest lengths.
    x_nucOne = x_origin + R_nuc * cos(rad);
    y_nucOne = y_origin + R_nuc * sin(rad);
    x_nucTwo = x_origin + R_nuc * cos(rad+radDist);
    y_nucTwo = y_origin + R_nuc * sin(rad+radDist);
    %nucleus membrane spring rest length
    obj.nucMem_l = ((x_nucTwo - x_nucOne)^2 + (y_nucTwo - y_nucOne)^2)^(1/2);
    
    x_memOne = x_origin + R_cell * cos(rad);
    y_memOne = y_origin + R_cell * sin(rad);
    x_memTwo = x_origin + R_cell * cos(rad+radDist);
    y_memTwo = y_origin + R_cell * sin(rad+radDist);
    %cell membrane spring rest length
    obj.cellMem_l = ((x_memTwo - x_memOne)^2 + (y_memTwo - y_memOne)^2)^(1/2);
    
    %cytoskeleton spring rest length
    obj.cyt_l = R_cell - R_nuc;
    
    %nucleus opposing neightbor spring rest length
    connectDist = floor(N/3);
    x_nucOne = x_origin + R_nuc * cos(radDist*connectDist);
    y_nucOne = y_origin + R_nuc * sin(radDist*connectDist);
    x_nucTwo = x_origin + R_nuc * cos(radDist*connectDist);
    y_nucTwo = y_origin + R_nuc * sin(radDist*connectDist); 
    obj.nucOpp_l = ((x_nucTwo - x_nucOne)^2 + (y_nucTwo - y_nucOne)^2)^(1/2);
    
    for i=1:N   
        rad = rad + radDist;
        x_nuc = x_origin + R_nuc * cos(rad);
        y_nuc = y_origin + R_nuc * sin(rad);
        x_mem = x_origin + R_cell * cos(rad);
        y_mem = y_origin + R_cell * sin(rad);
        NPoint = NucPoint(x_nuc,y_nuc);
        MPoint = MemPoint(x_mem,y_mem);
        NPoint.MN = MPoint;
        MPoint.NN = NPoint;
        %set parents
        NPoint.ParentCell = obj;
        MPoint.ParentCell = obj;
        %set mass
        NPoint.mass = nucnode_mass;
        MPoint.mass = memnode_mass;
        
        obj.NucleusPoints{i,1} = NPoint;
        obj.MembranePoints{i,1} = MPoint;
        
    end
end

%{
    This function serves to 
%}