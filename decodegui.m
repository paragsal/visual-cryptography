function varargout = decodegui(varargin)
% DECODEGUI MATLAB code for decodegui.fig
%      DECODEGUI, by itself, creates a new DECODEGUI or raises the existing
%      singleton*.
%
%      H = DECODEGUI returns the handle to a new DECODEGUI or the handle to
%      the existing singleton*.
%
%      DECODEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECODEGUI.M with the given input arguments.
%
%      DECODEGUI('Property','Value',...) creates a new DECODEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before decodegui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to decodegui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help decodegui

% Last Modified by GUIDE v2.5 22-Apr-2016 20:55:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @decodegui_OpeningFcn, ...
                   'gui_OutputFcn',  @decodegui_OutputFcn, ...
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


% --- Executes just before decodegui is made visible.
function decodegui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to decodegui (see VARARGIN)

% Choose default command line output for decodegui
handles.output = hObject;
clc
global imgd;
handles.imgd = varargin;
global addr;
handles.addr = varargin;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes decodegui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = decodegui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function dbrowseedt_Callback(hObject, eventdata, handles)
% hObject    handle to dbrowseedt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbrowseedt as text
%        str2double(get(hObject,'String')) returns contents of dbrowseedt as a double


% --- Executes during object creation, after setting all properties.
function dbrowseedt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbrowseedt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in decryptbtn.
function decryptbtn_Callback(hObject, eventdata, handles)
% hObject    handle to decryptbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
handles.imgd = double(handles.imgd);
[row col] = size(handles.imgd);
t = fix(clock);
m = t(2); 
d = t(3);
hh = t(4);
mm = t(5);
m1 = handles.imgd(row,col);
d1 = handles.imgd(row,col-1);
hh1 = handles.imgd(row,col-2);
mm1 = handles.imgd(row,col-3);
val = handles.imgd(row,col-4);

if(m==m1 & d==d1 & hh==hh1 & mm>mm1 & mm+255<=mm1+val+10)
for x=1:1:row
    for y=1:1:col
        temp = dec2bin(handles.imgd(x,y),8);
        if(temp(8)=='0')
            temp = '00000000';
            handles.secret_data(x,y) = bin2dec(temp);
        else
            temp = '11111111';
            handles.secret_data(x,y) = bin2dec(temp);
        end
    end
end
handles.secret_data = uint8(handles.secret_data);
imwrite(handles.secret_data, 'C:\Users\Parag\Desktop\newimage22.tif');
axes(handles.axes1)
imshow(handles.secret_data)

else
    err1 = msgbox('Session timed out. Image discarded');
    delete(handles.addr);
end
toc;
guidata(hObject,handles);

% --- Executes on button press in dbrowsebtn.
function dbrowsebtn_Callback(hObject, eventdata, handles)
% hObject    handle to dbrowsebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f2, p2] = uigetfile({'*.tif'},'File Selector');
handles.imgd = strcat(p2, f2);
handles.addr = handles.imgd;
set(handles.dbrowseedt,'string',handles.imgd);
handles.imgd = imread(handles.imgd);
guidata(hObject,handles)
