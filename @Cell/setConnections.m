function setConnections(obj)
    N = obj.NodeCount;
    connectDist = floor(N/3);
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
          obj.MembranePoints{i,1}.MN_One = obj.MembranePoints{N,1};
          obj.MembranePoints{i,1}.MN_Two = obj.MembranePoints{i+1,1};
          obj.NucleusPoints{i,1}.MN = obj.MembranePoints{i,1};
          obj.MembranePoints{i,1}.NN = obj.NucleusPoints{i,1};
       elseif i == N
          obj.NucleusPoints{i,1}.NN_One = obj.NucleusPoints{N-1,1};
          obj.NucleusPoints{i,1}.NN_Two = obj.NucleusPoints{1,1};
          obj.MembranePoints{i,1}.MN_One = obj.MembranePoints{N-1,1};
          obj.MembranePoints{i,1}.MN_Two = obj.MembranePoints{1,1};  
          obj.NucleusPoints{i,1}.MN = obj.MembranePoints{i,1};
          obj.MembranePoints{i,1}.NN = obj.NucleusPoints{i,1};
       elseif i ~= 1 && i ~= N
          obj.NucleusPoints{i,1}.NN_One = obj.NucleusPoints{i-1,1};
          obj.NucleusPoints{i,1}.NN_Two = obj.NucleusPoints{i+1,1};
          obj.MembranePoints{i,1}.MN_One = obj.MembranePoints{i-1,1};
          obj.MembranePoints{i,1}.MN_Two = obj.MembranePoints{i+1,1};
          obj.NucleusPoints{i,1}.MN = obj.MembranePoints{i,1};
          obj.MembranePoints{i,1}.NN = obj.NucleusPoints{i,1};
       end
    end
end 