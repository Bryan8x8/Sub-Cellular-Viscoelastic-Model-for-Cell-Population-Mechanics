function recalc_radius(obj,command)
    N = obj.NodeCount;
    
    %determining new circumference lengths, and from those new radius
    %lengths
    if command == "inc"
    circ_mult = (N+1)/(N); %this is set as such because N is incremented eariler
    
    elseif command == "dec"
    circ_mult = (N)/(N+1);
            
    end
    
    mem_circumference = circ_mult*2*(obj.R_Mem)*pi;
    nuc_circumference = circ_mult*2*(obj.R_Nuc)*pi;
    
    obj.R_Mem = (mem_circumference)/(2*pi);
    obj.R_Nuc = (nuc_circumference)/(2*pi);
end