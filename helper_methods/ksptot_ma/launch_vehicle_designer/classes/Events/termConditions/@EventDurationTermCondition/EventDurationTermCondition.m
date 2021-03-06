classdef EventDurationTermCondition < AbstractEventTerminationCondition
    %EventDurationTermCondition Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        t0(1,1) double = 0;
        duration(1,1) double = 0;
    end
    
    methods
        function obj = EventDurationTermCondition(duration)
            obj.duration = duration;
        end
        
        function evtTermCondFcnHndl = getEventTermCondFuncHandle(obj)
            evtTermCondFcnHndl = @(t,y) obj.eventTermCond(t,y, obj.t0, obj.duration);
        end
        
        function initTermCondition(obj, initialStateLogEntry)
            obj.t0 = initialStateLogEntry.time;
        end
        
        function name = getName(obj)
            name = sprintf('Event Duration (%.3f sec)', obj.duration);
        end
        
        function tf = shouldBeReinitOnRestart(obj)
            tf = false;
        end
        
        function params = getTermCondUiStruct(obj)
            params = struct();
            
            params.paramName = 'Event Duration';
            params.paramUnit = 'sec';
            params.useParam = 'on';
            params.useStages = 'off';
            params.useTanks = 'off';
            params.useEngines = 'off';
            params.useStopwatches = 'off';
            
            params.value = obj.duration;
            params.refStage = LaunchVehicleStage.empty(1,0);
            params.refTank = LaunchVehicleEngine.empty(1,0);
            params.refEngine = LaunchVehicleEngine.empty(1,0);
            params.refStopwatch = LaunchVehicleStopwatch.empty(1,0);
        end
        
        function optVar = getNewOptVar(obj)
            optVar = EventDurationOptimizationVariable(obj);
        end
        
        function optVar = getExistingOptVar(obj)
            optVar = obj.optVar;
        end
        
        function tf = usesStage(obj, stage)
            tf = false;
        end
        
        function tf = usesEngine(obj, engine)
            tf = false;
        end
        
        function tf = usesTank(obj, tank)
            tf = false;
        end
        
        function tf = usesEngineToTankConn(obj, engineToTank)
            tf = false;
        end
        
        function tf = usesStopwatch(obj, stopwatch)
            tf = false;
        end
    end
    
    methods(Static)
        function termCond = getTermCondForParams(paramValue, stage, tank, engine, stopwatch)
            termCond = EventDurationTermCondition(paramValue);
        end
    end
    
    methods(Static, Access=private)
        function [value,isterminal,direction] = eventTermCond(t,~, t0, duration)
            value = t - (t0+duration);
            isterminal = 1;
            direction = 0;
        end
    end
end