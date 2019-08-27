function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 11-Nov-2012 02:18:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles.output = hObject;

 % set the sample rate (Hz)
 handles.Fs       = 8192;

 % create the recorder
 handles.recorder = audiorecorder(handles.Fs,8,1);

 % assign a timer function to the recorder
 set(handles.recorder,'TimerPeriod',1,'TimerFcn',{@audioTimer,hObject});

 % save the handles structure
 guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Record_upload.
function Record_upload_Callback(hObject, eventdata, handles)
% hObject    handle to Record_upload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile({'*.mp3';'*.wav';'*.ogg'});
[y,fs] = audioread(strcat(path,file));
    y = y(:,1);
    dt = 1/fs;
    t = 0:dt:(length(y)*dt)-dt;
    x = linspace(0,10);
    plot(handles.saxes,t,y);
     xlabel(handles.saxes,'Seconds')
    ylabel(handles.saxes,'Amplitude')
	info = audioinfo(strcat(path,file))
	set(handles.text1, 'String',  strcat(num2str(info.Duration),' seconds'));
	setappdata(0,'y', y);
	setappdata(0,'fs', fs);

    

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ts = 1/getappdata(0,'fs');
L = length(getappdata(0,'y'));
T = (0:L-1)*Ts;
freq = 0:L-1;
freq = freq*getappdata(0,'fs')/L;
cutOff = L/2;
freq = freq(1:cutOff);
X = fft(getappdata(0,'y'));
X = X(1:cutOff);
plot(handles.saxes2,freq, imag(X));

xlabel(handles.saxes2,'Frequency')
    ylabel(handles.saxes2,'Imaginary')

% --- Executes during object creation, after setting all properties.
function saxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate saxes


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in startR.
function startR_Callback(hObject, eventdata, handles)
% hObject    handle to startR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
record(handles.recorder);
%handles.text1.String = num2str(t);

 function audioTimer(hObject,varargin)
      % get the handle to the figure/GUI  (this is the handle we passed in 
 % when creating the timer function in myGuiName_OpeningFcn)
 hFigure = varargin{2};

 % get the handles structure so we can access the plots/axes
 handles = guidata(hFigure);

 % get the audio samples
 samples  = getaudiodata(hObject);

 % etc.
% --- Executes on button press in stopR.
function stopR_Callback(hObject, eventdata, handles)
% hObject    handle to stopR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = mfilename('fullpath');
    [filepath,name,ext] = fileparts(file);
    filename = strcat(filepath, '\recording.wav');
    fs = 8000;  
    stop(handles.recorder);
    recordedaudio = getaudiodata(handles.recorder);
    audiowrite(filename, recordedaudio, fs)
    [y,fs] = audioread(filename);
    y = y(:,1);
    dt = 1/fs;
    t = 0:dt:(length(y)*dt)-dt;
    plot(handles.saxes,t,y);
    xlabel(handles.saxes,'Seconds')
    ylabel(handles.saxes,'Amplitude')
	info = audioinfo(filename)
	set(handles.text1, 'String',  strcat(num2str(info.Duration),' seconds'));
	setappdata(0,'y', y);
	setappdata(0,'fs', fs);
