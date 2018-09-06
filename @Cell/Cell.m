classdef Cell < handle
   properties   
      Position; %x,y avg center position
      R_Nuc;
      R_Mem;
      NodeCount;
      NucleusPoints;
      MembranePoints;
      NucleusRender;
      MembraneRender;
      Volume;
      Rest_Vol;
      Orig_Vol;
      
      %Mitosis
      Mitosis_Flag = 0;
      Mitosis_Axis;
      mitosis_nuc_force_vector; %this vector provides direction for group one of nuc points undering mitosis
      mitosis_mem_l;
      mitosis_nuc_l;
      mitosis_mem_points; %these are the mem points selected to receive F_con during mitosis
      mitosis_div_axis_points; %this is the direction the nuc points will point towards.
      
      cellMem_l;
      nucMem_l;
      cyt_l;
      nucOpp_l;
      
      
      %For now we are using the default parameters given to cell by the
      %paper provided, these can be edited later by building a constructor
      %that accepts all parameters
            
      %Must learn how to set this properly
      inner_pressure = 0;
      external_pressure = 0;
      
      %PARAMETERS: 
      K_cyst = 4e-18; %Radial Spring Constant, kg/(s^2)
      B_cyst = 1.5e-15; %Damping constsnts for radial springs, kg/s
      K_ncyt = 3e-16; %Nuc spring constants, kg/(s^2)
      B_ncyt = 0; %Damping constants for nucleus springs, kg/s
      K_madh = 4e-17; %Adhesion Spring constants, kg/(s^2)
      B_madh = 0; %Damping constants for adhesion spring, kg/s
      K_mmem = 6.5e-17; %Cell membrane spring constants, kg/(s)^2
      B_mmem = 2e-15; %Damping constants for cell membrane springs
      D_mmem = 13.5e-16; %Drag coefficients at the cell membrane
      K_nmem = 3e-16; %Nucleus membrane spring constants
      B_nmem = 1e-14; %Damping constants for the springs
      D_nmem = 2.5e-15; %Drag coefficients at the nucleus membrane
      N_0; %NUMBER OF INITIAL POINTS SHOULD BE 30
      l_ad = 0; %adhesion spring rest lenghts
      %CELL RADIUS SHOULD BE 5
      %NUC RADIUS SHOULD  BE 1
      M_cell = 1e-12; %Cell mass
      M_nuc = 1e-13; %Nucleus mass
      M_mem;
      alpha_s = .85; %Percent of rest volume where growth ends under this volume
      alpha_g = .95;%Percent of rest volume that growth continues above this volume
      dt = 10 %time step
      T = 300 %Temperature
      
      %for growth testing purposes ownly
      rowNum;
   end
   
   methods
       
      function obj = Cell(N, x_point, y_point, r_nuc, r_mem)
        if nargin == 5
            if isnumeric(N) && isnumeric(x_point) && isnumeric(y_point)
                obj.Position = [x_point y_point];
                obj.NodeCount = N;
                obj.NucleusPoints = cell(N,1);
                obj.MembranePoints = cell(N,1);
                obj.NucleusRender = zeros(N,1,5);
                obj.MembraneRender = zeros(N,1,2);
                obj.R_Nuc = r_nuc;
                obj.R_Mem = r_mem;
                obj.M_mem = obj.M_cell - obj.M_nuc;
                
                obj.populatePoints();
                obj.setConnections();
                obj.set_spring_lengths();
                obj.calc_vol();
                obj.Rest_Vol = obj.Volume;
                obj.Orig_Vol = obj.Volume;
                obj.mitosis_div_axis_points = zeros(1,4);
                
            else
                error('Cell Class Constructor Parameters Must Be Numeric')
            end
        else
            error('Invalid Number of Inputs to Cell Class Constructor')
        end
      end
      
      addCellRow(obj,rowNum)
      grow(obj)
      grow_alt(obj)
      set_spring_lengths(obj)
      recalc_radius(obj, command)
      populatePoints(obj)
      setConnections(obj)
      calc_cell_force(obj)
      apply_cell_force(obj,time_dilation)
      recalc_springs(obj, command)
      calc_volume(obj)
      check_vol(obj)
      find_mitosis_axis(obj)
      find_div_axis(obj)
      
 
      end
end