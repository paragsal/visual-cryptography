function varargout = Encryptiongui(varargin)
% ENCRYPTIONGUI MATLAB code for Encryptiongui.fig
%      ENCRYPTIONGUI, by itself, creates a new ENCRYPTIONGUI or raises the existing
%      singleton*.
%
%      H = ENCRYPTIONGUI returns the handle to a new ENCRYPTIONGUI or the handle to
%      the existing singleton*.
%
%      ENCRYPTIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENCRYPTIONGUI.M with the given input arguments.
%
%      ENCRYPTIONGUI('Property','Value',...) creates a new ENCRYPTIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Encryptiongui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Encryptiongui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Encryptiongui

% Last Modified by GUIDE v2.5 24-Apr-2016 12:01:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Encryptiongui_OpeningFcn, ...
                   'gui_OutputFcn',  @Encryptiongui_OutputFcn, ...
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


% --- Executes just before Encryptiongui is made visible.
function Encryptiongui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Encryptiongui (see VARARGIN)

% Choose default command line output for Encryptiongui
handles.output = hObject;
global y;
handles.y = varargin;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Encryptiongui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Encryptiongui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in imgbtn.
function imgbtn_Callback(hObject, eventdata, handles)
% hObject    handle to imgbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f1, p1]= uigetfile({'*.jpg';'*.bmp';'*.tif'}, 'File Selector');
handles.img1 = strcat(p1, f1);
set(handles.img1edt,'string',handles.img1);
handles.img1 = imread(handles.img1);
guidata(hObject,handles)

% --- Executes on button press in img2btn.
function img2btn_Callback(hObject, eventdata, handles)
% hObject    handle to img2btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f2, p2]= uigetfile({'*.bmp'}, 'File Selector');
handles.a = strcat(p2, f2);
set(handles.img2edt,'string',handles.a);
handles.a = imread(handles.a);
guidata(hObject,handles)

% --- Executes on button press in encryptbtn.
function encryptbtn_Callback(hObject, eventdata, handles)
% hObject    handle to encryptbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if isfield(handles,'img1')
    if isfield(handles, 'a')
        if isfield(handles, 'y')
        handles.img1 = double(handles.img1);
[row, col] = size(handles.img1);

handles.img2 = imresize(handles.a, [row, col]);
handles.img2 = double(handles.img2);
for x=1:1:row
    for y=1:1:col
        temp1 = dec2bin(handles.img1(x,y),8);
        temp2 = dec2bin(handles.img2(x,y),8);
        temp1(8) = temp2(1);
        temp1(7) = temp2(2);
        temp1(6) = temp2(3);
        temp1(5) = temp2(4);
        temp1(4) = temp2(5);
        handles.stego(x,y) = bin2dec(temp1);
    end
end



handles.stego = uint8(handles.stego);

t = fix(clock);

m = t(2);   %month
handles.stego(row, col) = m;

d = t(3);   %day
handles.stego(row, col-1) = d;

hh = t(4);  %hours
handles.stego(row, col-2) = hh;

mm = t(5)   %minutes
handles.stego(row, col-3) = mm;

handles.stego(row, col-4) = y; %validity period

imwrite(handles.stego, 'C:\Users\Parag\Desktop\newimage.tif');
    end
    end
end
toc;
axes(handles.axes1)
imshow(handles.stego)
guidata(hObject,handles);


function img1edt_Callback(hObject, eventdata, handles)
% hObject    handle to img1edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of img1edt as text
%        str2double(get(hObject,'String')) returns contents of img1edt as a double


% --- Executes during object creation, after setting all properties.
function img1edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img1edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function img2edt_Callback(hObject, eventdata, handles)
% hObject    handle to img2edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of img2edt as text
%        str2double(get(hObject,'String')) returns contents of img2edt as a double


% --- Executes during object creation, after setting all properties.
function img2edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img2edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y = get(hObject,'String')
newy = str2double(y)
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
