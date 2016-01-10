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

data = read(handles.vid, handles.frame+1);
imshow(data, 'parent', handles.axes1);
imshow(data, 'parent', handles.axes2);
imshow(data, 'parent', handles.axes3);
imshow(data, 'parent', handles.axes4);
imshow(data, 'parent', handles.axes5);

handles.AX1CD = get(handles.axes1, 'Children');
handles.AX2CD = get(handles.axes2, 'Children');
handles.AX3CD = get(handles.axes3, 'Children');
handles.AX4CD = get(handles.axes4, 'Children');
handles.AX5CD = get(handles.axes5, 'Children');

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
    handles.frame = 2 + handles.frame;
    data = read(handles.vid, handles.frame);

    axes(handles.axes1);
    image(data);
    
    % get mask for plate location
    ndata = normalize(data);
    bm = createMask(ndata);

    % find the corners of the licence plate
    C = findCorners(bm);

    % update meantime viewers
    hold on
    plot(C([1:4 1],1),C([1:4 1],2),'r','linewidth',3);
    hold off
    
    if mod(handles.frame, 6) == 0 | forceCalcPlate
        % deskewer image and bitmask
        DeSkIm = deskewerImage(data(:,:,1), C);
        DeSkBM = deskewerImage(bm, C);
        C2 = findCorners(DeSkBM);

        plate = cutInCorners(DeSkIm, C2);
        
        % Make a binary image from the plate, 1= foreground (signs), 0=
        % background
        BinIm=im2bw(plate,0.5);
        IM2=imcomplement(BinIm);
        dip_image(IM2)
        
        
        axes(handles.axes3);
        [plateMask, treshh] = threshold(plate,'isodata',8);
        plateMask = dip_array(plateMask);
        
        %plateMask = plate > 199;
       	image(cat(3, plateMask, plateMask, plateMask).*255);
        
        if forceCalcPlate
           %dip_image(threshold(plate,'isodata',Inf))
           treshh
        end;
        
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
handles.frame = 1;

set(handles.text2, 'String', File);
guidata(hObject, handles);
