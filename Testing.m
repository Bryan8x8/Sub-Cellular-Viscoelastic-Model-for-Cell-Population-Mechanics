cell = createSimpleCell(5, 5, 12, 4, .5);
%test = cell.NucleusPoints{1,1};
cell.grow();
render(cell);
