classdef OverlayAlignOutput < handle %Inheriting from handle class allows the methods to modify object properties
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        refData;
        smoothNo;
        smoothedRef;
        unshiftedOthers;
        shiftedOthers;
        shiftVals;
        normVals;
    end
    
    methods
        function obj = OverlayAlignOutput(varargin)
            %UNTITLED2 Construct an instance of this class
            %   Note: all the varargin values SHOULD be set, i just do it
            %   like this so i dont have to pass a long list of args in
            %   order
            
            p = inputParser;
            addParameter(p,'smoothno',0.999999);
            addParameter(p,'refData',[-1,-1]);
            addParameter(p,'smoothedRef',[-1,-1]);
            addParameter(p,'unshiftedOthers',{[-1,-1]});
            addParameter(p,'shiftedOthers',{[-1,1]});
            addParameter(p,'shiftVals',[0.0]);
            addParameter(p,'normVals',[0.0]);
            p.parse(varargin{:});
            inpArgs = p.Results;

            obj. refData = inpArgs.refData;
            obj.smoothNo = inpArgs.smoothno;
            obj.smoothedRef = inpArgs.smoothedRef;
            obj.unshiftedOthers = inpArgs.unshiftedOthers;
            obj.shiftedOthers = inpArgs.shiftedOthers;
            obj.shiftVals = inpArgs.shiftVals;
            obj.normVals = inpArgs.normVals;

        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.refData 
        end
    end
end

