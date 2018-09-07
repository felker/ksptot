classdef LaunchVehicleTankState < matlab.mixin.SetGet
    %LaunchVehicle Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tank(1,1) LaunchVehicleTank
        
        tankMass(1,1) double = 0; %mT
    end
    
    methods
        function obj = LaunchVehicleTankState()
            
        end
        
        function tankMass = getTankMass(obj)
            tankMass = obj.tankMass;
        end
    end
end