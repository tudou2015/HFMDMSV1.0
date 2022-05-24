function varargout = Hesitant_Fuzzy_Multi(varargin)
% HESITANT_FUZZY_MULTI MATLAB code for hesitant_fuzzy_multi.fig
%      HESITANT_FUZZY_MULTI, by itself, creates a new HESITANT_FUZZY_MULTI or raises the existing
%      singleton*.
%
%      H = HESITANT_FUZZY_MULTI returns the handle to a new HESITANT_FUZZY_MULTI or the handle to
%      the existing singleton*.
%
%      HESITANT_FUZZY_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HESITANT_FUZZY_MULTI.M with the given input arguments.
%
%      HESITANT_FUZZY_MULTI('Property','Value',...) creates a new HESITANT_FUZZY_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hesitant_fuzzy_multi_openingfcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hesitant_fuzzy_multi_openingfcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

% 赛尔网络下一代互联网技术创新项目(NGII20180502)
% 犹豫模糊多属性决策问题处理步骤：
% 1:列出各个专家偏好的属性权重；
% 2:列出各个属性本身相互关联的重要性程度；
% 3:列出各个视频（方案）的评估值（犹豫模糊数）；
% 4:计算得分和偏差度；
% 5:计算HFHAA算子指数和算子；
% 6:计算算子的得分和偏差度；
% 其中，属性权重标准化（结合专家）；
% 加权评估意见；
% 标准化，效益型，可取消这步；

% Modified by hankun,zhangwensheng,chenyaojing,chenpanyan,chenpeiying v1.0 4-Apr-2022 10:23:12
% Last Modified by hankun,zhangwensheng,chenyaojing,chenpanyan,chenpeiying v1.0 25-May-2022 10:54:12
% email:383589954@qq.com
% References:
% Liao, H., & Xu, Z. (2013). A VIKOR-based method for hesitant fuzzy multi-criteria decision making. Fuzzy Optimization and Decision Making, 12(4), 373-392.


% 初始化
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HESITANT_Fuzzy_Multi_OpeningFcn, ...
                   'gui_OutputFcn',  @HESITANT_Fuzzy_Multi_OutputFcn, ...
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

% --- Executes just before hesitant_fuzzy_multi is made visible.
function HESITANT_Fuzzy_Multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hesitant_fuzzy_multi (see VARARGIN)

% Choose default command line output for hesitant_fuzzy_multi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hesitant_fuzzy_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HESITANT_Fuzzy_Multi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in pushbutton_playSignal.
function pushbutton_playSignal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_playSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)
    sound(handles.x, handles.Fs);
end



% --- Executes during object creation, after setting all properties.
function edit67_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Read.
function pushbutton_Read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wi=str2num(handles.edit_wi.String);
wj=str2num(handles.edit_wj.String);
disp(wi);
disp(wj);

a11=str2num(handles.edit_a11.String);
a12=str2num(handles.edit_a12.String);
a13=str2num(handles.edit_a13.String);
disp(a11);
disp(a12);
disp(a13);

a21=str2num(handles.edit_a21.String);
a22=str2num(handles.edit_a22.String);
a23=str2num(handles.edit_a23.String);
disp(a21);
disp(a22);
disp(a23);

a31=str2num(handles.edit_a31.String);
a32=str2num(handles.edit_a32.String);
a33=str2num(handles.edit_a33.String);
disp(a31);
disp(a32);
disp(a33);

a41=str2num(handles.edit_a41.String);
a42=str2num(handles.edit_a42.String);
a43=str2num(handles.edit_a43.String);
disp(a41);
disp(a42);
disp(a43);
% 
% handles.wi=wi;
% handles.wj=wj;
% handles.a11=a11;
% handles.a12=a12;
% handles.a13=a13;
% handles.a21=a21;
% handles.a22=a22;
% handles.a23=a23;
% handles.a31=a31;
% handles.a32=a32;
% handles.a33=a33;
% handles.a41=a41;
% handles.a42=a42;
% handles.a43=a43;
% guidata(hObject, handles);


% --- Executes on selection change in popupmenu_file_fs.
function popupmenu_file_fs_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_file_fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_file_fs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_file_fs


% --- Executes during object creation, after setting all properties.
function popupmenu_file_fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_file_fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a11 as text
%        str2double(get(hObject,'String')) returns contents of edit_a11 as a double


% --- Executes during object creation, after setting all properties.
function edit_a11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a21 as text
%        str2double(get(hObject,'String')) returns contents of edit_a21 as a double


% --- Executes during object creation, after setting all properties.
function edit_a21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a31 as text
%        str2double(get(hObject,'String')) returns contents of edit_a31 as a double


% --- Executes during object creation, after setting all properties.
function edit_a31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a41_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a41 as text
%        str2double(get(hObject,'String')) returns contents of edit_a41 as a double


% --- Executes during object creation, after setting all properties.
function edit_a41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a12 as text
%        str2double(get(hObject,'String')) returns contents of edit_a12 as a double


% --- Executes during object creation, after setting all properties.
function edit_a12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a22 as text
%        str2double(get(hObject,'String')) returns contents of edit_a22 as a double


% --- Executes during object creation, after setting all properties.
function edit_a22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a32 as text
%        str2double(get(hObject,'String')) returns contents of edit_a32 as a double


% --- Executes during object creation, after setting all properties.
function edit_a32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a42_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a42 as text
%        str2double(get(hObject,'String')) returns contents of edit_a42 as a double


% --- Executes during object creation, after setting all properties.
function edit_a42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a13 as text
%        str2double(get(hObject,'String')) returns contents of edit_a13 as a double


% --- Executes during object creation, after setting all properties.
function edit_a13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a23 as text
%        str2double(get(hObject,'String')) returns contents of edit_a23 as a double


% --- Executes during object creation, after setting all properties.
function edit_a23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a33 as text
%        str2double(get(hObject,'String')) returns contents of edit_a33 as a double


% --- Executes during object creation, after setting all properties.
function edit_a33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a43_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a43 as text
%        str2double(get(hObject,'String')) returns contents of edit_a43 as a double


% --- Executes during object creation, after setting all properties.
function edit_a43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit67_Callback(hObject, eventdata, handles)
% hObject    handle to edit67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit67 as text
%        str2double(get(hObject,'String')) returns contents of edit67 as a double



function edit83_Callback(hObject, eventdata, handles)
% hObject    handle to edit83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit83 as text
%        str2double(get(hObject,'String')) returns contents of edit83 as a double


% --- Executes during object creation, after setting all properties.
function edit83_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit84_Callback(hObject, eventdata, handles)
% hObject    handle to edit84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit84 as text
%        str2double(get(hObject,'String')) returns contents of edit84 as a double


% --- Executes during object creation, after setting all properties.
function edit84_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit85_Callback(hObject, eventdata, handles)
% hObject    handle to edit85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit85 as text
%        str2double(get(hObject,'String')) returns contents of edit85 as a double


% --- Executes during object creation, after setting all properties.
function edit85_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit86_Callback(hObject, eventdata, handles)
% hObject    handle to edit86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit86 as text
%        str2double(get(hObject,'String')) returns contents of edit86 as a double


