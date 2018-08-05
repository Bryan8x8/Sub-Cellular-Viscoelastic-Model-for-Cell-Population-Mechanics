function grow(obj)
    obj.NodeCount = obj.NodeCount + 1;
    N = obj.NodeCount;
    radDist = (2*pi)/N;
    connectDist = floor(N/3);
    nuc_points = zeros(N,2);
    rad = 0;
    
    %adding cell row
    
    for i=1:obj.NodeCount
        rad = rad + radDist;
        x_nuc = obj.Position(1,1) + obj.R_Nuc * cos(rad);
        y_nuc = obj.Position(1,2) + obj.R_Nuc * sin(rad);
        x_mem = obj.Position(1,1) + obj.R_Mem * cos(rad);
        y_mem = obj.Position(1,2) + obj.R_Mem * sin(rad);
            
        obj.NucleusPoints{i,1}.Position = [x_nuc y_nuc];
        obj.MembranePoints{i,1}.Position = [x_mem y_mem];
            
    end
    
    for i=1:N        
       %Connecting Nucleus Nodes to Opposing Nucleus Nodes 
       if le(i-connectDist,0) 
         obj.NucleusPoints{i,1}.ONN_One = obj.NucleusPoints{N-connectDist+i,1};
         obj.NucleusPoints{i,1}.ONN_Two = obj.NucleusPoints{i+connectDist,1};  
       elseif i-connectDist > 0 && le(i+connectDist,N)
         obj.NucleusPoints{i,1}.ONN_One = obj.NucleusPoints{i-connectDist,1};
         obj.NucleusPoints{i,1}.ONN_Two = obj.NucleusPoints{i+connectDist,1};
       elseif  i+connectDist > N         
         obj.NucleusPoints{i,1}.ONN_One = obj.NucleusPoints{i-connectDist,1};  
         obj.NucleusPoints{i,1}.ONN_Two = obj.NucleusPoints{connectDist+i-N,1};
       end       
       
       %Connecting Membrane and Nucleus nodes to their adjacent nodes
       if i == 1
          obj.NucleusPoints{i,1}.NN_One = obj.NucleusPoints{N,1};
          obj.NucleusPoints{i,1}.NN_Two = obj.NucleusPoints{i+1,1};
          %C.MembranePoints{i,1}.MN_One = C.MembranePoints{N,1};
          %C.MembranePoints{i,1}.MN_Two = C.MembranePoints{i+1,1};
       elseif i == N
          obj.NucleusPoints{i,1}.NN_One = obj.NucleusPoints{N-1,1};
          obj.NucleusPoints{i,1}.NN_Two = obj.NucleusPoints{1,1};
          %C.MembranePoints{i,1}.MN_One = C.MembranePoints{N-1,1};
          %C.MembranePoints{i,1}.MN_Two = C.MembranePoints{1,1};    
       elseif i ~= 1 && i ~= N
          obj.NucleusPoints{i,1}.NN_One = obj.NucleusPoints{i-1,1};
          obj.NucleusPoints{i,1}.NN_Two = obj.NucleusPoints{i+1,1};
          %C.MembranePoints{i,1}.MN_One = C.MembranePoints{i-1,1};
          %C.MembranePoints{i,1}.MN_Two = C.MembranePoints{i+1,1};
       end 
       
    end
end