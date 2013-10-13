function varargout = runSSA(varargin)
% RUNSSA MATLAB code for runSSA.fig
%      RUNSSA, by itself, creates a new RUNSSA or raises the existing
%      singleton*.
%
%      H = RUNSSA returns the handle to a new RUNSSA or the handle to
%      the existing singleton*.
%
%      RUNSSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUNSSA.M with the given input arguments.
%
%      RUNSSA('Property','Value',...) creates a new RUNSSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before runSSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to runSSA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help runSSA

% Last Modified by GUIDE v2.5 13-Oct-2013 23:06:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @runSSA_OpeningFcn, ...
                   'gui_OutputFcn',  @runSSA_OutputFcn, ...
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


% --- Executes just before runSSA is made visible.
function runSSA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to runSSA (see VARARGIN)

% Choose default command line output for runSSA
handles.output = hObject;
handles.input = varargin{1};
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes runSSA wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = runSSA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.figure1);

function editWindowSize_Callback(hObject, eventdata, handles)
% hObject    handle to editWindowSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWindowSize as text
%        str2double(get(hObject,'String')) returns contents of editWindowSize as a double


% --- Executes during object creation, after setting all properties.
function editWindowSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWindowSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editCompFirst_Callback(hObject, eventdata, handles)
% hObject    handle to editCompFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCompFirst as text
%        str2double(get(hObject,'String')) returns contents of editCompFirst as a double


% --- Executes during object creation, after setting all properties.
function editCompFirst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCompFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editCompLast_Callback(hObject, eventdata, handles)
% hObject    handle to editCompLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCompLast as text
%        str2double(get(hObject,'String')) returns contents of editCompLast as a double


% --- Executes during object creation, after setting all properties.
function editCompLast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCompLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonApply.
function buttonApply_Callback(hObject, eventdata, handles)
% hObject    handle to buttonApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('../SSA');
output = mainSSA(handles.input',...
        str2double(get(handles.editWindowSize,'String')),...
        str2double(get(handles.editCompFirst, 'String')),...
        str2double(get(handles.editCompLast,  'String')));
handles.output = output;
guidata(hObject, handles);
rmpath('../SSA');
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);


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