% --- Executes during object creation, after setting all properties.
function edit86_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h21 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h21 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h22 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h22 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h23 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h23 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit93_Callback(hObject, eventdata, handles)
% hObject    handle to edit93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit93 as text
%        str2double(get(hObject,'String')) returns contents of edit93 as a double


% --- Executes during object creation, after setting all properties.
function edit93_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit94_Callback(hObject, eventdata, handles)
% hObject    handle to edit94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit94 as text
%        str2double(get(hObject,'String')) returns contents of edit94 as a double


% --- Executes during object creation, after setting all properties.
function edit94_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit95_Callback(hObject, eventdata, handles)
% hObject    handle to edit95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit95 as text
%        str2double(get(hObject,'String')) returns contents of edit95 as a double


% --- Executes during object creation, after setting all properties.
function edit95_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit96_Callback(hObject, eventdata, handles)
% hObject    handle to edit96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit96 as text
%        str2double(get(hObject,'String')) returns contents of edit96 as a double


% --- Executes during object creation, after setting all properties.
function edit96_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit97_Callback(hObject, eventdata, handles)
% hObject    handle to edit97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit97 as text
%        str2double(get(hObject,'String')) returns contents of edit97 as a double


% --- Executes during object creation, after setting all properties.
function edit97_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit98_Callback(hObject, eventdata, handles)
% hObject    handle to edit98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit98 as text
%        str2double(get(hObject,'String')) returns contents of edit98 as a double


% --- Executes during object creation, after setting all properties.
function edit98_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit99_Callback(hObject, eventdata, handles)
% hObject    handle to edit99 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit99 as text
%        str2double(get(hObject,'String')) returns contents of edit99 as a double


% --- Executes during object creation, after setting all properties.
function edit99_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit99 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit100_Callback(hObject, eventdata, handles)
% hObject    handle to edit100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit100 as text
%        str2double(get(hObject,'String')) returns contents of edit100 as a double


% --- Executes during object creation, after setting all properties.
function edit100_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit101_Callback(hObject, eventdata, handles)
% hObject    handle to edit101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit101 as text
%        str2double(get(hObject,'String')) returns contents of edit101 as a double


% --- Executes during object creation, after setting all properties.
function edit101_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit102_Callback(hObject, eventdata, handles)
% hObject    handle to edit102 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit102 as text
%        str2double(get(hObject,'String')) returns contents of edit102 as a double


% --- Executes during object creation, after setting all properties.
function edit102_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit102 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_22 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_22 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_23 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_23 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h31 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h31 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h32 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h32 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h33 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h33 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_31 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_31 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_32 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_32 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_33 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_33 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h11 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h11 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h12 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h12 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h13 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h13 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_11 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_11 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_13 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_13 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit118_Callback(hObject, eventdata, handles)
% hObject    handle to edit118 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit118 as text
%        str2double(get(hObject,'String')) returns contents of edit118 as a double


% --- Executes during object creation, after setting all properties.
function edit118_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit118 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit119_Callback(hObject, eventdata, handles)
% hObject    handle to edit119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit119 as text
%        str2double(get(hObject,'String')) returns contents of edit119 as a double


% --- Executes during object creation, after setting all properties.
function edit119_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit120_Callback(hObject, eventdata, handles)
% hObject    handle to edit120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit120 as text
%        str2double(get(hObject,'String')) returns contents of edit120 as a double


% --- Executes during object creation, after setting all properties.
function edit120_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h21 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h21 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h22 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h22 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h23 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h23 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit124_Callback(hObject, eventdata, handles)
% hObject    handle to edit124 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit124 as text
%        str2double(get(hObject,'String')) returns contents of edit124 as a double


% --- Executes during object creation, after setting all properties.
function edit124_CreateFcn(hObject, ~, handles)
% hObject    handle to edit124 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit125_Callback(hObject, eventdata, handles)
% hObject    handle to edit125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit125 as text
%        str2double(get(hObject,'String')) returns contents of edit125 as a double


% --- Executes during object creation, after setting all properties.
function edit125_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit126_Callback(hObject, eventdata, handles)
% hObject    handle to edit126 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit126 as text
%        str2double(get(hObject,'String')) returns contents of edit126 as a double


% --- Executes during object creation, after setting all properties.
function edit126_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit126 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h1 as text
%        str2double(get(hObject,'String')) returns contents of edit_h1 as a double


% --- Executes during object creation, after setting all properties.
function edit_h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h2 as text
%        str2double(get(hObject,'String')) returns contents of edit_h2 as a double


% --- Executes during object creation, after setting all properties.
function edit_h2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h3 as text
%        str2double(get(hObject,'String')) returns contents of edit_h3 as a double


% --- Executes during object creation, after setting all properties.
function edit_h3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');

end


% --- Executes on button press in pushbutton_Caculate_s_h.
function pushbutton_Caculate_s_h_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_s_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% A1
a11=str2num(handles.edit_a11.String);
a12=str2num(handles.edit_a12.String);
a13=str2num(handles.edit_a13.String);

s_h11=mean(a11);
s_h12=mean(a12);
s_h13=mean(a13);

disp(s_h11);
disp(s_h12);
disp(s_h13);

set(handles.edit_s_h11,'string',s_h11);
set(handles.edit_s_h12,'string',s_h12);
set(handles.edit_s_h13,'string',s_h13);

% A2
a21=str2num(handles.edit_a21.String);
a22=str2num(handles.edit_a22.String);
a23=str2num(handles.edit_a23.String);

s_h21=mean(a21);
s_h22=mean(a22);
s_h23=mean(a23);

disp(s_h21);
disp(s_h22);
disp(s_h23);

set(handles.edit_s_h21,'string',s_h21);
set(handles.edit_s_h22,'string',s_h22);
set(handles.edit_s_h23,'string',s_h23);

% A3
a31=str2num(handles.edit_a31.String);
a32=str2num(handles.edit_a32.String);
a33=str2num(handles.edit_a33.String);

s_h31=mean(a31);
s_h32=mean(a32);
s_h33=mean(a33);

disp(s_h31);
disp(s_h32);
disp(s_h33);

set(handles.edit_s_h31,'string',s_h31);
set(handles.edit_s_h32,'string',s_h32);
set(handles.edit_s_h33,'string',s_h33);

% A4
a41=str2num(handles.edit_a41.String);
a42=str2num(handles.edit_a42.String);
a43=str2num(handles.edit_a43.String);

s_h41=mean(a41);
s_h42=mean(a42);
s_h43=mean(a43);

disp(s_h41);
disp(s_h42);
disp(s_h43);

set(handles.edit_s_h41,'string',s_h41);
set(handles.edit_s_h42,'string',s_h42);
set(handles.edit_s_h43,'string',s_h43);
% 
% handles.s_h11=s_h11;
% handles.s_h12=s_h12;
% handles.s_h13=s_h13;
% handles.s_h21=s_h21;
% handles.s_h22=s_h22;
% handles.s_h23=s_h23;
% handles.s_h31=s_h31;
% handles.s_h32=s_h32;
% handles.s_h33=s_h33;
% handles.s_h41=s_h41;
% handles.s_h42=s_h42;
% handles.s_h43=s_h43;
% guidata(hObject, handles);


