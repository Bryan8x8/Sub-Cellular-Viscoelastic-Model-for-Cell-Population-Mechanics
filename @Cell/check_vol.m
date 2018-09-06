function check_vol(obj)
    stop_vol = obj.Rest_Vol * obj.alpha_s;
    grow_vol = obj.Rest_Vol * obj.alpha_g;
    if obj.Volume < (2*obj.Orig_Vol) && obj.Mitosis_Flag == 0
        if obj.Volume < stop_vol
            %do nothing, no new nodes are added
        elseif obj.Volume > grow_vol
            obj.grow_alt();    
        
        end
        
    elseif obj.Volume >= (2*obj.Orig_Vol) && obj.Mitosis_Flag == 0
        
        %if we end up here it means that we have hit the volume required
        %for mitosis growth for the first time in this cell, we now turn on
        %the cell flag and run the mitosis axis function then cease any other 
        %action to be taken by this function on said cell until mitosis is
        %complete and the flag is lowered
        
        obj.Mitosis_Flag = 1;
        obj.find_mitosis_axis();
        
    end
end

%{

    This function checks to see if the volume of the cell that calls it
    falls under the growth or no growth region and determines wheter or not
    to run the growth function to add a new pair of nodes to the cell.

    This function also checks to see if the volume has reached x2 the
    original volume, if so it will flag the cell and stop growth on that
    cell until mitosis is completed.

%}