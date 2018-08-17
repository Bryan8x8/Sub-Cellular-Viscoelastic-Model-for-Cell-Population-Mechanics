classdef NucPoint
   properties   
      Position; %x,y position
      mass;
      
      %velocity components;
      unit_vector = 0;
      speed = 0;
      force = [0,0];
      
      ParentCell;
      
      NN_One; %NN = Nucleus Neighbor
      NN_Two;
      
      ONN_One; %ONN = Opposing Nucleus Neighbor
      ONN_Two 
      
      MN; %MN = Membrane Neighbor
   end
   methods
      function obj = NucPoint(x_point, y_point)
        if nargin == 2
            if isnumeric(x_point) && isnumeric(y_point)
                obj.Position = [x_point y_point];
            else
                error('NucPoint Class Constructor Parameters Must Be Numeric')
            end
        else
            error('Invalid Number of Inputs to NucPoint Class Constructor')
        end
      end
      
      calc_inner(obj, K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, enviro_pressure)
      
   end
end