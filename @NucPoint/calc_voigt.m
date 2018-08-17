function voigt_val = calc_voigt(point_One, point_Two, mu, k, l)

    %{
        voigt_val will become a force vector in the form [x,y];
    %}
    R_diff = abs(point_One.Position - point_Two.Position);
    V_diff = (point_One.unit_vector * point_One.speed)-(point_Two.unit_vector * point_Two.speed);
    voigt_val = k*((abs(R_diff) - l)/(abs(R_diff)))*R_diff + mu*V_diff;
    
end

%{
    this function serves to take a single cell as an input and calculate
    the forces produced by it's children nodes.

    this is being done using this method because models may use more than
    one kind of cell therefore this function will be capable of taking any
    cell, taking it's underlying data and appropriately calculate forces
%}