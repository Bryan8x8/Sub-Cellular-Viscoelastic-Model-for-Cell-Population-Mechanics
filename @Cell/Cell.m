classdef Cell < handle
   properties   
      Position; %x,y avg center position
      R_Nuc;
      R_Mem;
      NodeCount;
      NucleusPoints;
      MembranePoints;
   end
   
   methods
       
      function obj = Cell(N, x_point, y_point, r_nuc, r_mem)
        if nargin == 5
            if isnumeric(N) && isnumeric(x_point) && isnumeric(y_point)
                obj.Position = [x_point y_point];
                obj.NodeCount = N;
                obj.NucleusPoints = cell(N,1);
                obj.MembranePoints = cell(N,1);
                obj.R_Nuc = r_nuc;
                obj.R_Mem = r_mem;
            else
                error('Cell Class Constructor Parameters Must Be Numeric')
            end
        else
            error('Invalid Number of Inputs to Cell Class Constructor')
        end
      end
      
      addCellRow(obj,rowNum)
      grow(obj)
 
      end
end