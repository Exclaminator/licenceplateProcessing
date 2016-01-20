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
imshow(data, 'parent', handles.axes1);
imshow(data, 'parent', handles.axes3);
imshow(data, 'parent', handles.axes4);
imshow(data, 'parent', handles.axes5);

handles.AX1CD = get(handles.axes1, 'Children');
handles.AX3CD = get(handles.axes3, 'Children');
handles.AX4CD = get(handles.axes4, 'Children');
handles.AX5CD = get(handles.axes5, 'Children');
set(handles.uitable3,'Data',{})

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% S button
function pushbutton1_Callback(hObject, eventdata, handles)
global stop;

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
handles = showIMG(handles, 1);
guidata(hObject, handles);

function handles = showIMG(handles, forceCalcPlate) 
    handles.frame = 1 + handles.frame;
    data = read(handles.vid, handles.frame);

    axes(handles.axes1);
    image(data);
    

    % update meantime viewers
    %hold on
    %plot(C([1:4 1],1),C([1:4 1],2),'r','linewidth',3);
    %hold off
    
    if mod(handles.frame, 6) == 0 | forceCalcPlate
        % get the straigtend out cut plate
        plate = imageToPlate(data);
        
        IM2 = getCharterBitmask(plate);
        IM3 = getCharterBitmaskHSB(plate);
        
        IM2 = bwlabel(removeEdgeObjects(IM2));
        IM3 = bwlabel(removeEdgeObjects(IM3));
        
        if max(max(IM2)) == 8 
            
            [Charters, Heights] = plateToCharters(IM2);
            [dashes, match] = bestFitMatching( Charters, Heights, handles.characterMasks, handles.lookupTable);
        end;
        
        if max(max(IM3)) == 8 

            [Charters, Heights] = plateToCharters(IM3);
            [dashes2, match2] = bestFitMatching( Charters, Heights, handles.characterMasks, handles.lookupTable);
        end;
        
        
        str = get(handles.uitable3,'Data');
        
        if max(max(IM2)) == 8 && size(chars, 2) == 8
            cell = {chars, handles.frame, toc(handles.startStamp)};
            str = [cell; str];
        end
        if max(max(IM3)) == 8 && size(chars2, 2) == 8
            cell = {chars2, handles.frame, toc(handles.startStamp)};
            str = [cell; str];
        end
        
        set(handles.uitable3,'Data', str);

        %bestFit
        
        axes(handles.axes3);
       	image(IM2.*10);
        
        axes(handles.axes4);
       	image(IM3.*10);
        
        
    end;
    
    % update frame counter
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

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
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
