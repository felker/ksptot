function varargout = lvd_EditCompositeObjectiveFunctionGUI(varargin)
% LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI MATLAB code for lvd_EditCompositeObjectiveFunctionGUI.fig
%      LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI, by itself, creates a new LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI or raises the existing
%      singleton*.
%
%      H = LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI returns the handle to a new LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI or the handle to
%      the existing singleton*.
%
%      LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI.M with the given input arguments.
%
%      LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI('Property','Value',...) creates a new LVD_EDITCOMPOSITEOBJECTIVEFUNCTIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lvd_EditCompositeObjectiveFunctionGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lvd_EditCompositeObjectiveFunctionGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lvd_EditCompositeObjectiveFunctionGUI

% Last Modified by GUIDE v2.5 21-Dec-2019 15:48:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lvd_EditCompositeObjectiveFunctionGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @lvd_EditCompositeObjectiveFunctionGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before lvd_EditCompositeObjectiveFunctionGUI is made visible.
function lvd_EditCompositeObjectiveFunctionGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lvd_EditCompositeObjectiveFunctionGUI (see VARARGIN)

    % Choose default command line output for lvd_EditCompositeObjectiveFunctionGUI
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);
    
    lvdData = varargin{1};
    setappdata(hObject,'lvdData',lvdData);

    populateGUI(handles, lvdData);

    % UIWAIT makes lvd_EditCompositeObjectiveFunctionGUI wait for user response (see UIRESUME)
    uiwait(handles.lvd_EditCompositeObjectiveFunctionGUI);

function populateGUI(handles, lvdData)
    lvdOptim = lvdData.optimizer;
    compObjFcn = lvdOptim.objFcn;
    
    %if the user is on the old objective functions, we need to upgrade them
    compObjFcn = CompositeObjectiveFcn.upgradeExistingObjFuncs(compObjFcn, lvdOptim, lvdData);
    lvdOptim.objFcn = compObjFcn;
    
    handles.eventCombo.String = lvdData.script.getListboxStr();
    populateBodiesCombo(lvdData.celBodyData, handles.refCelBodyCombo, false);
       
    objFuncListbox_Callback(handles.objFuncListbox, [], handles);
    
    strs = ObjFcnDirectionTypeEnum.getListBoxStr();
    handles.optDirTypeCombo.String = strs;
    handles.optDirTypeCombo.Value = ObjFcnDirectionTypeEnum.getIndForName(compObjFcn.dirType.name);
    
    strs = ObjFcnCompositeMethodEnum.getListBoxStr();
    handles.compositionTypeCombo.String = strs;
    handles.compositionTypeCombo.Value = ObjFcnCompositeMethodEnum.getIndForName(compObjFcn.compositeMethod.name);
    
    
% --- Outputs from this function are returned to the command line.
function varargout = lvd_EditCompositeObjectiveFunctionGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    if(isempty(handles))
        varargout{1} = false;
    else
        varargout{1} = true;

        lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
        lvdOpt = lvdData.optimizer;
        compObjFcn = lvdOpt.objFcn;
        
        contents = cellstr(get(handles.optDirTypeCombo,'String'));
        str = contents{get(handles.optDirTypeCombo,'Value')};
        ind = ObjFcnDirectionTypeEnum.getIndForName(str);
        enums = enumeration('ObjFcnDirectionTypeEnum');
        compObjFcn.dirType = enums(ind);
        
        contents = cellstr(get(handles.compositionTypeCombo,'String'));
        str = contents{get(handles.compositionTypeCombo,'Value')};
        ind = ObjFcnCompositeMethodEnum.getIndForName(str);
        enums = enumeration('ObjFcnCompositeMethodEnum');
        compObjFcn.compositeMethod = enums(ind);
        
        close(handles.lvd_EditCompositeObjectiveFunctionGUI);
    end


% --- Executes on button press in saveAndCloseButton.
function saveAndCloseButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveAndCloseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    uiresume(handles.lvd_EditCompositeObjectiveFunctionGUI);
    
    
function updateValueLabels(handles)
    lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
    stateLog = lvdData.stateLog;
    genObjFunc = getCurrentlySelectedObjFunc(handles);
    
    if(not(isempty(genObjFunc)))
        [f, fUnscaled] = genObjFunc.evalObjFcn(stateLog);
        handles.curValueLabel.String = fullAccNum2Str(fUnscaled);
        handles.curValScaledLabel.String = fullAccNum2Str(f);

        [unit, ~, ~, ~, ~, ~] = genObjFunc.fcn.getConstraintStaticDetails();
        handles.curValUnitLabel.String = unit;
        handles.curValUnitLabel.TooltipString = unit;
    else
        handles.curValueLabel.String = ' -- ';
        handles.curValScaledLabel.String = ' -- ';
        handles.curValUnitLabel.String = '';
        handles.curValUnitLabel.TooltipString = '';
    end
    
% --- Executes on selection change in objFuncListbox.
function objFuncListbox_Callback(hObject, eventdata, handles)
% hObject    handle to objFuncListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns objFuncListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from objFuncListbox
    lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
    lvdOpt = lvdData.optimizer;
    compObjFcn = lvdOpt.objFcn;
    
    handles.eventCombo.String = lvdData.script.getListboxStr();
    populateBodiesCombo(lvdData.celBodyData, handles.refCelBodyCombo, false);
    
    if(isempty(compObjFcn.objFcns))
        handles.removeObjFuncButton.Enable = 'off';
        
        handles.objFuncListbox.String = '<No Objective Functions>';
        handles.objFuncListbox.Value = 1;
        
        handles.objFuncTypeLabel.String = 'None';
        handles.eventCombo.Enable = 'off';
        handles.refCelBodyCombo.Enable = 'off';
        handles.scaleFactorText.Enable = 'off';
    else
        handles.removeObjFuncButton.Enable = 'on';
        handles.eventCombo.Enable = 'on';
        handles.refCelBodyCombo.Enable = 'on';
        handles.scaleFactorText.Enable = 'on';
        
        value = get(hObject,'Value');
        handles.objFuncListbox.String = compObjFcn.getListBoxStr();
        handles.objFuncListbox.Value = value;
        
        objFun = compObjFcn.objFcns(value);
        [~, ~, ~, ~, usesCelBody, ~] = objFun.fcn.getConstraintStaticDetails();
        handles.objFuncTypeLabel.String = objFun.fcn.getConstraintType();
        handles.objFuncTypeLabel.TooltipString = objFun.fcn.getConstraintType();

        handles.scaleFactorText.String = fullAccNum2Str(objFun.scaleFactor);
        
        if(usesCelBody)
            handles.refCelBodyCombo.Enable = 'on';
            
            bodyInfo = objFun.getRefBody();
            if(isempty(bodyInfo))
                value = 1;
            else
                value = findValueFromComboBox(bodyInfo.name, handles.refCelBodyCombo);
            end
            
            handles.refCelBodyCombo.Value = value;
        else
            handles.refCelBodyCombo.Value = 1;
            handles.refCelBodyCombo.Enable = 'off';
        end
    end
    
    updateValueLabels(handles);

% --- Executes during object creation, after setting all properties.
function objFuncListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to objFuncListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addObjFuncButton.
function addObjFuncButton_Callback(hObject, eventdata, handles)
% hObject    handle to addObjFuncButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
    lvdOptim = lvdData.optimizer;
    
    listBoxStr = ConstraintEnum.getListBoxStr();
    
    [Selection,ok] = listdlg('PromptString','Select the objective function type:',...
                    'SelectionMode','single',...
                    'Name','Constraint Type',...
                    'ListString',listBoxStr);
                
    if(ok == 1)
        [~, enum] = ConstraintEnum.getIndForName(listBoxStr{Selection});
        constClass = enum.class;
        input1 = enum.constructorInput1;
        
        newObjFunc = eval(sprintf('%s.getDefaultConstraint(%s)', constClass, 'input1'));
        
        event = lvdData.script.getEventForInd(lvdData.script.getTotalNumOfEvents());
        
        if(handles.refCelBodyCombo.Value > 1)
            bodyNameCell = handles.refCelBodyCombo.String(handles.refCelBodyCombo.Value);
            bodyName = lower(strtrim(bodyNameCell{1}));
            bodyInfo = celBodyData.(bodyName);
        else
            bodyInfo = KSPTOT_BodyInfo.empty(1,0);
        end
        
        newObjFunc.event = event;
        genObjFunc = GenericObjectiveFcn(event, bodyInfo, newObjFunc, 1, lvdOptim, lvdData);
        
        lvdOptim.objFcn.addObjFunc(genObjFunc);
        handles.objFuncListbox.String = lvdOptim.objFcn.getListBoxStr();
        handles.objFuncListbox.Value = lvdOptim.objFcn.getNumberObjFuncs();
        objFuncListbox_Callback(handles.objFuncListbox, [], handles);
    end

