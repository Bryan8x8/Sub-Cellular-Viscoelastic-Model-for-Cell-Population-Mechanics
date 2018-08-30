classdef MemPoint < handle
   properties   
      Position; %x,y position
      mass;
      
      %velocity components;
      velocity = [0,0];
      force = [0,0];
      
      %Mitosis
      axis_flag = 0;
      
      ParentCell;
      
      MN_One; %MN = Membrane Neighbor
      MN_Two;
      NN; %NN = Nucleus Neighbor
   end
   methods
      function obj = MemPoint(x_point, y_point)
        if nargin == 2
            if isnumeric(x_point) && isnumeric(y_point)
                obj.Position = [x_point y_point];
            else
                error('MemPoint Class Constructor Parameters Must Be Numeric')
            end
        else
            error('Invalid Number of Inputs to MemPoint Class Constructor')
        end
      end
      
      calc_inner(obj, K_cyst, K_ncyt, K_mmem, K_nmem, B_cyst, B_ncyt, B_mmem, B_nmem, cellMem_l, nucMem_l, cyt_l, nucOpp_l, inner_pressure, enviro_pressure, N, row)
      
   end
end