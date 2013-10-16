function varargout = runWaveletProcessing(varargin)
% RUNWAVELETPROCESSING MATLAB code for runWaveletProcessing.fig
%      RUNWAVELETPROCESSING, by itself, creates a new RUNWAVELETPROCESSING or raises the existing
%      singleton*.
%
%      H = RUNWAVELETPROCESSING returns the handle to a new RUNWAVELETPROCESSING or the handle to
%      the existing singleton*.
%
%      RUNWAVELETPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUNWAVELETPROCESSING.M with the given input arguments.
%
%      RUNWAVELETPROCESSING('Property','Value',...) creates a new RUNWAVELETPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before runWaveletProcessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to runWaveletProcessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help runWaveletProcessing

% Last Modified by GUIDE v2.5 16-Oct-2013 02:18:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @runWaveletProcessing_OpeningFcn, ...
                   'gui_OutputFcn',  @runWaveletProcessing_OutputFcn, ...
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


% --- Executes just before runWaveletProcessing is made visible.
function runWaveletProcessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to runWaveletProcessing (see VARARGIN)

% Choose default command line output for runWaveletProcessing
handles.output = hObject;
handles.series = varargin{1};
handles.originalSeries = handles.series;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes runWaveletProcessing wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = runWaveletProcessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.series;
delete(handles.figure1);

% --- Executes on button press in buttonApplyChanges.
function buttonApplyChanges_Callback(hObject, eventdata, handles)
% hObject    handle to buttonApplyChanges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.series;
guidata(hObject, handles);
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);

% --- Executes on selection change in popupFilter.
function popupFilter_Callback(hObject, eventdata, handles)
% hObject    handle to popupFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupFilter


% --- Executes during object creation, after setting all properties.
function popupFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDecompositionLevel_Callback(hObject, eventdata, handles)
% hObject    handle to editDecompositionLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDecompositionLevel as text
%        str2double(get(hObject,'String')) returns contents of editDecompositionLevel as a double


% --- Executes during object creation, after setting all properties.
function editDecompositionLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDecompositionLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonApplyFilter.
function buttonApplyFilter_Callback(hObject, eventdata, handles)
% hObject    handle to buttonApplyFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupContent = cellstr(get(handles.popupFilter,'String'));
popupNum = get(handles.popupFilter,'Value');
waveletName=popupContent{popupNum};
level = str2double(get(handles.editDecompositionLevel,'String'));
alpha = str2double(get(handles.editAlpha,'String'));
hardThreshold = get(handles.checkboxThreshold,'Value');
handles.series = WaveletFilter(handles.series,waveletName,level, alpha,1,hardThreshold);
figure();
plot(1:length(handles.originalSeries), handles.originalSeries,'k');
hold on;
plot(1:length(handles.series), handles.series, 'g');
guidata(hObject, handles);

% --- Executes on selection change in popupWaveletName.
function popupWaveletName_Callback(hObject, eventdata, handles)
% hObject    handle to popupWaveletName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupWaveletName contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupWaveletName


% --- Executes during object creation, after setting all properties.
function popupWaveletName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupWaveletName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFirstScale_Callback(hObject, eventdata, handles)
% hObject    handle to editFirstScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFirstScale as text
%        str2double(get(hObject,'String')) returns contents of editFirstScale as a double


% --- Executes during object creation, after setting all properties.
function editFirstScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFirstScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLastScale_Callback(hObject, eventdata, handles)
% hObject    handle to editLastScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLastScale as text
%        str2double(get(hObject,'String')) returns contents of editLastScale as a double


% --- Executes during object creation, after setting all properties.
function editLastScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLastScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSlidingWindow_Callback(hObject, eventdata, handles)
% hObject    handle to editSlidingWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSlidingWindow as text
%        str2double(get(hObject,'String')) returns contents of editSlidingWindow as a double


% --- Executes during object creation, after setting all properties.
function editSlidingWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSlidingWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonCalculateEnergy.
function buttonCalculateEnergy_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCalculateEnergy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupContent = cellstr(get(handles.popupWaveletName,'String'));
popupNum = get(handles.popupWaveletName,'Value');
wavelet=popupContent{popupNum};
firstScale = str2double(get(handles.editFirstScale, 'String'));
lastScale = str2Double(get(handles.editLastScale, 'String'));
windowSize = str2double(get(handles.editSlidingWindow, 'String'));
[energy scalogram] = WaveletEnergy(handles.series,...
                                   wavelet,...
                                   firstScale,...
                                   lastScale,...
                                   windowSize);
figure();
subplot(211);
imagesc(scalogram);
subplot(212);
plot(1:length(energy), energy, 'k');
handles.series = energy;
guidata(hObject, handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting') 
    uiresume(hObject);
    %setappdata(handles.figure1, 'waiting', 0);
else
    delete(hObject);
end


% --- Executes on button press in buttonReset.
function buttonReset_Callback(hObject, eventdata, handles)
% hObject    handle to buttonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.series = handles.originalSeries;
guidata(hObject, handles);



function editAlpha_Callback(hObject, eventdata, handles)
% hObject    handle to editAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAlpha as text
%        str2double(get(hObject,'String')) returns contents of editAlpha as a double


% --- Executes during object creation, after setting all properties.
function editAlpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxThreshold.
function checkboxThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxThreshold
