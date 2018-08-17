function cyto_f_val = calc_cyto_force(input_node, inner_pressure, enviro_pressure)

     neighborOne = input_node.MN_One;
     neighborTwo = input_node.MN_Two;
     dR = abs(input_node.Position - neighborOne.Position) + abs(input_node.Position - neighborTwo.Position);
     cyto_f_val = (inner_pressure - enviro_pressure)*(dR/2);
     
end