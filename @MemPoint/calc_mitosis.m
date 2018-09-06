function calc_mitosis(obj, K_cyst, B_cyst, mitosis_mem_l)
    N = obj.ParentCell.NodeCount;
    [voigt_val, voigt_val_opp] = calc_voigt(obj, obj.NN,B_cyst, K_cyst, mitosis_mem_l, 1, 1);
    obj.force = obj.force + voigt_val;
end