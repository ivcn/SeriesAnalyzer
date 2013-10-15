function varargout = runChebyshev(varargin)
% RUNCHEBYSHEV MATLAB code for runChebyshev.fig
%      RUNCHEBYSHEV, by itself, creates a new RUNCHEBYSHEV or raises the existing
%      singleton*.
%
%      H = RUNCHEBYSHEV returns the handle to a new RUNCHEBYSHEV or the handle to
%      the existing singleton*.
%
%      RUNCHEBYSHEV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUNCHEBYSHEV.M with the given input arguments.
%
%      RUNCHEBYSHEV('Property','Value',...) creates a new RUNCHEBYSHEV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before runChebyshev_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to runChebyshev_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help runChebyshev

% Last Modified by GUIDE v2.5 14-Oct-2013 00:23:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @runChebyshev_OpeningFcn, ...
                   'gui_OutputFcn',  @runChebyshev_OutputFcn, ...
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


% --- Executes just before runChebyshev is made visible.
function runChebyshev_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to runChebyshev (see VARARGIN)

% Choose default command line output for runChebyshev
handles.output = hObject;
handles.series = varargin{1};
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes runChebyshev wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = runChebyshev_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.series;
delete(handles.figure1);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonCalculate.
function buttonCalculate_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCalculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonResults.
function buttonResults_Callback(hObject, eventdata, handles)
% hObject    handle to buttonResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trend = ChebyshevApproximation(handles.series, str2double(get(handles.edit1, 'String')));
figure();
plot(1:length(handles.series), handles.series, 'k'); 
hold on;
plot(1:length(trend), trend, 'g','LineWidth',2);
hold off;
set(gca,'FontName','Arial Cyr');
title('Результаты расчета тренда','FontSize',12);


% --- Executes on button press in buttonDeleteTrend.
function buttonDeleteTrend_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDeleteTrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trend = ChebyshevApproximation(handles.series, str2double(get(handles.edit1, 'String')));
handles.series = handles.series - trend;
guidata(hObject, handles);
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);

% --- Executes on button press in buttonDeleteNoise.
function buttonDeleteNoise_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDeleteNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trend = ChebyshevApproximation(handles.series, str2double(get(handles.edit1, 'String')));
handles.series = trend;
guidata(hObject, handles);
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
