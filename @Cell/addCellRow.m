function addCellRow(obj,rowNum)
    if rowNum == obj.NodeCount
            tempArrayNuc = obj.NucleusPoints;
            tempArrayMem = obj.MembranePoints;
            addNucRow = cell(1,1);
            addMemRow = cell(1,1);
            NPoint = NucPoint(1,1);
            MPoint = MemPoint(1,1);
            addNucRow{1,1} = NPoint;
            addMemRow{1,1} = MPoint;                        
            %adding to the point lists
            obj.NucleusPoints = [tempArrayNuc ; addNucRow];
            obj.MembranePoints = [tempArrayMem ; addMemRow];
            %Setting MN and NN connections
            %{
            addNucRow{1,1}.MN = addMemRow{1,1};
            addMemRow{1,1}.NN = addNucRow{1,1};
            addMemRow{1,1}.MN_One = obj.MembranePoints{obj.NodeCount-1,1};
            addMemRow{1,1}.MN_Two = obj.MembranePoints{1,1};
            obj.NucleusPoints = [tempArrayNuc ; addNucRow];
            obj.MembranePoints = [tempArrayMem ; addMemRow];
            %}
         else
             tempArrayNuc1 = obj.NucleusPoints(1:rowNum, 1);
             tempArrayNuc2 = obj.NucleusPoints(rowNum+1:end, 1);
             tempArrayMem1 = obj.MembranePoints(1:rowNum, 1);
             tempArrayMem2 = obj.MembranePoints(rowNum+1:end, 1);
             addNucRow = cell(1,1);
             addMemRow = cell(1,1);
             NPoint = NucPoint(1,1);
             MPoint = MemPoint(1,1);
             addNucRow{1,1} = NPoint;
             addMemRow{1,1} = MPoint;
             
             %Setting MN and NN connections
             addNucRow{1,1}.MN = addMemRow{1,1};
             addMemRow{1,1}.NN = addNucRow{1,1};
             addMemRow{1,1}.MN_One = obj.MembranePoints{obj.NodeCount-1,1};
             addMemRow{1,1}.MN_Two = obj.MembranePoints{1,1};
             obj.NucleusPoints = [tempArrayNuc1 ; addNucRow ; tempArrayNuc2];
             obj.MembranePoints = [tempArrayMem1 ; addMemRow; tempArrayMem2];
    end
end

%{
This is used exclusively for cell growth, therefore it sets the added nuc
and mempoints to their proper MM and NN, it leaves the ONN to the grow
function.
%}