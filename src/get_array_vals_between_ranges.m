function [outArray] = get_array_vals_between_ranges(inpArray,xRange)

    %Figure out number of entries
    nOrig = size(inpArray,1);
    nNew = 0;
    for i=1:nOrig
        if (inpArray(i,1) >= xRange(1))  && (inpArray(i,1) <= xRange(2))
            nNew = nNew + 1;
        end
    end
    
    outArray = zeros(nNew,2);
    outCounter = 1;
    for i=1:nOrig
        if (inpArray(i,1) >= xRange(1)) && (inpArray(i,1) <= xRange(2))
            outArray(outCounter,1) = inpArray(i,1);
            outArray(outCounter,2) = inpArray(i,2);
            outCounter = outCounter + 1;
        end
    end

end

