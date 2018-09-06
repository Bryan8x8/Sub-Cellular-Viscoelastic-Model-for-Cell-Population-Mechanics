function rotated_vector = rotate_vec(init_vec, degree)
    %assumes vector origin is 0,0
    %first we must determine what quadrant the vector lies in. 
    input_deg = degree * (90/pi); % converting degree to radians
    init_deg = 0;
    
    if init_vec(1,1) > 0 && init_vec(1,2) > 0 %q1
        init_deg = tan(init_vec);
    elseif init_vec(1,1) < 0 && init_vec(1,2) > 0 %q2
        init_deg = tan(init_vec) + (pi/2);
    elseif init_vec(1,1) < 0 && init_vec(1,2) < 0 %q3
        init_deg = tan(init_vec) + pi;
    elseif init_vec(1,1) > 0 && init_vec(1,2) < 0 %q4
        init_deg = tan(init_vec) + ((3*pi)/2);
    end
    
    final_deg = init_deg + input_deg;
    
    x_pos = init_vec(1,1) * cos(final_deg);
    y_pos = init_vec(1,2) * sin(final_deg);
    
    rotated_vector = [x_pos y_pos];
    
    
end