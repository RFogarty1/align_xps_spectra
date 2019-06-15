

function tests = test_align_and_norm_to_ref
    tests = functiontests(localfunctions);    
end




function test_opt_arg_quick(testCase)
    x=5;
    functHandles = align_and_norm_to_ref(1,1,'utest',1);
    currFunct = functHandles('testA');
    actVal = currFunct();
    verifyEqual(testCase,x,actVal);

end

function test_get_shifts_align_all_2sets(testCase)
    functHandles = align_and_norm_to_ref(1,1,'utest',1);
    testFunct = functHandles('alignMultiToRef');
    [refData, otherData] = loadRefOtherData_twoSet_a();
    expShifts = [3.0,-3.0];
    actShifts = testFunct(refData,otherData);
    verifyEqual(testCase,actShifts,expShifts);
end

function test_get_norm_data_2sets(testCase)
    functHandles = align_and_norm_to_ref(1,1,'utest',1);
    testFunct = functHandles('normMultiToRef');
    [refData, otherData]  = loadRefOtherData_twoSet_a();
    expFactors = [10, 5/0.4]
    actFactors = testFunct(refData,otherData);
    verifyEqual(testCase, actFactors, expFactors);
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

