function varargout = signup(varargin)
% SIGNUP MATLAB code for signup.fig
%      SIGNUP, by itself, creates a new SIGNUP or raises the existing
%      singleton*.
%
%      H = SIGNUP returns the handle to a new SIGNUP or the handle to
%      the existing singleton*.
%
%      SIGNUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNUP.M with the given input arguments.
%
%      SIGNUP('Property','Value',...) creates a new SIGNUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signup

% Last Modified by GUIDE v2.5 03-Sep-2015 15:30:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signup_OpeningFcn, ...
                   'gui_OutputFcn',  @signup_OutputFcn, ...
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

% --- Executes just before signup is made visible.
function signup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signup (see VARARGIN)

% Choose default command line output for signup
handles.output = hObject;
global user_matrix alldata judge_username judge_password judge_pin pin user_matrix_sp;%定义全局变量，包括用户数据库(user_matrix)
judge_username=0;judge_password=0;judge_pin=0;
set(handles.edit5,'visible','off');set(handles.edit6,'visible','off');
set(handles.edit7,'visible','off');set(handles.edit8,'visible','off');
alldata=xlsread('data.xlsx','sheet1');%初始化用户数据库
for i=1:(length(alldata)*2)
user_matrix{i}=num2str(alldata(i));
k=length(user_matrix);um=user_matrix(1:k/2);pm=user_matrix((k/2+1):k);
um1=um(:);pm1=pm(:);user_matrix_sp=[um1,pm1];
end
axes(handles.axes1);%初始化头部背景
a=imread('banner.png');
imshow(a);
b=rand*10000;pin=num2str(b,'%.0f');%初始化验证码
set(handles.edit3,'string',pin);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global judge_username judge_password judge_pin user_matrix_sp;
set(handles.edit5,'visible','on');
if judge_username&&judge_password&&judge_pin
    set(handles.edit5,'string','~~~~~~~~注册成功！~~~~~~~~');
    pause(1);
    u=get(handles.edit1,'string');
    p=get(handles.edit2,'string');
    com1=[{u},{p}];
    combination=[user_matrix_sp;com1];
    xlswrite('data.xlsx',combination,'sheet1');
    h=gcf;signin;pause(0.2);close(h);
elseif (judge_username==0)&(judge_password==0)&(judge_pin==0)
    set(handles.edit5,'string','注册失败！错误代码：123');
elseif (judge_username==0)&(judge_password==0)&(judge_pin==1)
    set(handles.edit5,'string','注册失败！错误代码：12');
elseif (judge_username==0)&(judge_password==1)&(judge_pin==0)
    set(handles.edit5,'string','注册失败！错误代码：13');
elseif (judge_username==1)&(judge_password==0)&(judge_pin==0)
    set(handles.edit5,'string','注册失败！错误代码：23');
elseif (judge_username==0)&(judge_password==1)&(judge_pin==1)
    set(handles.edit5,'string','注册失败！错误代码：1');
elseif (judge_username==0)&(judge_password==1)&(judge_pin==0)
    set(handles.edit5,'string','注册失败！错误代码：2');
elseif (judge_username==0)&(judge_password==0)&(judge_pin==1)
    set(handles.edit5,'string','注册失败！错误代码：3');
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global user_matrix_sp judge_username;
n=length(user_matrix_sp);
username=get(handles.edit1,'string');
for ii=1:1:n
    if length(username)<9
        set(handles.edit1,'string','请输入9位数字！');%若不符合用户名长度，则提示该句
        pause(0.2);%暂停效果
        set(handles.edit1,'string','');%edit1框清空
        judge_username=0;
    elseif strcmp(username,user_matrix_sp(ii,1))==1
        set(handles.edit1,'string','该用户名已注册！');%若已注册，则提示该句
        pause(0.2);%暂停效果
        set(handles.edit1,'string','');%edit1框清空
        judge_username=0;
    else
        set(handles.edit6,'visible','on');
        set(handles.edit6,'string','成功');
        judge_username=1;%向‘注册’button传递该值
    end
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global judge_password;
password=get(handles.edit2,'string');
if length(password)~=8
    set(handles.edit2,'string','请输入8位密码');%验证密码长度
    pause(0.5);
    set(handles.edit2,'string','');
    judge_password=0;
else
    set(handles.edit7,'visible','on');
    set(handles.edit7,'string','成功');
    judge_password=1;
end
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global judge_pin pin;
pin2=get(handles.edit4,'string');
if strcmp(pin2,pin)==1
    judge_pin=1;
    set(handles.edit8,'visible','on');
    set(handles.edit8,'string','成功');

else
    set(handles.edit4,'string','错误！');
    pause(0.5);
    set(handles.edit4,'string','');
    judge_pin=0;
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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf;
signin;
close(h);