function edit_wi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wi as text
%        str2double(get(hObject,'String')) returns contents of edit_wi as a double


% --- Executes during object creation, after setting all properties.
function edit_wi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wj_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wj as text
%        str2double(get(hObject,'String')) returns contents of edit_wj as a double


% --- Executes during object creation, after setting all properties.
function edit_wj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_thi_h.
function pushbutton_thi_h_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_thi_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox("请手动输入调整大小顺序。");
% thi_11=str2num(handles.edit_thi_11.String);
% thi_12=str2num(handles.edit_thi_12.String);
% thi_13=str2num(handles.edit_thi_13.String);
% thi_21=str2num(handles.edit_thi_21.String);
% thi_22=str2num(handles.edit_thi_22.String);
% thi_23=str2num(handles.edit_thi_23.String);
% thi_31=str2num(handles.edit_thi_31.String);
% thi_32=str2num(handles.edit_thi_32.String);
% thi_33=str2num(handles.edit_thi_33.String);
% thi_41=str2num(handles.edit_thi_41.String);
% thi_42=str2num(handles.edit_thi_42.String);
% thi_43=str2num(handles.edit_thi_43.String);
% 
% handles.thi_11=thi_11;
% handles.thi_12=thi_12;
% handles.thi_13=thi_13;
% handles.thi_21=thi_21;
% handles.thi_22=thi_22;
% handles.thi_23=thi_23;
% handles.thi_31=thi_31;
% handles.thi_32=thi_32;
% handles.thi_33=thi_33;
% handles.thi_41=thi_41;
% handles.thi_42=thi_42;
% handles.thi_43=thi_43;
% guidata(hObject, handles);


% --- Executes on button press in pushbutton_Caculate_thita.
function pushbutton_Caculate_thita_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_thita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% A1 3-2-3
wi=str2num(handles.edit_wi.String);
wj=str2num(handles.edit_wj.String);
disp(wi);
disp(wj);
thi_11=str2num(handles.edit_thi_11.String);
thi_12=str2num(handles.edit_thi_12.String);
thi_13=str2num(handles.edit_thi_13.String);
disp(thi_11);
disp(thi_12);
disp(thi_13);
thita_h11=wi(1)*wj(thi_11)/(wi(1)*wj(thi_11)+wi(2)*wj(thi_12)+wi(3)*wj(thi_13));
thita_h12=wi(2)*wj(thi_12)/(wi(1)*wj(thi_11)+wi(2)*wj(thi_12)+wi(3)*wj(thi_13));
thita_h13=wi(3)*wj(thi_13)/(wi(1)*wj(thi_11)+wi(2)*wj(thi_12)+wi(3)*wj(thi_13));

disp(thita_h11);
disp(thita_h12);
disp(thita_h13);

set(handles.edit_thita_h11,'string',thita_h11);
set(handles.edit_thita_h12,'string',thita_h12);
set(handles.edit_thita_h13,'string',thita_h13);

% A2 2-4-2
% wi=str2num(handles.edit_wi.String);
% wj=str2num(handles.edit_wj.String);
% disp(wi);
% disp(wj);
thi_21=str2num(handles.edit_thi_21.String);
thi_22=str2num(handles.edit_thi_22.String);
thi_23=str2num(handles.edit_thi_23.String);
disp(thi_21);
disp(thi_22);
disp(thi_23);
thita_h21=wi(1)*wj(thi_21)/(wi(1)*wj(thi_21)+wi(2)*wj(thi_22)+wi(3)*wj(thi_23));
thita_h22=wi(2)*wj(thi_22)/(wi(1)*wj(thi_21)+wi(2)*wj(thi_22)+wi(3)*wj(thi_23));
thita_h23=wi(3)*wj(thi_23)/(wi(1)*wj(thi_21)+wi(2)*wj(thi_22)+wi(3)*wj(thi_23));

disp(thita_h21);
disp(thita_h22);
disp(thita_h23);

set(handles.edit_thita_h21,'string',thita_h21);
set(handles.edit_thita_h22,'string',thita_h22);
set(handles.edit_thita_h23,'string',thita_h23);

% A3 2-3-3
% wi=str2num(handles.edit_wi.String);
% wj=str2num(handles.edit_wj.String);
% disp(wi);
% disp(wj);
thi_31=str2num(handles.edit_thi_31.String);
thi_32=str2num(handles.edit_thi_32.String);
thi_33=str2num(handles.edit_thi_33.String);
disp(thi_31);
disp(thi_32);
disp(thi_33);
thita_h31=wi(1)*wj(thi_31)/(wi(1)*wj(thi_31)+wi(2)*wj(thi_32)+wi(3)*wj(thi_33));
thita_h32=wi(2)*wj(thi_32)/(wi(1)*wj(thi_31)+wi(2)*wj(thi_32)+wi(3)*wj(thi_33));
thita_h33=wi(3)*wj(thi_33)/(wi(1)*wj(thi_31)+wi(2)*wj(thi_32)+wi(3)*wj(thi_33));

disp(thita_h31);
disp(thita_h32);
disp(thita_h33);

set(handles.edit_thita_h31,'string',thita_h31);
set(handles.edit_thita_h32,'string',thita_h32);
set(handles.edit_thita_h33,'string',thita_h33);

% A4 3-2-3
% wi=str2num(handles.edit_wi.String);
% wj=str2num(handles.edit_wj.String);
% disp(wi);
% disp(wj);
thi_41=str2num(handles.edit_thi_41.String);
thi_42=str2num(handles.edit_thi_42.String);
thi_43=str2num(handles.edit_thi_43.String);
disp(thi_41);
disp(thi_42);
disp(thi_43);
thita_h41=wi(1)*wj(thi_41)/(wi(1)*wj(thi_41)+wi(2)*wj(thi_42)+wi(3)*wj(thi_43));
thita_h42=wi(2)*wj(thi_42)/(wi(1)*wj(thi_41)+wi(2)*wj(thi_42)+wi(3)*wj(thi_43));
thita_h43=wi(3)*wj(thi_43)/(wi(1)*wj(thi_41)+wi(2)*wj(thi_42)+wi(3)*wj(thi_43));

disp(thita_h41);
disp(thita_h42);
disp(thita_h43);

set(handles.edit_thita_h41,'string',thita_h41);
set(handles.edit_thita_h42,'string',thita_h42);
set(handles.edit_thita_h43,'string',thita_h43);
% 
% handles.thita_h11=thita_h11;
% handles.thita_h12=thita_h12;
% handles.thita_h13=thita_h13;
% handles.thita_h21=thita_h21;
% handles.thita_h22=thita_h22;
% handles.thita_h23=thita_h23;
% handles.thita_h31=thita_h31;
% handles.thita_h32=thita_h32;
% handles.thita_h33=thita_h33;
% handles.thita_h41=thita_h41;
% handles.thita_h42=thita_h42;
% handles.thita_h43=thita_h43;
% guidata(hObject, handles);


