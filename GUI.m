%run('C:\Program Files\DIPimage 2.7\dipstart.m')

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
CharterArrayStruct = load('-mat', 'CharterArray');
handles.characterMasks = uint8(CharterArrayStruct.b);
handles.lookupTable = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'B', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'R', 'S', 'T', 'V', 'X', 'Z', '-'];

handles.output = hObject;
handles.video = 'video.avi';
handles.vid = VideoReader(handles.video);
set(handles.text2, 'String', handles.video);
handles.frame = 0;

data = read(handles.vid, handles.frame+1);

handles.matchingData = zeros(8, size(handles.characterMasks, 3), 10);
handles.matchingFrames = zeros(10, 1);

set(handles.uitable3,'Data',{})

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% S button
function pushbutton1_Callback(hObject, eventdata, handles)
global stop;

set(handles.text5, 'String', handles.vid.duration);
if stop == true
    stop = false;
    handles.startStamp = tic();
else
    stop = true;
end

while stop == false
    handles = showIMG(handles, 0);
    guidata(hObject, handles);
end;


% N button
function pushbutton2_Callback(hObject, eventdata, handles)
handles.startStamp = tic();
handles = showIMG(handles, 1);
guidata(hObject, handles);

function handles = showIMG(handles, forceCalcPlate) 
global stop;
    handles.frame = 4 + handles.frame;
    try
        data = read(handles.vid, handles.frame);

        axes(handles.axes1);
        image(data);

        if mod(handles.frame, 8) == 0 || forceCalcPlate
            % get the straigtend out cut plate
            plate = removeShadowsAndSharpen(imageToPlate(data));
            try
                IM1 = labelCharsRemoveEdgeObj(~threshold(plate,'isodata',Inf));
            catch
                return;
            end;
            
            handles = addPlateToTableProcess(IM1, handles);
        end;

        % update frame counter
        set(handles.text1, 'String', handles.frame);
        set(handles.text4, 'String', toc(handles.startStamp));
    catch
        
        set(handles.text1, 'String', 'Done');
        handles.frame = 0;
        stop = true;
    end;
    
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

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    handles.startStamp = tic();
    handles.frame = str2double(get(handles.edit1,'String')) - 2;
    guidata(hObject, handles);
    showIMG(handles, true);

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



% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
