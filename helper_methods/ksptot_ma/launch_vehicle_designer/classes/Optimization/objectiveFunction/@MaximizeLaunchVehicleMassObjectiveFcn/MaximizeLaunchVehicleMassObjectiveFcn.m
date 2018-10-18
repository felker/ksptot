classdef MaximizeLaunchVehicleMassObjectiveFcn < AbstractObjectiveFcn
    %AbstractObjectiveFcn Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        event(1,:) LaunchVehicleEvent 
        
        lvdOptim LvdOptimization
        lvdData LvdData
    end
    
    methods
        function obj = MaximizeLaunchVehicleMassObjectiveFcn(event, lvdOptim, lvdData)
            obj.event = event;
            obj.lvdOptim = lvdOptim;
            obj.lvdData = lvdData;
        end
        
        function [f, stateLog] = evalObjFcn(obj, x)            
            obj.lvdOptim.vars.updateObjsWithVarValues(x);
            stateLog = obj.lvdData.script.executeScript();
            
            subStateLog = stateLog.getLastStateLogForEvent(obj.event);
            f = -1*subStateLog.getTotalVehicleMass();
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
        
        function tf = usesEvent(obj, event)
            tf = obj.event == event;
        end
        
        function event = getRefEvent(obj)
            event = obj.event;
        end
    end
    
    methods(Static)
        function objFcn = getDefaultObjFcn(event, lvdOptim, lvdData)
            objFcn = MaximizeLaunchVehicleMassObjectiveFcn(event, lvdOptim, lvdData);
        end
        
        function params = getParams()
            params = struct();
            
            params.usesEvents = true;
        end
    end
end