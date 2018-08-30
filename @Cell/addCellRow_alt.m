function addCellRow_alt(obj,rowNum, mPoint, nPoint)
    %{
        Adds a row to each Nucleus and Membrane Points list on a given
        cell, and in each added row it includes the given membrane node and
        nuclus node at the given location on the lists.
    %}
    if rowNum == obj.NodeCount
            tempArrayNuc = obj.NucleusPoints;
            tempArrayMem = obj.MembranePoints;
            
            addNucRow = cell(1,1);
            addMemRow = cell(1,1);
            addNucRow{1,1} = nPoint;
            addMemRow{1,1} = mPoint; 
            
            %adding to the point lists
            obj.NucleusPoints = [tempArrayNuc ; addNucRow];
            obj.MembranePoints = [tempArrayMem ; addMemRow];
            
         else
             tempArrayNuc1 = obj.NucleusPoints(1:rowNum, 1);
             tempArrayNuc2 = obj.NucleusPoints(rowNum+1:end, 1);
             tempArrayMem1 = obj.MembranePoints(1:rowNum, 1);
             tempArrayMem2 = obj.MembranePoints(rowNum+1:end, 1);
             
             addNucRow = cell(1,1);
             addMemRow = cell(1,1);
             addNucRow{1,1} = nPoint;
             addMemRow{1,1} = mPoint;
             
             
             obj.NucleusPoints = [tempArrayNuc1 ; addNucRow ; tempArrayNuc2];
             obj.MembranePoints = [tempArrayMem1 ; addMemRow; tempArrayMem2];
             
    end
end

%{
This is used exclusively for cell growth, therefore it sets the added nuc
and mempoints to their proper MM and NN, it leaves the ONN to the grow
function.
%}