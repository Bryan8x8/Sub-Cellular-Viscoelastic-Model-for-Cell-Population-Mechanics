function grow(obj)
    obj.NodeCount = obj.NodeCount + 1;
    N = obj.NodeCount;
    
    %determining new circumference lengths, and from those new radius
    %lengths
    circ_mult = (N)\(N-1); %this is set as such because N is incremented eariler
    mem_circumference = circ_mult*2*(obj.R_Mem)*pi;
    nuc_circumference = circ_mult*2*(obj.R_Nuc)*pi;
    
    obj.R_Mem = (mem_circumference)/(2*pi);
    obj.R_Nuc = (nuc_circumference)/(2*pi);
    
    radDist = (2*pi)/N;
    connectDist = floor(N/3);
    nuc_points = zeros(N,2);
    rad = 0;
    
    %adding cell row   
    obj.addCellRow(randi([1,N],1));
    obj.populatePoints();
    obj.setConnections();
end