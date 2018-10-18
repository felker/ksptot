function lvd_processData(handles)
    %lvd_processData Summary of this function goes here
    %   Detailed explanation goes here
    lvdData = getappdata(handles.ma_LvdMainGUI,'lvdData');
    celBodyData = lvdData.celBodyData;
    
    maStateLog = lvdData.stateLog.getMAFormattedStateLogMatrix();
    
    %%%%%%%%%%
    % Redraw plots
    %%%%%%%%%%
    set(handles.plotWorkingLbl,'Visible','on');
    drawnow;
    [az,el] = view(handles.dispAxes);
    lvd_updateDispAxis(handles, maStateLog, get(handles.dispAxes,'UserData'), lvdData);
    view(handles.dispAxes, [az,el]);
    set(handles.plotWorkingLbl,'Visible','off');
    drawnow;
    
    %%%%%%%%%%
    % Update script listbox
    %%%%%%%%%%    
    evtListboxStr = lvdData.script.getListboxStr();
    set(handles.scriptListbox,'String',evtListboxStr);
    
    scriptListVal = get(handles.scriptListbox,'Value');
    if(scriptListVal <= 0)
        set(handles.scriptListbox,'Value',1);
    elseif(scriptListVal > length(get(handles.scriptListbox,'String')))
        set(handles.scriptListbox,'Value',length(get(handles.scriptListbox,'String')));
    end
    drawnow;
    
    %%%%%%%%%%
    % Update State Readouts
    %%%%%%%%%%
    propNames = {'Fuel/Ox', 'Monoprop', 'Xenon'};
    ma_UpdateStateReadout(handles.initialStateReadoutLabel, 'initial', propNames, maStateLog, celBodyData);
    ma_UpdateStateReadout(handles.finalStateReadoutLabel, 'final', propNames, maStateLog, celBodyData);
    drawnow;
end
