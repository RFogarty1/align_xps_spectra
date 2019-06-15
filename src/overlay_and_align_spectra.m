function [outArg] = overlay_and_align_spectra(refSpectrum, otherData, varargin)


inpArgs = parseInput(refSpectrum,otherData,varargin);

smoothedRefSpectrum = getSmoothedSpectrum(refSpectrum, inpArgs.smoothno, inpArgs.smoothStep);

%Get shift vals + norm [TODO: Refactor all this into local function]
cutExpSpectrum = get_array_vals_between_ranges(smoothedRefSpectrum, inpArgs.rangeXRef);
cutOtherSpectra  = cell( size(otherData,1), size(otherData,2) );
for i=1:size(cutOtherSpectra,2)
    cutOtherSpectra{1,i} = get_array_vals_between_ranges(otherData{1,i},inpArgs.rangeXOther);
end
shiftsNeeded = align_and_norm_to_ref(cutExpSpectrum,cutOtherSpectra);

%Apply the shifts to get output spectra[TODO: Extract method]
shiftedOthers = cell( size(otherData,1), size(otherData,2) );
onlyNormdOthers = cell( size(otherData,1), size(otherData,2) );
 xShifts = shiftsNeeded('allshifts');
normShifts = shiftsNeeded('allnorm');
for i=1:size(otherData,2)
    shiftedOthers{1,i} = zeros( size(otherData{1,i},1), size(otherData{1,i},2) );
    shiftedOthers{1,i}(:,1) = otherData{1,i}(:,1) + xShifts(i);
    shiftedOthers{1,i}(:,2) = otherData{1,i}(:,2) * normShifts(i);
    
     onlyNormdOthers{1,i}(:,1) = otherData{1,i}(:,1) ;
    onlyNormdOthers{1,i}(:,2) = otherData{1,i}(:,2) * normShifts(i);
end

%Create output object
outArg = OverlayAlignOutput('smoothno',inpArgs.smoothno,'refData',inpArgs.refData,...
                                                                       'smoothedRef', smoothedRefSpectrum, 'unshiftedOthers', onlyNormdOthers,...
                                                                       'shiftedOthers', shiftedOthers, 'shiftVals',xShifts, 'normVals', normShifts);

end


function [inpArgs] = parseInput(refData,otherData,varargin)

p = inputParser;
addRequired(p,'refData');
addRequired(p,'otherData');
addParameter(p,'smoothno',0.999999);
addParameter(p,'rangeXRef',[-inf,inf]);
addParameter(p,'rangeXOther',[-inf,inf]);
addParameter(p,'smoothStep',0.01);

if size(varargin{:},1) == 0
    p.parse(refData,otherData);
else
    p.parse(refData,otherData,varargin{:}{:});
end
inpArgs = p.Results;

end


function [smoothedSpec] = getSmoothedSpectrum(inpSpectrum, smoothNo, smoothStep)

[xData, yData] = prepareCurveData( inpSpectrum(:,1), inpSpectrum(:,2) );
ft = fittype( 'smoothingspline' );
opts = fitoptions( ft );
opts.SmoothingParam = smoothNo;
opts.Normalize='on';
[fitresult, gof] = fit( xData, yData, ft, opts );

xFit=min(inpSpectrum(:,1)):smoothStep:max(inpSpectrum(:,1));
yFit=feval(fitresult,xFit);

smoothedSpec = [xFit', yFit];

end