% --- Executes on button press in pushbutton_Caculate_h.
function pushbutton_Caculate_h_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% h1,A1 3-2-3
h11=str2num(handles.edit_a11.String);
h12=str2num(handles.edit_a12.String);
h13=str2num(handles.edit_a13.String);
disp(h11);
disp(h12);
disp(h13);

thita_h11=str2num(handles.edit_thita_h11.String);
thita_h12=str2num(handles.edit_thita_h12.String);
thita_h13=str2num(handles.edit_thita_h13.String);
disp(thita_h11);
disp(thita_h12);
disp(thita_h13);

i=length(h11);
j=length(h12);
k=length(h13);
disp(i);
disp(j);
disp(k);
% nn=i*j*k;
n0=1;
for n1=1:i
    for n2=1:j
        for n3=1:k
            h1(n0)=1-(1-h11(n1))^(thita_h11)*(1-h12(n2))^thita_h12*(1-h13(n3))^thita_h13;
            disp(n0);
            n0=n0+1;   
        end
    end
end

% h1(1)=1-(1-h11(1))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(1))^thita_h13;
% h1(2)=1-(1-h11(1))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(2))^thita_h13;
% h1(3)=1-(1-h11(1))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(3))^thita_h13;
% h1(4)=1-(1-h11(1))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(1))^thita_h13;
% h1(5)=1-(1-h11(1))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(2))^thita_h13;
% h1(6)=1-(1-h11(1))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(3))^thita_h13;
% 
% h1(7)=1-(1-h11(2))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(1))^thita_h13;
% h1(8)=1-(1-h11(2))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(2))^thita_h13;
% h1(9)=1-(1-h11(2))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(3))^thita_h13;
% h1(10)=1-(1-h11(2))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(1))^thita_h13;
% h1(11)=1-(1-h11(2))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(2))^thita_h13;
% h1(12)=1-(1-h11(2))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(3))^thita_h13;
% 
% h1(13)=1-(1-h11(3))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(1))^thita_h13;
% h1(14)=1-(1-h11(3))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(2))^thita_h13;
% h1(15)=1-(1-h11(3))^(thita_h11)*(1-h12(1))^thita_h12*(1-h13(3))^thita_h13;
% h1(16)=1-(1-h11(3))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(1))^thita_h13;
% h1(17)=1-(1-h11(3))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(2))^thita_h13;
% h1(18)=1-(1-h11(3))^(thita_h11)*(1-h12(2))^thita_h12*(1-h13(3))^thita_h13;

% h2, A2 2-4-2，这里有点问题。
h21=str2num(handles.edit_a21.String);
h22=str2num(handles.edit_a22.String);
h23=str2num(handles.edit_a23.String);
disp(h21);
disp(h22);
disp(h23);

thita_h21=str2num(handles.edit_thita_h21.String);
thita_h22=str2num(handles.edit_thita_h22.String);
thita_h23=str2num(handles.edit_thita_h23.String);
disp(thita_h21);
disp(thita_h22);
disp(thita_h23);

i=length(h21);
j=length(h22);
k=length(h23);
disp(i);
disp(j);
disp(k);
% nn=i*j*k;
n0=1;
for n1=1:i
    for n2=1:j
        for n3=1:k
            h2(n0)=1-(1-h21(n1))^(thita_h21)*(1-h22(n2))^thita_h22*(1-h23(n3))^thita_h23;
            disp(n0);
            n0=n0+1;   
        end
    end
end

% h2(1)=1-(1-h21(1))^(thita_h21)*(1-h22(1))^thita_h22*(1-h23(1))^thita_h23;
% h2(2)=1-(1-h21(1))^(thita_h21)*(1-h22(1))^thita_h22*(1-h23(2))^thita_h23;
% h2(3)=1-(1-h21(1))^(thita_h21)*(1-h22(2))^thita_h22*(1-h23(1))^thita_h23;
% h2(4)=1-(1-h21(1))^(thita_h21)*(1-h22(2))^thita_h22*(1-h23(2))^thita_h23;
% h2(5)=1-(1-h21(1))^(thita_h21)*(1-h22(3))^thita_h22*(1-h23(1))^thita_h23;
% h2(6)=1-(1-h21(1))^(thita_h21)*(1-h22(3))^thita_h22*(1-h23(2))^thita_h23;
% h2(7)=1-(1-h21(1))^(thita_h21)*(1-h22(4))^thita_h22*(1-h23(1))^thita_h23;
% h2(8)=1-(1-h21(1))^(thita_h21)*(1-h22(4))^thita_h22*(1-h23(2))^thita_h23;
% 
% h2(9)=1-(1-h21(2))^(thita_h21)*(1-h22(1))^thita_h22*(1-h23(1))^thita_h23;
% h2(10)=1-(1-h21(2))^(thita_h21)*(1-h22(1))^thita_h22*(1-h23(2))^thita_h23;
% h2(11)=1-(1-h21(2))^(thita_h21)*(1-h22(2))^thita_h22*(1-h23(1))^thita_h23;
% h2(12)=1-(1-h21(2))^(thita_h21)*(1-h22(2))^thita_h22*(1-h23(2))^thita_h23;
% h2(13)=1-(1-h21(2))^(thita_h21)*(1-h22(3))^thita_h22*(1-h23(1))^thita_h23;
% h2(14)=1-(1-h21(2))^(thita_h21)*(1-h22(3))^thita_h22*(1-h23(2))^thita_h23;
% h2(15)=1-(1-h21(2))^(thita_h21)*(1-h22(4))^thita_h22*(1-h23(1))^thita_h23;
% h2(16)=1-(1-h21(2))^(thita_h21)*(1-h22(4))^thita_h22*(1-h23(2))^thita_h23;

% h3,A3 2-3-3
h31=str2num(handles.edit_a31.String);
h32=str2num(handles.edit_a32.String);
h33=str2num(handles.edit_a33.String);
disp(h31);
disp(h32);
disp(h33);

thita_h31=str2num(handles.edit_thita_h31.String);
thita_h32=str2num(handles.edit_thita_h32.String);
thita_h33=str2num(handles.edit_thita_h33.String);
disp(thita_h31);
disp(thita_h32);
disp(thita_h33);

i=length(h31);
j=length(h32);
k=length(h33);
disp(i);
disp(j);
disp(k);
% nn=i*j*k;
n0=1;
for n1=1:i
    for n2=1:j
        for n3=1:k
            h3(n0)=1-(1-h31(n1))^(thita_h31)*(1-h32(n2))^thita_h32*(1-h33(n3))^thita_h33;
            disp(n0);
            n0=n0+1;   
        end
    end
end

