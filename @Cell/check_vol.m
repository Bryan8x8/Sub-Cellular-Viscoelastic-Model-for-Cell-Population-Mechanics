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