function varargout = signin(varargin)
% SIGNIN MATLAB code for signin.fig
%      SIGNIN, by itself, creates a new SIGNIN or raises the existing
%      singleton*.
%
%      H = SIGNIN returns the handle to a new SIGNIN or the handle to
%      the existing singleton*.
%
%      SIGNIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNIN.M with the given input arguments.
%
%      SIGNIN('Property','Value',...) creates a new SIGNIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signin

% Last Modified by GUIDE v2.5 03-Sep-2015 15:32:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signin_OpeningFcn, ...
                   'gui_OutputFcn',  @signin_OutputFcn, ...
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
%版本信息：1.0测试版（部分功能待更新）
%作者信息：刘杨（Youngger）,github:hunteryourlove
%版权所有，请保留作者信息，以便您的正常使用！
% --- Executes just before signin is made visible.
function signin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signin (see VARARGIN)

% Choose default command line output for signin
%定义全局变量%
%变量设置规则：为区分全局变量，signin中的全局变量会在signup的变量基础上加上“_in”
global pin_in open username1 password1 pin1;
username1=0; password1=0; pin1=0;
set(handles.edit6,'visible','off');
set(handles.edit5,'visible','off');
handles.output = hObject;
axes(handles.axes1);
a=imread('banner.png');
imshow(a);
axes(handles.axes2);
b=imread('user.jpg');
imshow(b);
c1=rand*10000;pin_in=num2str(c1,'%.0f');
set(handles.edit4,'string',pin_in);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns togglebutton2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from togglebutton2


% --- Executes on button press in pushbutton3.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global judge_pin_in username1 password1 pin1;%引用全局变量
username=get(handles.edit1,'string');
password=get(handles.edit2,'string');
bb=xlsread('data.xlsx','sheet1');
for i=1:(length(bb)*2)
user_matrix_in{i}=num2str(bb(i));
k=length(user_matrix_in);um=user_matrix_in(1:k/2);pm=user_matrix_in((k/2+1):k);
um1=um(:);pm1=pm(:);user_matrix_sp_in=[um1,pm1];
end
n=length(bb);
for ii=1:1:n
    if (strcmp(username,bb(ii,1))==0)
        username1=1;
    else
        if ii<=n
            continue;
        else
            username1=0;
            set(handles.edit1,'string','用户名不存在！');%弹出用户名不存在
            pause(0.2);
            set(handles.edit1,'string','');set(handles.edit2,'string','');
        end
    end
end
for jj=1:1:n
    if (strcmp(password,bb(jj,2))==1)
        password1=1;
    else
        if jj<=n
            continue;
        else
            password1=0;
            set(handles.edit2,'string','密码错误！');%弹出密码错误
            pause(0.2);
            set(handles.edit1,'string','');set(handles.edit2,'string','');
        end
    end
end
if judge_pin_in==1
    pin1=1;
else
    pin1=0;
    set(hanles.edit3,'string','验证码错误！');%弹出验证码错误
    pause(0.2);
    set(hanles.edit3,'string','');
end
a1=(username1==1);b1=(password1==1);c1=(pin1==1);
if a1&b1&c1
    open=1;
    dlmwrite('open.txt',open);
    h=gcf;mm;pause(0.2);close(h);
else
    set(handles.edit6,'visible','on');
    if a1==0
    set(handles.edit6,'string','错误代码a1')%弹出重新来一次
    elseif b1==0
        set(handles.edit6,'string','错误代码b1')%弹出重新来一次
    elseif c1==0
        set(handles.edit6,'string','错误代码c1')%弹出重新来一次
    end
end


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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf;
signup;pause(0.2);
close(h);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global judge_pin_in pin_in;
pin2=get(handles.edit4,'string');
if pin2~=pin_in
    set(handles.edit4,'string','错误！');
    pause(0.5);
    set(handles.edit4,'string','');
    judge_pin_in=0;
else
    judge_pin_in=1;
    set(handles.edit5,'visible','on');
    set(handles.edit5,'string','正确');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
