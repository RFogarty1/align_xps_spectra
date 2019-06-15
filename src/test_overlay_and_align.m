function tests = test_overlay_and_align
    tests = functiontests(localfunctions);    
end


function test_overlay_no_xrange_setA(testCase)
    [refData, otherData] = loadRefOtherData_twoSet_a();
    expAlignedOther = loadAlignedRefDataSetA_noXrange();
    functOutput = overlay_and_align_spectra(refData,otherData);
     verifyEqual(testCase,functOutput.shiftedOthers,expAlignedOther,'AbsTol',1e-3);
end

function test_overlap_xrange_setA(testCase)
    [refData, otherData] = loadRefOtherData_twoSet_a();
    expAlignedOther = loadAlignedRefDataSetA_exptXrange()
    xRangeExp = [0,3.0];
    functOutput = overlay_and_align_spectra(refData,otherData,'rangeXRef',xRangeExp);
    verifyEqual(testCase, functOutput.shiftedOthers, expAlignedOther,'AbsTol',1e-3);
end


function [refData,otherData] = loadRefOtherData_twoSet_a()

    allXVals = [0,  1.0,  2.0,  3.0,  4.0,  5.0,  6.0,  7.0,  8.0,  9.0];
    yValsA =   [0,  1.0,  2.0,  3.0,  4.0,  5.0,  4.0,  3.0,  2.0,  1.0];
    yValsB =   [0,  0.1,  0.5,  0.3,  0.2,  0.3,  0.1,  0.1,  0.1,  0.1];
    yValsC =   [0,  0.1,  0.1,  0.2,  0.2,  0.2,  0.1,  0.3,  0.4,  0.0];

    refData = [allXVals' , yValsA'];
    otherDataA = [allXVals', yValsB'];
    otherDataB = [allXVals', yValsC'];
    otherData = {otherDataA,otherDataB};
end


function [alignedOthers] = loadAlignedRefDataSetA_noXrange()

    [startRef,alignedOthers] = loadRefOtherData_twoSet_a();
    expShiftA = 3.0;
    expShiftB = -3.0;
    expNormA = 10;
    expNormB =  5/0.4;

    alignedOthers{1}(:,1) = alignedOthers{1}(:,1)  + expShiftA;
    alignedOthers{2}(:,1) = alignedOthers{2}(:,1) + expShiftB;
    
    alignedOthers{1}(:,2) = alignedOthers{1}(:,2) * expNormA;
    alignedOthers{2}(:,2) = alignedOthers{2}(:,2) * expNormB;
    
end


function [alignedOthers] = loadAlignedRefDataSetA_exptXrange()

    [startRef,alignedOthers] = loadRefOtherData_twoSet_a();
    expShiftA = 1.0;
    expShiftB = -5.0;
    expNormA = 3/0.5;
    expNormB =  3/0.4;

    alignedOthers{1}(:,1) = alignedOthers{1}(:,1)  + expShiftA;
    alignedOthers{2}(:,1) = alignedOthers{2}(:,1) + expShiftB;
    
    alignedOthers{1}(:,2) = alignedOthers{1}(:,2) * expNormA;
    alignedOthers{2}(:,2) = alignedOthers{2}(:,2) * expNormB;


end
