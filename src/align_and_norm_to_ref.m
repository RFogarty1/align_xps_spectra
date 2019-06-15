function [outArg] = align_and_norm_to_ref(refData,otherData,varargin)
%UNTITLED2 Summary of this function goes here
%   refData = [x,y] matrix of data
%   otherData = cellArray of [x,y] matrix data


%Step 1 = parse the input arguments + return the helper functions if
%unit-testing
inpArgs = parseInput(refData,otherData,varargin);

 if inpArgs.utest == 1
    outArg = getLocalFunctHandles();
    return
 end

 
 %Step 2 = Get the alignment shift for all in otherData
 allShifts = getShiftsToAlignToRef(refData,otherData);
 allNormFactors = getNormFactorsToAlignToRef(refData,otherData);

 %Step 3 = Put everything in a map so we can return a single arg + extend
 %whenever
outArg = containers.Map();
outArg('allshifts') = allShifts;
outArg('allnorm') = allNormFactors;

end



%For unit-testing
function [allHandles] = getLocalFunctHandles
    allHandles = containers.Map();
    allHandles('testA') = @someTestFunct;
    allHandles('alignMultiToRef') = @getShiftsToAlignToRef;
    allHandles('normMultiToRef') = @getNormFactorsToAlignToRef
end


function [inpArgs] = parseInput(refData,otherData,varargin)

p = inputParser;
addRequired(p,'refData');
addRequired(p,'otherData');
addParameter(p,'utest',7);

if size(varargin{:},1) == 0
    p.parse(refData,otherData);
else
    p.parse(refData,otherData,varargin{:}{:});
end
inpArgs = p.Results;

end


function [outShifts] = getShiftsToAlignToRef(refData, otherData)
    nDataSeries = size(otherData,2);
    outShifts = zeros(1,nDataSeries);
    for i=1:nDataSeries
        outShifts(1,i) = getAlignShiftSinglePair(refData,otherData{1,i});
    end
end

function [outShift] = getAlignShiftSinglePair(refData,otherData)
    %Step 1 - Find the peak of the ref data. If no peaks use max value
    [pks,locs] = findpeaks(refData(:,2), refData(:,1));
    [val,idx] = max(pks);
    xValRef = locs(idx);
    if size(pks,1) == 0
        [val,idx] = max(refData(:,2));
        xValRef = refData(idx,1);
    end
    
    %Step 2 - Find the peak in the otherData
    [pks,locs] = findpeaks(otherData(:,2),otherData(:,1));
    [val,idx] = max(pks);
     xValOther = locs(idx);
     if size(pks,1) == 0
         [val,idx] = max(otherData(:,2));
         xValOther = otherData(idx,1);
     end
     
    outShift = xValRef-xValOther;
end

function [outNorm] = getNormFactorsToAlignToRef(refData,otherData)
    nDataSeries = size(otherData,2);
    outNorm = zeros(1,nDataSeries);
    for i=1:nDataSeries
        outNorm(1,i) = getNormFactorSinglePair(refData,otherData{1,i});
    end
end


function [normFactor] = getNormFactorSinglePair(refData,otherData)
    %Step 1 - Find the peak of the ref data
    [valRef,idx] =max(refData(:,2));
    
    %Step 2 - Find the peak in the otherData
    [valOther,idx] = max(otherData(:,2));
     
    normFactor = valRef / valOther;
end




function [outArg] = someTestFunct()
    outArg = 5 
end
