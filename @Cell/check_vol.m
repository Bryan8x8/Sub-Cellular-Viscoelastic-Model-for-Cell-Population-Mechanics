function check_vol(obj)
    stop_vol = obj.Rest_Vol * obj.alpha_s;
    grow_vol = obj.Rest_Vol * obj.alpha_g;
    if obj.Volume < (2*obj.Orig_Vol)
        if obj.Volume < stop_vol
            %do nothing, no new nodes are added
        elseif obj.Volume > grow_vol
            obj.grow_alt();    
        
        end
    end
end

%{
    This function checks to see if the volume of the cell that calls it
    falls under the growth or no growth region and determines wheter or not
    to run the growth function to add a new pair of nodes to the cell.

%}