function varargout = GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.video = 'video.avi';
handles.vid = VideoReader(handles.video);
set(handles.text2, 'String', handles.video);
handles.frame = 0;

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% S button
function pushbutton1_Callback(hObject, eventdata, handles)
global stop;

if stop == true
    stop = false;
else
    stop = true;
end

while stop == false
    handles = showIMG(handles, 0);
    guidata(hObject, handles);
end;


% N button
function pushbutton2_Callback(hObject, eventdata, handles)
handles = showIMG(handles, 1);
guidata(hObject, handles);


function handles = showIMG(handles, forceCalcPlate) 
    handles.frame = 1 + handles.frame;
    data = read(handles.vid, handles.frame);
    imshow(data, 'parent', handles.axes1);
    
    if mod(handles.frame, 10) == 0 | forceCalcPlate
        ndata = normalize(data);
        
        bClosed = dip_array(label(closing(createMask(ndata.*255),7,'elliptic'),Inf,0,0));
        objectID = mode(bClosed(bClosed>0));
        bm = bClosed == objectID;
        
        if forceCalcPlate  
            dip_image(bm)
        end
        
        %plateMask = closing(opening(dip_image(bm),3,'elliptic'),4,'parabolic');
        
        imshow(ndata, 'parent', handles.axes2);
        imshow(bm.*255, 'parent', handles.axes3);
    end;
    
    set(handles.text1, 'String', handles.frame);

% L button
function pushbutton3_Callback(hObject, eventdata, handles)
global stop;
stop = true;
[File, Path] = uigetfile('.avi', 'Load a video');
handles.video = strcat(Path, '/', File);
handles.vid = VideoReader(handles.video);
handles.frame = 0;

set(handles.text2, 'String', File);
guidata(hObject, handles);
