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
       m_point.force;
       m_point.mass;
       m_accel = m_point.force./m_point.mass;
       n_accel = n_point.force./n_point.mass;
       
       m_initVel = m_point.speed * m_point.unit_vector;
       n_initVel = n_point.speed * n_point.unit_vector;
       
       %s = vi*t + .5*a*t^2
       %remember we accel and vel are vector values 
       m_dist = m_initVel*time_dilation + .5*m_accel*(time_dilation)^2; 
       n_dist = n_initVel*time_dilation + .5*n_accel*(time_dilation)^2;
       
       %dist values are displacement values that are added to the node
       %positions
       m_point.Position = m_point.Position + m_dist;
       n_point.Position = n_point.Position + n_dist;
       
    end

end