function populatePoints(obj)
    N = obj.NodeCount;
    x_origin = obj.Position(1,1);
    y_origin = obj.Position(1,2);
    R_nuc = obj.R_Nuc;
    R_cell = obj.R_Mem;
    radDist = (2*pi)/N;
    connectDist = floor(N/3);

    nuc_points = zeros(N,2);
    rad = 0;
    
    %setting default spring lengths
    obj.set_spring_lengths();
    
    for i=1:N   
        rad = rad + radDist;
        x_nuc = x_origin + R_nuc * cos(rad);
        y_nuc = y_origin + R_nuc * sin(rad);
        x_mem = x_origin + R_cell * cos(rad);
        y_mem = y_origin + R_cell * sin(rad);
        NPoint = NucPoint(x_nuc,y_nuc);
        MPoint = MemPoint(x_mem,y_mem);
        %set parents
        NPoint.ParentCell = obj;
        MPoint.ParentCell = obj;
        %set mass
        NPoint.mass = (obj.M_nuc/N);
        MPoint.mass = (obj.M_mem/N);
        %obj.M_mem/N
        
        obj.NucleusPoints{i,1} = NPoint;
        obj.MembranePoints{i,1} = MPoint;
        
    end
end

%{
    This function serves to 
%}