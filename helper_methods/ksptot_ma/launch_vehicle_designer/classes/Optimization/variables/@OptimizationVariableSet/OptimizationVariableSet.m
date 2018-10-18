classdef OptimizationVariableSet < matlab.mixin.SetGet
    %OptimizationVariableSet Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        vars(1,:) AbstractOptimizationVariable
    end
    
    methods
        function obj = OptimizationVariableSet()

        end
        
        function addVariable(obj, newVar)
            obj.vars(end+1) = newVar;
        end
        
        function removeVariable(obj, var)
            obj.vars([obj.vars] == var) = [];
        end
        
        function [x, vars] = getTotalXVector(obj)
            x = [];
            vars = AbstractOptimizationVariable.empty(0,1);
            
            for(i=1:length(obj.vars)) %#ok<*NO4LP>
                vX = obj.vars(i).getXsForVariable();
                x = horzcat(x, vX); %#ok<AGROW>
                
                for(j=1:length(vX))
                    vars(end+1) = obj.vars(i); %#ok<AGROW>
                end
            end
        end
        
        function [LwrBnds, UprBnds] = getTotalBndsVector(obj)
            LwrBnds = [];
            UprBnds = [];
            
            for(i=1:length(obj.vars)) %#ok<*NO4LP>
                [lb, ub]= obj.vars(i).getBndsForVariable();
                LwrBnds = horzcat(LwrBnds, lb); %#ok<AGROW>
                UprBnds = horzcat(UprBnds, ub); %#ok<AGROW>
            end
        end
        
        function typicalX = getTypicalXVector(obj)
            [LwrBnds, UprBnds] = obj.getTotalBndsVector();
            
            typicalX = zeros(size(LwrBnds));
            for(i=1:length(LwrBnds))
                lbO = floor(log10(LwrBnds(i)));
                ubO = floor(log10(UprBnds(i)));
                
                if(lbO > ubO)
                    typicalX(i) = LwrBnds(i);
                else
                    typicalX(i) = UprBnds(i);
                end
            end
            
            typicalX(typicalX<eps) = 1;
        end
        
        function updateObjsWithVarValues(obj, x)
            initInd = 1;
            
            for(i=1:length(obj.vars))
                numVars = obj.vars(i).getNumOfVars();
                
                inds = initInd:initInd+numVars-1;
                subX = x(inds);
                
                if(not(isempty(subX)))
                    obj.vars(i).updateObjWithVarValue(subX);
                    initInd = inds(end) + 1;
                end
            end            
        end
    end
end