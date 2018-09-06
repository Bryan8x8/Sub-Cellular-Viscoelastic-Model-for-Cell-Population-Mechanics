C = Cell(15, 5, 5,  1.0e-6, 5.0e-6);
%render(C);

%render(C);
%pause(1);
%C.recalc_springs("dec");
%C.recalc_springs("dec");    
%render(C);
render(C);
drawnow;
C.calc_vol();
for i=1:2000
    if mod(i,25) == 0
        fprintf('\n Iteration: %f \n' , i);
        render(C);
        drawnow;
    end 
    C.check_vol();
    C.calc_cell_force();
    C.apply_cell_force(.25);
    C.calc_vol();
end
render(C);

%{
    For now the membrane sections that are mean to be pushed towards the
    center of the cell are connected to the nucleus by red lines.
%}




