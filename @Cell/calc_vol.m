function calc_vol(obj)
    N = obj.NodeCount; 
    vol = 0;
    for i=1:N-1
        vol = vol + triangle_area(obj, obj.MembranePoints{i,1}, obj.MembranePoints{i+1});
    end
    vol = vol + triangle_area(obj, obj.MembranePoints{N,1}, obj.MembranePoints{i,1});
    obj.Volume = vol(1,3);
end

%{
    Uses triangle_area(), N amount of times to calculate the size of the
    selected Cell.
}%