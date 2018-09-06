function calc_mitosis(obj, K_ncyst, B_ncyst, mitosis_nuc_l)
    [voigt_val, voigt_val_opp] = calc_voigt(obj, obj.ONN_One,B_ncyst, K_ncyst, mitosis_nuc_l);
    voigt_mag = ((voigt_val(1,1)^2) + (voigt_val(1,2)^2))^(1/2);
    if obj.Mitosis_Group == 1
        mitosis_force = voigt_mag * obj.ParentCell.mitosis_nuc_force_vector;
        
    else
        mitosis_force = (-1)*(voigt_mag * obj.ParentCell.mitosis_nuc_force_vector);
    end
    %voigt_mag
    %obj.ParentCell.mitosis_nuc_force_vector
    %mitosis_force
    obj.force = obj.force + mitosis_force; 
end