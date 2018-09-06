function apply_cell_force(obj, time_dilation)
    %this function is run once the force force calculator is run on all
    %cells
    
    %Time dilation states the amount of time the calculated force in
    %applied to a node until the force is re updated.
    
    for i=1:obj.NodeCount
       
       m_point = obj.MembranePoints{i,1};
       n_point = obj.NucleusPoints{i,1}; 
       
       %we know F = ma
       %lets find the acceleration of each point 
       
       m_accel = m_point.force./m_point.mass;
       n_accel = n_point.force./n_point.mass;
       
       m_initVel = m_point.velocity;
       n_initVel = n_point.velocity;
       
       %s = vi*t + .5*a*t^2
       %remember we accel and vel are vector values 
       m_disp = m_initVel*time_dilation + .5*m_accel*(time_dilation^2); 
       n_disp = n_initVel*time_dilation + .5*n_accel*(time_dilation^2);
       
       %dist values are displacement values that are added to the node
       %positionse
       %OPos = obj.MembranePoints{i,1}.Position;
       %m_disp;
       obj.MembranePoints{i,1}.Position = obj.MembranePoints{i,1}.Position + m_disp;
       %APos = obj.MembranePoints{i,1}.Position;
       obj.NucleusPoints{i,1}.Position = obj.NucleusPoints{i,1}.Position + n_disp;  
       
       %update node speed and unit vector
       % t = (vf - vi)/a
       %vf = vi + t*a
       m_fVel = m_initVel + time_dilation*m_accel;
       n_fVel = n_initVel + time_dilation*n_accel;
       obj.MembranePoints{i,1}.velocity = m_fVel;
       obj.NucleusPoints{i,1}.velocity = n_fVel;

       
       %we have ended the application of force, we will now reset the force
       %on each node
       
       obj.MembranePoints{i,1}.force = [0,0];
       obj.NucleusPoints{i,1}.force = [0,0];
       
    end

end

%{
    This is a Cell function.

    The purpose of this function is to read the force value written into
    all the children nodes of the cell calling this function and applying
    that force to each node over a predetermined amount of time. It will
    adjust each node's position and velocity vectors.

    Inputs:

        time_dilation: determines how long the force will be applied to the
                        cell until another force calculation cycle is necessary.

                        Important: a lower time_dilation will allow for
                        more accurate results but higher run times, while a
                        high time_dilation will result in the opposite

    Outputs:

        None.


%}