% h3(1)=1-(1-h31(1))^(thita_h31)*(1-h32(1))^thita_h32*(1-h33(1))^thita_h33;
% h3(2)=1-(1-h31(1))^(thita_h31)*(1-h32(1))^thita_h32*(1-h33(2))^thita_h33;
% h3(3)=1-(1-h31(1))^(thita_h31)*(1-h32(1))^thita_h32*(1-h33(3))^thita_h33;
% h3(4)=1-(1-h31(1))^(thita_h31)*(1-h32(2))^thita_h32*(1-h33(1))^thita_h33;
% h3(5)=1-(1-h31(1))^(thita_h31)*(1-h32(2))^thita_h32*(1-h33(2))^thita_h33;
% h3(6)=1-(1-h31(1))^(thita_h31)*(1-h32(2))^thita_h32*(1-h33(3))^thita_h33;
% h3(7)=1-(1-h31(1))^(thita_h31)*(1-h32(3))^thita_h32*(1-h33(1))^thita_h33;
% h3(8)=1-(1-h31(1))^(thita_h31)*(1-h32(3))^thita_h32*(1-h33(2))^thita_h33;
% h3(9)=1-(1-h31(1))^(thita_h31)*(1-h32(3))^thita_h32*(1-h33(3))^thita_h33;
% 
% h3(10)=1-(1-h31(2))^(thita_h31)*(1-h32(1))^thita_h32*(1-h33(1))^thita_h33;
% h3(11)=1-(1-h31(2))^(thita_h31)*(1-h32(1))^thita_h32*(1-h33(2))^thita_h33;
% h3(12)=1-(1-h31(2))^(thita_h31)*(1-h32(1))^thita_h32*(1-h33(3))^thita_h33;
% h3(13)=1-(1-h31(2))^(thita_h31)*(1-h32(2))^thita_h32*(1-h33(1))^thita_h33;
% h3(14)=1-(1-h31(2))^(thita_h31)*(1-h32(2))^thita_h32*(1-h33(2))^thita_h33;
% h3(15)=1-(1-h31(2))^(thita_h31)*(1-h32(2))^thita_h32*(1-h33(3))^thita_h33;
% h3(16)=1-(1-h31(2))^(thita_h31)*(1-h32(3))^thita_h32*(1-h33(1))^thita_h33;
% h3(17)=1-(1-h31(2))^(thita_h31)*(1-h32(3))^thita_h32*(1-h33(2))^thita_h33;
% h3(18)=1-(1-h31(2))^(thita_h31)*(1-h32(3))^thita_h32*(1-h33(3))^thita_h33;

% h4,A4 3-2-3
h41=str2num(handles.edit_a41.String);
h42=str2num(handles.edit_a42.String);
h43=str2num(handles.edit_a43.String);
disp(h41);
disp(h42);
disp(h43);

thita_h41=str2num(handles.edit_thita_h41.String);
thita_h42=str2num(handles.edit_thita_h42.String);
thita_h43=str2num(handles.edit_thita_h43.String);
disp(thita_h41);
disp(thita_h42);
disp(thita_h43);

i=length(h41);
j=length(h42);
k=length(h43);
disp(i);
disp(j);
disp(k);
% nn=i*j*k;
n0=1;
for n1=1:i
    for n2=1:j
        for n3=1:k
            h4(n0)=1-(1-h41(n1))^(thita_h41)*(1-h42(n2))^thita_h42*(1-h43(n3))^thita_h43;
            disp(n0);
            n0=n0+1;   
        end
    end
end

% h4(1)=1-(1-h41(1))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(1))^thita_h43;
% h4(2)=1-(1-h41(1))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(2))^thita_h43;
% h4(3)=1-(1-h41(1))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(3))^thita_h43;
% h4(4)=1-(1-h41(1))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(1))^thita_h43;
% h4(5)=1-(1-h41(1))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(2))^thita_h43;
% h4(6)=1-(1-h41(1))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(3))^thita_h43;
% 
% h4(7)=1-(1-h41(2))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(1))^thita_h43;
% h4(8)=1-(1-h41(2))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(2))^thita_h43;
% h4(9)=1-(1-h41(2))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(3))^thita_h43;
% h4(10)=1-(1-h41(2))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(1))^thita_h43;
% h4(11)=1-(1-h41(2))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(2))^thita_h43;
% h4(12)=1-(1-h41(2))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(3))^thita_h43;
% 
% h4(13)=1-(1-h41(3))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(1))^thita_h43;
% h4(14)=1-(1-h41(3))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(2))^thita_h43;
% h4(15)=1-(1-h41(3))^(thita_h41)*(1-h42(1))^thita_h42*(1-h43(3))^thita_h43;
% h4(16)=1-(1-h41(3))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(1))^thita_h43;
% h4(17)=1-(1-h41(3))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(2))^thita_h43;
% h4(18)=1-(1-h41(3))^(thita_h41)*(1-h42(2))^thita_h42*(1-h43(3))^thita_h43;

disp(h1);
disp(h2);
disp(h3);
disp(h4);

set(handles.listbox_h1,'string',num2str(h1));
set(handles.listbox_h2,'string',num2str(h2));
set(handles.listbox_h3,'string',num2str(h3));
set(handles.listbox_h4,'string',num2str(h4));
% 
% handles.h1=h1;
% handles.h2=h2;
% handles.h3=h3;
% handles.h4=h4;
% guidata(hObject, handles);


% --- Executes on selection change in listbox_h2.
function listbox_h2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_h2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_h2


% --- Executes during object creation, after setting all properties.
function listbox_h2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h41_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h41 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h41 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h42_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h42 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h42 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h43_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h43 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h43 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_41_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_41 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_41 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_42_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_42 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_42 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_43_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_43 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_43 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h11 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h11 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h12 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h12 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h13 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h13 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit148_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h21 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h21 as a double


% --- Executes during object creation, after setting all properties.
function edit148_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit149_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h22 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h22 as a double


% --- Executes during object creation, after setting all properties.
function edit149_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit150_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h23 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h23 as a double


% --- Executes during object creation, after setting all properties.
function edit150_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h31 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h31 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h32 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h32 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h33 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h33 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit154_Callback(hObject, eventdata, handles)
% hObject    handle to edit154 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit154 as text
%        str2double(get(hObject,'String')) returns contents of edit154 as a double


% --- Executes during object creation, after setting all properties.
function edit154_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit154 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit155_Callback(hObject, eventdata, handles)
% hObject    handle to edit155 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit155 as text
%        str2double(get(hObject,'String')) returns contents of edit155 as a double


% --- Executes during object creation, after setting all properties.
function edit155_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit155 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_thita.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_thita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Caculate_h.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_h2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_h2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_h2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h41_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h41 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h41 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h42_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h42 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h42 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thita_h43_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thita_h43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thita_h43 as text
%        str2double(get(hObject,'String')) returns contents of edit_thita_h43 as a double


% --- Executes during object creation, after setting all properties.
function edit_thita_h43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thita_h43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_h1.
function listbox_h1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_h1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_h1


% --- Executes during object creation, after setting all properties.
function listbox_h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_h3.
function listbox_h3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_h3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_h3


% --- Executes during object creation, after setting all properties.
function listbox_h3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_h4.
function listbox_h4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_h4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_h4


% --- Executes during object creation, after setting all properties.
function listbox_h4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h1 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h1 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h2 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h2 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h3 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h3 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_h4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_h4 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_h4 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_h4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_s.
function pushbutton_Caculate_s_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h1=str2num(handles.listbox_h1.String);
h2=str2num(handles.listbox_h2.String);
h3=str2num(handles.listbox_h3.String);
h4=str2num(handles.listbox_h4.String);

