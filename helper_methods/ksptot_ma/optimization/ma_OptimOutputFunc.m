function [stop,options,optchanged] = ma_OptimOutputFunc(x, optimValues, state, handles, problem, celBodyData, recorder, propNames, writeOutput, varLabels, lbUsAll, ubUsAll)
    if(isstruct(x)) %covers for patternsearch, need to map fmincon output function inputs to patternsearch ones
        options = optimValues;
        optchanged = false;
        
        optimValues = x;
        x = optimValues.x;
    else
        options = [];
        optchanged = [];
    end

    stop = false;
    switch state
        case 'iter'
            stop = get(handles.cancelButton,'Value');
            
            recorder.iterNums(end+1) = optimValues.iteration;
            recorder.xVals(end+1) = {x};
            recorder.fVals(end+1) = optimValues.fval;            
            recorder.maxCVal(end+1) = getMaxConstraintViolation(optimValues);
        case 'interrupt'
            stop = get(handles.cancelButton,'Value');
    end
    
    if(stop == true)
        return;
    end
    
    [~, stateLog] = problem.objective(x);

    if(isa(stateLog,'LaunchVehicleStateLog'))
        stateLog = stateLog.getMAFormattedStateLogMatrix();
    end
    
    writeOptimStatus(handles, optimValues, state, writeOutput);
    writeFinalState(handles, stateLog, celBodyData, propNames);
    generatePlots(x, optimValues, state, handles, problem.lb, problem.ub, varLabels, lbUsAll, ubUsAll);
    drawnow;
end


function writeOptimStatus(handles, optimValues, state, writeOutput)
    persistent timer;
    
    elapTime = 0;
    switch state
        case 'iter'
            elapTime = toc(timer);
        case 'interrupt'
            elapTime = toc(timer);
        case 'init'
            timer = tic;
            elapTime = 0;
            
            hdrStr = sprintf('%- 13s%- 13s%- 13s%- 13s%- 13s%- 13s', 'Iteration','Fcn-Count','f(x)-Value', 'Feasibility', 'Optimality', 'Norm. Step');
            writeOutput(hdrStr,'append');
    end
    
    outStr = {};
    outStr{end+1} = ['State                = ', state];
    outStr{end+1} = '                        ';
    outStr{end+1} = ['Iterations           = ', num2str(optimValues.iteration)];
    outStr{end+1} = ['Function Evals       = ', num2str(optimValues.funccount)];
    outStr{end+1} = ['Objective Value      = ', num2str(optimValues.fval)];
    outStr{end+1} = ['Constraint Violation = ', num2str(getMaxConstraintViolation(optimValues))];
    outStr{end+1} = ['Optimality           = ', getOptimalityStr(optimValues)];
    outStr{end+1} = ['Step Size            = ', getStepSizeStr(optimValues)];
    outStr{end+1} = ['                       '];
    outStr{end+1} = ['Elapsed Time         = ', num2str(elapTime), ' sec'];
    
    if(strcmpi(state,'iter') || strcmpi(state,'interrupt'))
        formatstr = ' %- 12.1i %- 12.0i %- 12.6g %- 12.3g %- 12.3g %- 12.3g';

        iter = optimValues.iteration;
        fcnt = optimValues.funccount;
        val  = optimValues.fval;
        feas = getMaxConstraintViolation(optimValues);
        optm = str2double(getOptimalityStr(optimValues));
        step = str2double(getStepSizeStr(optimValues));

        hRow = sprintf(formatstr,iter,fcnt,val,feas,optm,step);
        writeOutput(hRow,'append');
    end
    
    set(handles.optimStatusLabel, 'String', outStr);
end

function writeFinalState(handles, stateLog, celBodyData, propNames)
    whichState = 'final';
    hStateReadoutLabel = handles.finalStateOptimLabel;
    ma_UpdateStateReadout(hStateReadoutLabel, whichState, propNames, stateLog, celBodyData);
end
    
function generatePlots(x, optimValues, state, handles, lb, ub, varLabels, lbUsAll, ubUsAll)
    persistent fValPlotIsLog
    
    if(isempty(fValPlotIsLog))
        fValPlotIsLog = true;
    end
    
    switch state
        case 'init'
            set(handles.dispAxes,'Visible','on');
            subplot(handles.dispAxes);
            fValPlotIsLog = true;
    end
    
    set(groot,'CurrentFigure',handles.ma_ObserveOptimGUI);
    
    subplot(3,1,1);
    optimplotxKsptot(x, optimValues, state, lb, ub, varLabels, lbUsAll, ubUsAll);
    
    h=subplot(3,1,2);
    if(optimValues.fval<=0)
        fValPlotIsLog = false;
        set(h,'yscale','linear');
    end
    if(not(isfield(optimValues,'meshsize')))
        optimplotfval(x, optimValues, state);
    else
        psplotbestf(optimValues, state);
    end
    if(fValPlotIsLog)
        set(h,'yscale','log');
    else
        set(h,'yscale','linear');
    end
    grid on;
    grid minor;
    
    subplot(3,1,3);
    if(isfield(optimValues,'constrviolation'))
        optimplotconstrviolation(x, optimValues, state);
    elseif(isfield(optimValues,'nonlinineq') || isfield(optimValues,'nonlineq'))
        psplotmaxconstr(optimValues, state);
    end
    
    grid on;
    grid minor;
end

function maxConstr = getMaxConstraintViolation(optimValues)
    if(isfield(optimValues,'constrviolation'))
        maxConstr = optimValues.constrviolation;   
    elseif(isfield(optimValues,'nonlinineq') || isfield(optimValues,'nonlineq'))
        maxConstr = 0;
        if(isfield(optimValues,'nonlinineq'))
            maxConstr = max([maxConstr;optimValues.nonlinineq(:)]);
        end

        if(isfield(optimValues,'nonlineq'))
            maxConstr = max([maxConstr;optimValues.nonlinineq(:)]);
        end
    else
        maxConstr = 0;
    end
end

function optStr = getOptimalityStr(optimValues)
    if(isfield(optimValues,'firstorderopt'))
        optStr = num2str(optimValues.firstorderopt,5);
    elseif(isfield(optimValues,'TolX'))
        optStr = num2str(optimValues.TolX);
    end
end

function stepSizeStr = getStepSizeStr(optimValues)
    if(isfield(optimValues,'stepsize'))
        stepSizeStr = num2str(optimValues.stepsize);
    elseif(isfield(optimValues,'meshsize'))
        stepSizeStr = num2str(optimValues.meshsize);
    else
        stepSizeStr = 'N/A';
    end
end