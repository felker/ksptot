classdef LaunchVehicleState < matlab.mixin.SetGet
    %LaunchVehicleState Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lv(1,1) LaunchVehicle = LaunchVehicle(LvdData.getEmptyLvdData())
        e2TConns(1,:) EngineToTankConnState
    end
    
    methods
        function obj = LaunchVehicleState(lv)
            obj.lv = lv;
        end
        
        function tanks = getTanksConnectedToEngine(obj, engine)
            connStates = obj.e2TConns([obj.e2TConns.active] == true);
            connections = [connStates.conn];
            connections = connections([connections.engine] == engine);
            
            tanks = [connections.tank];
        end
        
        function newLvState = deepCopy(obj)
            newLvState = LaunchVehicleState(obj.lv);
            
            for(i=1:length(obj.e2TConns)) %#ok<NO4LP>
                newLvState.e2TConns(end+1) = obj.e2TConns(i).deepCopy();
            end
        end
    end
end