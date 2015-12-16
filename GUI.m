function varargout = exercise3(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exercise3_OpeningFcn, ...
                   'gui_OutputFcn',  @exercise3_OutputFcn, ...
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


% --- Executes just before exercise3 is made visible.
function exercise3_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.video = 'FruitCompilation.avi';
guidata(hObject, handles);


function varargout = exercise3_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
global stop;
stop = false;
vid = VideoReader(handles.video);
set(handles.text5,'String', 600);
i = 1;
while stop == false
    i = i + 1;
    data = read(vid, i);
    image(data);
    
    [r, g, o] = processImage(data);
    set(handles.text1,'ForegroundColor', r*[0 1 0]);
    set(handles.text2,'ForegroundColor', g*[0 1 0]);
    set(handles.text3,'ForegroundColor', o*[0 1 0]);
    set(handles.text4,'String', i);
    
    guidata(hObject, handles);
end;



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global stop;
stop = true;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
handles.video = uigetfile;
guidata(hObject, handles);