s_h1=mean(h1);
s_h2=mean(h2);
s_h3=mean(h3);
s_h4=mean(h4);

disp(s_h1);
disp(s_h2);
disp(s_h3);
disp(s_h4);

set(handles.edit_s_h1,'string',s_h1);
set(handles.edit_s_h2,'string',s_h2);
set(handles.edit_s_h3,'string',s_h3);
set(handles.edit_s_h4,'string',s_h4);

% 存入文件
% xuhao,a11,a12,a13,
% s(h11),s(h12),s(h13),thi(11),thi(12),thi(13),...
% thita(11),thita(12),thita(13),h1,s(h1),thi(h1)
% h1,h2,h3,h4
outfile='./out/data.csv';
if exist(string(outfile),'file')
    disp(['Error. \n This file already exists: ',string(outfile)]);
else
    mkdir('./out');
    
    newCell_title={'xuhao','x1','x2','x3',...
               's_x1','s_x2','s_x3','thi_x1','thi_x2','thi_x3',...
               'thita_x1','thita_x2','thita_x3','h','s_h','thi_h'};
    disp(newCell_title);
    newTable = cell2table(newCell_title);
    disp(newTable)
    writetable(newTable,outfile);
end


% 第1行           
a11=handles.edit_a11.String;
a12=handles.edit_a12.String;
a13=handles.edit_a13.String;
s_h11=handles.edit_s_h11.String;
s_h12=handles.edit_s_h12.String;
s_h13=handles.edit_s_h13.String;
thi_11=handles.edit_thi_11.String;
thi_12=handles.edit_thi_12.String;
thi_13=handles.edit_thi_13.String;
thita_h11=handles.edit_thita_h11.String;
thita_h12=handles.edit_thita_h12.String;
thita_h13=handles.edit_thita_h13.String;
h1=handles.listbox_h1.String;
thi_h1=str2num(handles.edit_thi_h1.String);

newCell_title={'xuhao','x1','x2','x3',...
               's_x1','s_x2','s_x3','thi_x1','thi_x2','thi_x3',...
               'thita_x1','thita_x2','thita_x3','h','s_h','thi_h'};
newCell_zhi={1,a11,a12,a13,...
             s_h11,s_h12,s_h13,thi_11,thi_12,thi_13,...
             thita_h11,thita_h12,thita_h13,h1,s_h1,thi_h1};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第2行           
a21=handles.edit_a21.String;
a22=handles.edit_a22.String;
a23=handles.edit_a23.String;
s_h21=handles.edit_s_h21.String;
s_h22=handles.edit_s_h22.String;
s_h23=handles.edit_s_h23.String;
thi_21=handles.edit_thi_21.String;
thi_22=handles.edit_thi_22.String;
thi_23=handles.edit_thi_23.String;
thita_h21=handles.edit_thita_h21.String;
thita_h22=handles.edit_thita_h22.String;
thita_h23=handles.edit_thita_h23.String;
h2=handles.listbox_h2.String;
thi_h2=str2num(handles.edit_thi_h2.String);


newCell_title={'xuhao','x1','x2','x3',...
               's_x1','s_x2','s_x3','thi_x1','thi_x2','thi_x3',...
               'thita_x1','thita_x2','thita_x3','h','s_h','thi_h'};
newCell_zhi={2,a21,a22,a23,...
             s_h21,s_h22,s_h23,thi_21,thi_22,thi_23,...
             thita_h21,thita_h22,thita_h23,h2,s_h2,thi_h2};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第3行           
a31=handles.edit_a31.String;
a32=handles.edit_a32.String;
a33=handles.edit_a33.String;
s_h31=handles.edit_s_h31.String;
s_h32=handles.edit_s_h32.String;
s_h33=handles.edit_s_h33.String;
thi_31=handles.edit_thi_31.String;
thi_32=handles.edit_thi_32.String;
thi_33=handles.edit_thi_33.String;
thita_h31=handles.edit_thita_h31.String;
thita_h32=handles.edit_thita_h32.String;
thita_h33=handles.edit_thita_h33.String;
h3=handles.listbox_h3.String;
thi_h3=str2num(handles.edit_thi_h3.String);

newCell_title={'xuhao','x1','x2','x3',...
               's_x1','s_x2','s_x3','thi_x1','thi_x2','thi_x3',...
               'thita_x1','thita_x2','thita_x3','h','s_h','thi_h'};
newCell_zhi={3,a31,a32,a33,...
             s_h31,s_h32,s_h33,thi_31,thi_32,thi_33,...
             thita_h31,thita_h32,thita_h33,h3,s_h3,thi_h3};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第4行           
a41=handles.edit_a41.String;
a42=handles.edit_a42.String;
a43=handles.edit_a43.String;
s_h41=handles.edit_s_h41.String;
s_h42=handles.edit_s_h42.String;
s_h43=handles.edit_s_h43.String;
thi_41=handles.edit_thi_41.String;
thi_42=handles.edit_thi_42.String;
thi_43=handles.edit_thi_43.String;
thita_h41=handles.edit_thita_h41.String;
thita_h42=handles.edit_thita_h42.String;
thita_h43=handles.edit_thita_h43.String;
h4=handles.listbox_h4.String;
thi_h4=str2num(handles.edit_thi_h4.String);

newCell_title={'xuhao','x1','x2','x3',...
               's_x1','s_x2','s_x3','thi_x1','thi_x2','thi_x3',...
               'thita_x1','thita_x2','thita_x3','h','s_h','thi_h'};
newCell_zhi={4,a41,a42,a43,...
             s_h41,s_h42,s_h43,thi_41,thi_42,thi_43,...
             thita_h41,thita_h42,thita_h43,h4,s_h4,thi_h4};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 写入完成。
disp('数据写入完成。');



function edit_thi_h1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_h1 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_h1 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_h2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_h2 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_h2 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_h2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_h3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_h3 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_h3 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_h3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_h4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_h4 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_h4 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_h4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_thi.
function pushbutton_Caculate_thi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_thi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h1=str2num(handles.listbox_h1.String);
h2=str2num(handles.listbox_h2.String);
h3=str2num(handles.listbox_h3.String);
h4=str2num(handles.listbox_h4.String);

% num1=sizeof(h1);
% num2=sizeof(h2);
% num3=sizeof(h3);
% num4=sizeof(h4);
% 
% for i=1:num1
%     sum=(h1(i)-h1(i+1))^2;
% end

thi_h1=std(h1);
thi_h2=std(h2);
thi_h3=std(h3);
thi_h4=std(h4);

disp(thi_h1);
disp(thi_h2);
disp(thi_h3);
disp(thi_h4);

set(handles.edit_thi_h1,'string',thi_h1);
set(handles.edit_thi_h2,'string',thi_h2);
set(handles.edit_thi_h3,'string',thi_h3);
set(handles.edit_thi_h4,'string',thi_h4);



function edit217_Callback(hObject, eventdata, handles)
% hObject    handle to edit217 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit217 as text
%        str2double(get(hObject,'String')) returns contents of edit217 as a double


