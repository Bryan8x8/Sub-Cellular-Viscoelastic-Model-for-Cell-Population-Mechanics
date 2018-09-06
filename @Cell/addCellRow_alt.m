function addCellRow_alt(obj,rowNum, mPoint, nPoint)
    %{
        Adds a row to each Nucleus and Membrane Points list on a given
        cell, and in each added row it includes the given membrane node and
        nuclus node at the given location on the lists.
    %}
    if rowNum == obj.NodeCount
            tempArrayNuc = obj.NucleusPoints;
            tempArrayMem = obj.MembranePoints;
            
            tempRendArrayNuc = obj.NucleusRender;
            tempRendArrayMem = obj.MembraneRender;
            
            addNucRow = cell(1,1);
            addMemRow = cell(1,1);
            
            addNucRow{1,1} = nPoint;
            addMemRow{1,1} = mPoint; 
            
            %adding to the point lists
            obj.NucleusPoints = [tempArrayNuc ; addNucRow];
            obj.MembranePoints = [tempArrayMem ; addMemRow];           
            
            obj.NucleusRender = [tempRendArrayNuc ; zeros(1,1,5)];
            obj.MembraneRender = [tempRendArrayMem ; zeros(1,1,2)];
            
         else
             tempArrayNuc1 = obj.NucleusPoints(1:rowNum, 1);
             tempArrayNuc2 = obj.NucleusPoints(rowNum+1:end, 1);
             tempArrayMem1 = obj.MembranePoints(1:rowNum, 1);
             tempArrayMem2 = obj.MembranePoints(rowNum+1:end, 1);
             
             tempRendArrayNuc1 = obj.NucleusRender(1:rowNum, 1,:);
             tempRendArrayNuc2 = obj.NucleusRender(rowNum+1:end, 1,:);
             tempRendArrayMem1 = obj.MembraneRender(1:rowNum, 1,:);
             tempRendArrayMem2 = obj.MembraneRender(rowNum+1:end, 1,:);
             
             addNucRow = cell(1,1);
             addMemRow = cell(1,1);
             
             addNucRow{1,1} = nPoint;
             addMemRow{1,1} = mPoint;
             obj.NucleusPoints = [tempArrayNuc1 ; addNucRow ; tempArrayNuc2];
             obj.MembranePoints = [tempArrayMem1 ; addMemRow; tempArrayMem2];
             
             obj.NucleusRender = [tempRendArrayNuc1 ; zeros(1,1,5) ; tempRendArrayNuc2];
             obj.MembraneRender = [tempRendArrayMem1 ; zeros(1,1,2) ; tempRendArrayMem2];
             
    end
end

%{
This is used exclusively for cell growth, it adds a single Nucleus and
Membrane point to their respective lists in a random position.
setConnections should always follow immediately after this function.
%}