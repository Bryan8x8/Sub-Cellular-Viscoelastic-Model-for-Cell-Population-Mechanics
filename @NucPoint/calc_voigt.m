function [voigt_val, voigt_val_opp] = calc_voigt(point_One, point_Two, mu, k, l)

    %{
        voigt_val will become a force vector in the form [x,y];
    %}
    %R_diff is scalar, multiple should be vector
    pos_one = point_One.Position;
    pos_two = point_Two.Position;
    R_abs = ((pos_one(1,2) - pos_two(1,2))^2 + (pos_one(1,1)- pos_two(1,1))^2)^(1/2);
    R_diff = pos_one - pos_two;
    V_diff = (point_One.velocity)-(point_Two.velocity);
    voigt_val = (-1)*(k*((R_abs - l)/(R_abs))*R_diff + mu*V_diff);
    voigt_val_opp = voigt_val * (1);
end

%{
    This function takes two points, and calculated the force point_Two
    exerts on point_One

    Inputs: 

        point_One: either a Mem or Nuc point

        point_Two: either a Mem or Nuc point

        mu: dampening constant
    
        k: spring constant

        l: spring rest length

        N and Row were simply for testing purposes and can be ignored.

    Outputs:

        voigt_val: force vector exerted on point_One to point_Two

        voigt_val_opp: force vector that is equivalent in magnitude to
                        voigt_val but opposite in direction
%}