% --- Executes during object creation, after setting all properties.
function edit217_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit217 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit218_Callback(hObject, eventdata, handles)
% hObject    handle to edit218 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit218 as text
%        str2double(get(hObject,'String')) returns contents of edit218 as a double


% --- Executes during object creation, after setting all properties.
function edit218_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit218 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit219_Callback(hObject, eventdata, handles)
% hObject    handle to edit219 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit219 as text
%        str2double(get(hObject,'String')) returns contents of edit219 as a double


% --- Executes during object creation, after setting all properties.
function edit219_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit219 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit220_Callback(hObject, eventdata, handles)
% hObject    handle to edit220 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit220 as text
%        str2double(get(hObject,'String')) returns contents of edit220 as a double


% --- Executes during object creation, after setting all properties.
function edit220_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit220 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit221_Callback(hObject, eventdata, handles)
% hObject    handle to edit221 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit221 as text
%        str2double(get(hObject,'String')) returns contents of edit221 as a double


% --- Executes during object creation, after setting all properties.
function edit221_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit221 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit222_Callback(hObject, eventdata, handles)
% hObject    handle to edit222 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit222 as text
%        str2double(get(hObject,'String')) returns contents of edit222 as a double


% --- Executes during object creation, after setting all properties.
function edit222_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit222 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit223_Callback(hObject, eventdata, handles)
% hObject    handle to edit223 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit223 as text
%        str2double(get(hObject,'String')) returns contents of edit223 as a double


% --- Executes during object creation, after setting all properties.
function edit223_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit223 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit224_Callback(hObject, eventdata, handles)
% hObject    handle to edit224 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit224 as text
%        str2double(get(hObject,'String')) returns contents of edit224 as a double


% --- Executes during object creation, after setting all properties.
function edit224_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit224 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit203_Callback(hObject, eventdata, handles)
% hObject    handle to edit203 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit203 as text
%        str2double(get(hObject,'String')) returns contents of edit203 as a double


% --- Executes during object creation, after setting all properties.
function edit203_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit203 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit204_Callback(hObject, eventdata, handles)
% hObject    handle to edit204 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit204 as text
%        str2double(get(hObject,'String')) returns contents of edit204 as a double


% --- Executes during object creation, after setting all properties.
function edit204_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit204 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit205_Callback(hObject, eventdata, handles)
% hObject    handle to edit205 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit205 as text
%        str2double(get(hObject,'String')) returns contents of edit205 as a double


% --- Executes during object creation, after setting all properties.
function edit205_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit205 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit206_Callback(hObject, eventdata, handles)
% hObject    handle to edit206 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit206 as text
%        str2double(get(hObject,'String')) returns contents of edit206 as a double


% --- Executes during object creation, after setting all properties.
function edit206_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit206 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit207_Callback(hObject, eventdata, handles)
% hObject    handle to edit207 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit207 as text
%        str2double(get(hObject,'String')) returns contents of edit207 as a double


% --- Executes during object creation, after setting all properties.
function edit207_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit207 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit208_Callback(hObject, eventdata, handles)
% hObject    handle to edit208 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit208 as text
%        str2double(get(hObject,'String')) returns contents of edit208 as a double


% --- Executes during object creation, after setting all properties.
function edit208_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit208 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit209_Callback(hObject, eventdata, handles)
% hObject    handle to edit209 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit209 as text
%        str2double(get(hObject,'String')) returns contents of edit209 as a double


% --- Executes during object creation, after setting all properties.
function edit209_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit209 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit210_Callback(hObject, eventdata, handles)
% hObject    handle to edit210 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit210 as text
%        str2double(get(hObject,'String')) returns contents of edit210 as a double


% --- Executes during object creation, after setting all properties.
function edit210_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit210 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit211_Callback(hObject, eventdata, handles)
% hObject    handle to edit211 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit211 as text
%        str2double(get(hObject,'String')) returns contents of edit211 as a double


% --- Executes during object creation, after setting all properties.
function edit211_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit211 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit212_Callback(hObject, eventdata, handles)
% hObject    handle to edit212 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit212 as text
%        str2double(get(hObject,'String')) returns contents of edit212 as a double


% --- Executes during object creation, after setting all properties.
function edit212_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit212 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit213_Callback(hObject, eventdata, handles)
% hObject    handle to edit213 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit213 as text
%        str2double(get(hObject,'String')) returns contents of edit213 as a double


% --- Executes during object creation, after setting all properties.
function edit213_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit213 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit214_Callback(hObject, eventdata, handles)
% hObject    handle to edit214 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit214 as text
%        str2double(get(hObject,'String')) returns contents of edit214 as a double


% --- Executes during object creation, after setting all properties.
function edit214_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit214 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit215_Callback(hObject, eventdata, handles)
% hObject    handle to edit215 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit215 as text
%        str2double(get(hObject,'String')) returns contents of edit215 as a double


% --- Executes during object creation, after setting all properties.
function edit215_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit215 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit216_Callback(hObject, eventdata, handles)
% hObject    handle to edit216 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit216 as text
%        str2double(get(hObject,'String')) returns contents of edit216 as a double


% --- Executes during object creation, after setting all properties.
function edit216_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit216 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit191_Callback(hObject, eventdata, handles)
% hObject    handle to edit191 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit191 as text
%        str2double(get(hObject,'String')) returns contents of edit191 as a double


% --- Executes during object creation, after setting all properties.
function edit191_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit191 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit192_Callback(hObject, eventdata, handles)
% hObject    handle to edit192 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit192 as text
%        str2double(get(hObject,'String')) returns contents of edit192 as a double


% --- Executes during object creation, after setting all properties.
function edit192_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit192 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit193_Callback(hObject, eventdata, handles)
% hObject    handle to edit193 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit193 as text
%        str2double(get(hObject,'String')) returns contents of edit193 as a double


% --- Executes during object creation, after setting all properties.
function edit193_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit193 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit194_Callback(hObject, eventdata, handles)
% hObject    handle to edit194 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit194 as text
%        str2double(get(hObject,'String')) returns contents of edit194 as a double


% --- Executes during object creation, after setting all properties.
function edit194_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit194 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit195_Callback(hObject, eventdata, handles)
% hObject    handle to edit195 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit195 as text
%        str2double(get(hObject,'String')) returns contents of edit195 as a double


% --- Executes during object creation, after setting all properties.
function edit195_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit195 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit196_Callback(hObject, eventdata, handles)
% hObject    handle to edit196 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit196 as text
%        str2double(get(hObject,'String')) returns contents of edit196 as a double


% --- Executes during object creation, after setting all properties.
function edit196_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit196 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit197_Callback(hObject, eventdata, handles)
% hObject    handle to edit197 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit197 as text
%        str2double(get(hObject,'String')) returns contents of edit197 as a double


% --- Executes during object creation, after setting all properties.
function edit197_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit197 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit198_Callback(hObject, eventdata, handles)
% hObject    handle to edit198 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit198 as text
%        str2double(get(hObject,'String')) returns contents of edit198 as a double


% --- Executes during object creation, after setting all properties.
function edit198_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit198 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit199_Callback(hObject, eventdata, handles)
% hObject    handle to edit199 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit199 as text
%        str2double(get(hObject,'String')) returns contents of edit199 as a double


