C = Cell(15, 5, 5,  1.0e-6, 5.0e-6);
%render(C);

%render(C);
%pause(1);
%C.recalc_springs("dec");
%C.recalc_springs("dec");    
%render(C);
C.calc_vol();
for i=1:500
    fprintf('\n Iteration: %f \n' , i);
    C.check_vol();
    C.calc_cell_force();
    C.apply_cell_force(.25);
    C.calc_vol();
    if mod(i,250) == 0
      % render(C); 
    end
end
render(C);




