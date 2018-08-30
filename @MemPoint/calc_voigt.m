function [voigt_val, voigt_val_opp] = calc_voigt(point_One, point_Two, mu, k, l, N, row)

    %{
        voigt_val will become a force vector in the form [x,y];
    %}
    % R_diff is there distance between the two points.
    pos_one = point_One.Position;
    pos_two = point_Two.Position;
    R_abs = ((pos_one(1,2) - pos_two(1,2))^2 + (pos_one(1,1)- pos_two(1,1))^2)^(1/2);
    R_diff = pos_one - pos_two;
    V_diff = (point_One.velocity)-(point_Two.velocity);
    voigt_val = k*((R_abs - l)/(R_abs))*R_diff + mu*V_diff;
    voigt_val_opp = voigt_val * (1);
    %{
    if N == row
       pos_one
       pos_two
       R_abs
       R_diff
       l
       spring_force = (-1)*k*((R_abs - l)/(R_abs))*R_diff
       visco_force = (-1)*mu*V_diff
    end
    %}
end

%{
    this function serves to take a single cell as an input and calculate
    the forces produced by it's children nodes.

    this is being done using this method because models may use more than
    one kind of cell therefore this function will be capable of taking any
    cell, taking it's underlying data and appropriately calculate forces
%}