function render(cell)
    
    for i=1:cell.NodeCount
        
        %Drawing From Nucleus outwards.
        curPoint = cell.NucleusPoints{i,1};
        mainPoint = curPoint.Position;
        ONNPoint1 = curPoint.ONN_One.Position;
        ONNPoint2 = curPoint.ONN_Two.Position;
        NNPoint1 = curPoint.NN_One.Position;
        NNPoint2 = curPoint.NN_Two.Position;
        MNPoint = curPoint.MN.Position;
        %Rendering connections in between opposing nucleus points it's
        %unecessary but can be implement if required by uncommenting the
        %following two lines of code.
        %line([mainPoint(1,1), ONNPoint1(1,1)], [mainPoint(1,2), ONNPoint1(1,2)], 'Color', 'magenta');
        %line([mainPoint(1,1), ONNPoint2(1,1)], [mainPoint(1,2), ONNPoint2(1,2)], 'Color', 'magenta');
        line([mainPoint(1,1), NNPoint1(1,1)], [mainPoint(1,2), NNPoint1(1,2)], 'Color', 'magenta');
        line([mainPoint(1,1), NNPoint2(1,1)], [mainPoint(1,2), NNPoint2(1,2)], 'Color', 'red');
        line([mainPoint(1,1), MNPoint(1,1)], [mainPoint(1,2), MNPoint(1,2)], 'Color', 'cyan');
        
        %Drawing Membrane
        curPoint = cell.MembranePoints{i,1};
        mainPoint = curPoint.Position;
        MNPoint1 = curPoint.MN_One.Position;
        MNPoint2 = curPoint.MN_Two.Position;
        line([mainPoint(1,1), MNPoint1(1,1)], [mainPoint(1,2), MNPoint1(1,2)], 'Color', 'blue');
        line([mainPoint(1,1), MNPoint2(1,1)], [mainPoint(1,2), MNPoint2(1,2)], 'Color', 'blue');
        hold
    end

%line([5,1],[5,4],'Color','green');
%hold;
end