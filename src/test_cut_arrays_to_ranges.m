function  tests = test_cut_arrays_to_ranges()
    tests = functiontests(localfunctions);    
end



function testCutDataSetA(testCase)
    inpData = loadDataSetA_input();
    expOutData = loadDataSetA_outputA();
    testXRange = [0.05,0.5];
    actOutData = get_array_vals_between_ranges(inpData, testXRange);
    verifyEqual(testCase, expOutData, actOutData);
end


function [refData] = loadDataSetA_input()
    xVals = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];
    yVals = [1.2, 1.5, 1.7, 1.9, 2.5, 2.1, 1.7, 1.9, 2.2];
    refData = [xVals',yVals'];
end


function [expData] = loadDataSetA_outputA()
    %Ouput between points 0.05 and 0.5
    xVals = [0.1, 0.2, 0.3, 0.4, 0.5];
    yVals = [1.5, 1.7, 1.9, 2.5, 2.1];
    expData = [xVals',yVals'];
end