% --- Executes on button press in removeObjFuncButton.
function removeObjFuncButton_Callback(hObject, eventdata, handles)
% hObject    handle to removeObjFuncButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
    compObjFunc = lvdData.optimizer.objFcn;
    
    selObjFunc = get(handles.objFuncListbox,'Value');
    genObjFunc = compObjFunc.getObjFuncForInd(selObjFunc);
            
    compObjFunc.removeObjFunc(genObjFunc);
        
	listBoxStr = compObjFunc.getListBoxStr();
	set(handles.objFuncListbox,'String',listBoxStr);

	numObjFuncs = length(listBoxStr);
    if(selObjFunc > numObjFuncs)
        set(handles.objFuncListbox,'Value',numObjFuncs);
    end
    
    objFuncListbox_Callback(handles.objFuncListbox, [], handles);

% --- Executes on selection change in optDirTypeCombo.
function optDirTypeCombo_Callback(hObject, eventdata, handles)
% hObject    handle to optDirTypeCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns optDirTypeCombo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from optDirTypeCombo


% --- Executes during object creation, after setting all properties.
function optDirTypeCombo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optDirTypeCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in compositionTypeCombo.
function compositionTypeCombo_Callback(hObject, eventdata, handles)
% hObject    handle to compositionTypeCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns compositionTypeCombo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from compositionTypeCombo


% --- Executes during object creation, after setting all properties.
function compositionTypeCombo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compositionTypeCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function genObjFunc = getCurrentlySelectedObjFunc(handles)
    lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
    compObjFunc = lvdData.optimizer.objFcn;
    
    if(isempty(compObjFunc.objFcns))
        genObjFunc = GenericObjectiveFcn.empty(1,0);
        
    else
        selObjFunc = get(handles.objFuncListbox,'Value');
        genObjFunc = compObjFunc.getObjFuncForInd(selObjFunc);
    end
    


% --- Executes on selection change in eventCombo.
function eventCombo_Callback(hObject, eventdata, handles)
% hObject    handle to eventCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns eventCombo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from eventCombo
    lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
    genObjFunc = getCurrentlySelectedObjFunc(handles);
    
    evtNum = get(hObject,'Value');
    event = lvdData.script.getEventForInd(evtNum);
    genObjFunc.event = event;
    
    updateValueLabels(handles);
    
% --- Executes during object creation, after setting all properties.
function eventCombo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in refCelBodyCombo.
function refCelBodyCombo_Callback(hObject, eventdata, handles)
% hObject    handle to refCelBodyCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns refCelBodyCombo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from refCelBodyCombo
    lvdData = getappdata(handles.lvd_EditCompositeObjectiveFunctionGUI,'lvdData');
    genObjFunc = getCurrentlySelectedObjFunc(handles);
    
    celBodyData = lvdData.celBodyData;
    bodyNameCell = handles.refCelBodyCombo.String(handles.refCelBodyCombo.Value);
    bodyName = lower(strtrim(bodyNameCell{1}));
    bodyInfo = celBodyData.(bodyName);
    
    genObjFunc.targetBodyInfo = bodyInfo;
    
    updateValueLabels(handles);

% --- Executes during object creation, after setting all properties.
function refCelBodyCombo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to refCelBodyCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scaleFactorText_Callback(hObject, eventdata, handles)
% hObject    handle to scaleFactorText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scaleFactorText as text
%        str2double(get(hObject,'String')) returns contents of scaleFactorText as a double
    newInput = get(hObject,'String');
    newInput = attemptStrEval(newInput);
    set(hObject,'String', newInput);
    
    genObjFunc = getCurrentlySelectedObjFunc(handles);
    
    errMsg = {};
    scaleFactor = str2double(get(handles.scaleFactorText,'String'));
    enteredStr = get(handles.scaleFactorText,'String');
    numberName = 'Scale Factor';
    lb = 1E-20;
    ub = 1E20;
    isInt = false;
    errMsg = validateNumber(scaleFactor, numberName, lb, ub, isInt, errMsg, enteredStr);
    
    if(isempty(errMsg))
        genObjFunc.scaleFactor = scaleFactor;
    else
        handles.scaleFactorText.String = fullAccNum2Str(genObjFunc.scaleFactor);
        msgbox(errMsg,'Invalid Objective Function Inputs','error');
    end
    
    updateValueLabels(handles);

% --- Executes during object creation, after setting all properties.
function scaleFactorText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scaleFactorText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on lvd_EditCompositeObjectiveFunctionGUI or any of its controls.
function lvd_EditCompositeObjectiveFunctionGUI_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lvd_EditCompositeObjectiveFunctionGUI (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
    switch(eventdata.Key)
        case 'return'
            saveAndCloseButton_Callback(handles.saveAndCloseButton, [], handles);
        case 'enter'
            saveAndCloseButton_Callback(handles.saveAndCloseButton, [], handles);
        case 'escape'
            close(handles.lvd_EditCompositeObjectiveFunctionGUI);
    end