% --- Executes during object creation, after setting all properties.
function edit199_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit199 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox6.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox6


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit200_Callback(hObject, eventdata, handles)
% hObject    handle to edit200 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit200 as text
%        str2double(get(hObject,'String')) returns contents of edit200 as a double


% --- Executes during object creation, after setting all properties.
function edit200_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit200 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit201_Callback(hObject, eventdata, handles)
% hObject    handle to edit201 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit201 as text
%        str2double(get(hObject,'String')) returns contents of edit201 as a double


% --- Executes during object creation, after setting all properties.
function edit201_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit201 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit202_Callback(hObject, eventdata, handles)
% hObject    handle to edit202 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit202 as text
%        str2double(get(hObject,'String')) returns contents of edit202 as a double


% --- Executes during object creation, after setting all properties.
function edit202_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit202 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox7.
function listbox7_Callback(hObject, eventdata, handles)
% hObject    handle to listbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox7


% --- Executes during object creation, after setting all properties.
function listbox7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox8.
function listbox8_Callback(hObject, eventdata, handles)
% hObject    handle to listbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox8


% --- Executes during object creation, after setting all properties.
function listbox8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox9.
function listbox9_Callback(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox9


% --- Executes during object creation, after setting all properties.
function listbox9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit167_Callback(hObject, eventdata, handles)
% hObject    handle to edit167 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit167 as text
%        str2double(get(hObject,'String')) returns contents of edit167 as a double


% --- Executes during object creation, after setting all properties.
function edit167_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit167 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit168_Callback(hObject, eventdata, handles)
% hObject    handle to edit168 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit168 as text
%        str2double(get(hObject,'String')) returns contents of edit168 as a double


% --- Executes during object creation, after setting all properties.
function edit168_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit168 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit169_Callback(hObject, eventdata, handles)
% hObject    handle to edit169 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit169 as text
%        str2double(get(hObject,'String')) returns contents of edit169 as a double


% --- Executes during object creation, after setting all properties.
function edit169_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit169 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit170_Callback(hObject, eventdata, handles)
% hObject    handle to edit170 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit170 as text
%        str2double(get(hObject,'String')) returns contents of edit170 as a double


% --- Executes during object creation, after setting all properties.
function edit170_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit170 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit171_Callback(hObject, eventdata, handles)
% hObject    handle to edit171 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit171 as text
%        str2double(get(hObject,'String')) returns contents of edit171 as a double


% --- Executes during object creation, after setting all properties.
function edit171_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit171 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit172_Callback(hObject, eventdata, handles)
% hObject    handle to edit172 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit172 as text
%        str2double(get(hObject,'String')) returns contents of edit172 as a double


% --- Executes during object creation, after setting all properties.
function edit172_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit172 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit173_Callback(hObject, eventdata, handles)
% hObject    handle to edit173 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit173 as text
%        str2double(get(hObject,'String')) returns contents of edit173 as a double


% --- Executes during object creation, after setting all properties.
function edit173_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit173 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit174_Callback(hObject, eventdata, handles)
% hObject    handle to edit174 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit174 as text
%        str2double(get(hObject,'String')) returns contents of edit174 as a double


% --- Executes during object creation, after setting all properties.
function edit174_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit174 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit175_Callback(hObject, eventdata, handles)
% hObject    handle to edit175 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit175 as text
%        str2double(get(hObject,'String')) returns contents of edit175 as a double


% --- Executes during object creation, after setting all properties.
function edit175_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit175 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit176_Callback(hObject, eventdata, handles)
% hObject    handle to edit176 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit176 as text
%        str2double(get(hObject,'String')) returns contents of edit176 as a double


% --- Executes during object creation, after setting all properties.
function edit176_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit176 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit177_Callback(hObject, eventdata, handles)
% hObject    handle to edit177 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit177 as text
%        str2double(get(hObject,'String')) returns contents of edit177 as a double


% --- Executes during object creation, after setting all properties.
function edit177_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit177 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit178_Callback(hObject, eventdata, handles)
% hObject    handle to edit178 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit178 as text
%        str2double(get(hObject,'String')) returns contents of edit178 as a double


% --- Executes during object creation, after setting all properties.
function edit178_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit178 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit179_Callback(hObject, eventdata, handles)
% hObject    handle to edit179 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit179 as text
%        str2double(get(hObject,'String')) returns contents of edit179 as a double


% --- Executes during object creation, after setting all properties.
function edit179_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit179 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit180_Callback(hObject, eventdata, handles)
% hObject    handle to edit180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit180 as text
%        str2double(get(hObject,'String')) returns contents of edit180 as a double


% --- Executes during object creation, after setting all properties.
function edit180_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit181_Callback(hObject, eventdata, handles)
% hObject    handle to edit181 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit181 as text
%        str2double(get(hObject,'String')) returns contents of edit181 as a double


% --- Executes during object creation, after setting all properties.
function edit181_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit181 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit182_Callback(hObject, eventdata, handles)
% hObject    handle to edit182 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit182 as text
%        str2double(get(hObject,'String')) returns contents of edit182 as a double


% --- Executes during object creation, after setting all properties.
function edit182_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit182 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit183_Callback(hObject, eventdata, handles)
% hObject    handle to edit183 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit183 as text
%        str2double(get(hObject,'String')) returns contents of edit183 as a double


% --- Executes during object creation, after setting all properties.
function edit183_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit183 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit184_Callback(hObject, eventdata, handles)
% hObject    handle to edit184 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit184 as text
%        str2double(get(hObject,'String')) returns contents of edit184 as a double


% --- Executes during object creation, after setting all properties.
function edit184_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit184 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit185_Callback(hObject, eventdata, handles)
% hObject    handle to edit185 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit185 as text
%        str2double(get(hObject,'String')) returns contents of edit185 as a double


% --- Executes during object creation, after setting all properties.
function edit185_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit185 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit186_Callback(hObject, eventdata, handles)
% hObject    handle to edit186 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit186 as text
%        str2double(get(hObject,'String')) returns contents of edit186 as a double


% --- Executes during object creation, after setting all properties.
function edit186_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit186 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit187_Callback(hObject, eventdata, handles)
% hObject    handle to edit187 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit187 as text
%        str2double(get(hObject,'String')) returns contents of edit187 as a double


% --- Executes during object creation, after setting all properties.
function edit187_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit187 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit188_Callback(hObject, eventdata, handles)
% hObject    handle to edit188 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit188 as text
%        str2double(get(hObject,'String')) returns contents of edit188 as a double


% --- Executes during object creation, after setting all properties.
function edit188_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit188 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit189_Callback(hObject, eventdata, handles)
% hObject    handle to edit189 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit189 as text
%        str2double(get(hObject,'String')) returns contents of edit189 as a double


% --- Executes during object creation, after setting all properties.
function edit189_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit189 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit190_Callback(hObject, eventdata, handles)
% hObject    handle to edit190 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit190 as text
%        str2double(get(hObject,'String')) returns contents of edit190 as a double


% --- Executes during object creation, after setting all properties.
function edit190_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit190 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
