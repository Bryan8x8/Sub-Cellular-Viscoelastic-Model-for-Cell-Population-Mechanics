function recalc_springs(obj, command)

    N = obj.NodeCount;

    if command == "inc"
    mult = (N+1)/(N); %this is set as such because N is incremented eariler
    
    elseif command == "dec"
    mult = (N)/(N+1);
            
    end
    
    obj.cellMem_l = mult*obj.cellMem_l;
    obj.nucMem_l = mult*obj.nucMem_l;
    obj.cyt_l = mult*obj.cyt_l;
    obj.nucOpp_l = mult*obj.nucOpp_l;
    
end