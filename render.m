function render(Cell)
    
    for i=1:Cell.NodeCount
        
        %Drawing From Nucleus outwards.
        curPoint = Cell.NucleusPoints{i,1};
        mainPoint = curPoint.Position;
        ONNPoint1 = curPoint.ONN_One.Position;
        ONNPoint2 = curPoint.ONN_Two.Position;
        NNPoint1 = curPoint.NN_One.Position;
        NNPoint2 = curPoint.NN_Two.Position;
        MNPoint = curPoint.MN.Position;
        %Rendering connections in between opposing nucleus points it's
        %unecessary but can be implement if required by uncommenting the
        %following two lines of code.
        if Cell.NucleusRender(i,1,1) ~= 0
            delete(Cell.NucleusRender(i,1,1));
        end
        Cell.NucleusRender(i,1,1) = line([mainPoint(1,1), ONNPoint1(1,1)], [mainPoint(1,2), ONNPoint1(1,2)], 'Color', 'magenta');
        
        if Cell.NucleusRender(i,1,2) ~= 0
            delete(Cell.NucleusRender(i,1,2));
        end
        Cell.NucleusRender(i,1,2) = line([mainPoint(1,1), ONNPoint2(1,1)], [mainPoint(1,2), ONNPoint2(1,2)], 'Color', 'magenta');
        
        if Cell.NucleusRender(i,1,3) ~= 0
            delete(Cell.NucleusRender(i,1,3));
        end
        Cell.NucleusRender(i,1,3) = line([mainPoint(1,1), NNPoint1(1,1)], [mainPoint(1,2), NNPoint1(1,2)], 'Color', 'magenta');
        
        if Cell.NucleusRender(i,1,4) ~= 0
            delete(Cell.NucleusRender(i,1,4));
        end
        Cell.NucleusRender(i,1,4) = line([mainPoint(1,1), NNPoint2(1,1)], [mainPoint(1,2), NNPoint2(1,2)], 'Color', 'magenta');
        
        if curPoint.MN.Mitosis_Group == 0
            if Cell.NucleusRender(i,1,5) ~= 0
            delete(Cell.NucleusRender(i,1,5));
            end
            Cell.NucleusRender(i,1,5) = line([mainPoint(1,1), MNPoint(1,1)], [mainPoint(1,2), MNPoint(1,2)], 'Color', 'cyan');
        else 
            if Cell.NucleusRender(i,1,5) ~= 0
            delete(Cell.NucleusRender(i,1,5));
            end
            Cell.NucleusRender(i,1,5) = line([mainPoint(1,1), MNPoint(1,1)], [mainPoint(1,2), MNPoint(1,2)], 'Color', 'red');
        end
        
        %Drawing Membrane
        curPoint = Cell.MembranePoints{i,1};
        mainPoint = curPoint.Position;
        MNPoint1 = curPoint.MN_One.Position;
        MNPoint2 = curPoint.MN_Two.Position;
        if Cell.MembraneRender(i,1,1) ~= 0
            delete(Cell.MembraneRender(i,1,1));
        end
        Cell.MembraneRender(i,1,1) = line([mainPoint(1,1), MNPoint1(1,1)], [mainPoint(1,2), MNPoint1(1,2)], 'Color', 'blue');
        
        if Cell.MembraneRender(i,1,2) ~= 0
            delete(Cell.MembraneRender(i,1,2));
        end
        Cell.MembraneRender(i,1,2) = line([mainPoint(1,1), MNPoint2(1,1)], [mainPoint(1,2), MNPoint2(1,2)], 'Color', 'blue');
        hold
    end

%line([5,1],[5,4],'Color','green');
%hold;
end

%{
    This function takes a single cell and iterates through all it's child
    points and created lines between the points and their listed neighbors

    Inputs:

        Cell: the Cell you want to render on the screen

    Outputs:

        None.

    Important: each lines creates it's own object, and each line object
    must be stored within it's respective cell so that it may be deleted
    before performing a second rednering of the cell. This has yet to be
    implemented but should take no longer than 5 min to add once necessary.
%}