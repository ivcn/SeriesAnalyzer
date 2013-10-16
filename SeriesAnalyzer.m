function varargout = SeriesAnalyzer(varargin)
% SERIESANALYZER MATLAB code for SeriesAnalyzer.fig
%      SERIESANALYZER, by itself, creates a new SERIESANALYZER or raises the existing
%      singleton*.
%
%      H = SERIESANALYZER returns the handle to a new SERIESANALYZER or the handle to
%      the existing singleton*.
%
%      SERIESANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERIESANALYZER.M with the given input arguments.
%
%      SERIESANALYZER('Property','Value',...) creates a new SERIESANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SeriesAnalyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SeriesAnalyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SeriesAnalyzer

% Last Modified by GUIDE v2.5 17-Oct-2013 02:13:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SeriesAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @SeriesAnalyzer_OutputFcn, ...
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


% --- Executes just before SeriesAnalyzer is made visible.
function SeriesAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SeriesAnalyzer (see VARARGIN)

% Choose default command line output for SeriesAnalyzer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SeriesAnalyzer wait for user response (see UIRESUME)
% uiwait(handles.MainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = SeriesAnalyzer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_File_Callback(hObject, eventdata, handles)
% hObject    handle to menu_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_Open_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile('*.txt');
data = dlmread(strcat(pathname, filename));
handles.SourceSeries = data(:,2);
handles.ResultSeries = handles.SourceSeries;
guidata(hObject, handles);
updateWindow(handles);

% --------------------------------------------------------------------
function menuItem_Save_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = handles.ResultSeries;
coords = (1:length(data))';
[filename pathname] = uiputfile('*.txt');
dlmwrite(strcat(pathname,filename),[coords data], '\t');

% --------------------------------------------------------------------
function menuItem_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ResultSeries = handles.SourceSeries;
guidata(hObject, handles);
updateWindow(handles);

%---------------------------------------------------------------------
function updateWindow(handles)
axes(handles.SourceCanvas);
plot(handles.SourceSeries);

axes(handles.ResultCanvas);
plot(handles.ResultSeries);


% --------------------------------------------------------------------
function menu_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_SSA_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_SSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ResultSeries = runSSA(handles.ResultSeries);
guidata(hObject, handles);
updateWindow(handles);


% --------------------------------------------------------------------
function menuItem_Chebyshev_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Chebyshev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ResultSeries = runChebyshev(handles.ResultSeries);
guidata(hObject, handles);
updateWindow(handles);


% --------------------------------------------------------------------
function menuItem_WaveletProcessing_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_WaveletProcessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ResultSeries = runWaveletProcessing(handles.ResultSeries);
guidata(hObject,handles);
updateWindow(handles);


% --------------------------------------------------------------------
function menu_Parametrization_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Parametrization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_Prediction_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Prediction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuItem_Nonstationarity_Callback(hObject, eventdata, handles)
% hObject    handle to menuItem_Nonstationarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ResultSeries = runNonstationarity(handles.ResultSeries);
guidata(hObject,handles);
updateWindow(handles);
