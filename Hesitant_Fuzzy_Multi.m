function varargout = Hesitant_Fuzzy_Multi(varargin)
% HESITANT_FUZZY_MULTI MATLAB code for HESITANT_Fuzzy_Multi.fig
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
%      applied to the GUI before HESITANT_Fuzzy_Multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HESITANT_Fuzzy_Multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

% 赛尔网络下一代互联网技术创新项目(NGII20180502)
% 多因素决策问题
% 1:列出各个专家偏好的属性权重；
% 2:列出各个属性本身相互关联的重要性程度；
% 3:列出各个视频（方案）的评估值（犹豫模糊数）；
% 属性权重标准化（结合专家）；
% 加权评估意见；
% 标准化，效益型，可取消这步；

% Modified by hankun,zhangwensheng,chenpeiying v1.0 4-Apr-2022 10:23:12
% Last Modified by hankun,zhangwensheng,chenpeiying v1.0 20-May-2022 10:54:12


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

% --- Executes just before HESITANT_Fuzzy_Multi is made visible.
function HESITANT_Fuzzy_Multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HESITANT_Fuzzy_Multi (see VARARGIN)

% Choose default command line output for HESITANT_Fuzzy_Multi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HESITANT_Fuzzy_Multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HESITANT_Fuzzy_Multi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_wav_load.
function pushbutton_wav_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.wav'},'Load Wav File');
[x,Fs] = audioread([PathName '/' FileName]);
x = x(:,1);
handles.x = x ./ max(abs(x));
handles.Fs = Fs;
axes(handles.axes_signal);
handles.Time = 0:1/Fs:(length(handles.x)-1)/Fs;
plot(handles.Time, handles.x);
axis([0 max(handles.Time) -1 1]);
xlabel('Time (s)')
ylabel('Magnitude')

axes(handles.axes_signalSpec);
Fn = handles.Fs/2;
Fy = fft(handles.x)/length(handles.x);
Fv = linspace(0, 1, fix(length(handles.x)/2) + 1)*Fn;
Iv = 1:length(Fv);
plot(Fv, abs(Fy(Iv,1))*2)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

filename=FileName(1:end-4);
file_in=[filename,'.wav'];
file_out_8k=[filename,'_8k.wav'];
str_cmd_8k=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out_8k];
system(str_cmd_8k);   

outfile='./out/result_fs16k.csv';
if exist(string(outfile),'file')
    disp(['Error. \n This file already exists: ',string(outfile)]);
else
    mkdir('./out');
    newCell_title={'filename','codec',...
        'filesiez','fs','mse','psnr','mHFDde','mHFDde_wav'};
    disp(newCell_title);
    newTable = cell2table(newCell_title);
    disp(newTable)
    writetable(newTable,outfile);
end

handles.filename_fs16k_outfile=outfile;
handles.fileLoaded = 1;
handles.filename=filename;
handles.PathName=PathName;
handles.FileName=FileName;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_playSignal.
function pushbutton_playSignal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_playSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)
    sound(handles.x, handles.Fs);
end


% --- Executes on button press in pushbutton_mp3_generate.
function pushbutton_mp3_generate_Callback(hObject, eventdata, handles)
% function pushbutton_genMp3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp3_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


% --- Executes on button press in pushbutton_mp3_play.
function pushbutton_mp3_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp3_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);   


% --- Executes on button press in pushbutton_acc_generate.
function pushbutton_acc_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acc_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


function edit_aac_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mp3_calculate.
function pushbutton_mp3_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp3_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
mse=sqrt(err);
disp(['MSE=' num2str(mse) ]);
MAXVAL=65535;
psnr = 20*log10(MAXVAL/mse); 
disp(['PSNR=' num2str(psnr)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_mp3_segSNR,'string',ssnr);
% disp(ssnr);

% ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFDde
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=1600;step=800;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH(xx_0,win,step);
    [HBH_de_1]=FD_HBH(xx_1,win,step);
    [HBH_de_2]=FD_HBH(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
disp(mHFDde);

% 编码方式
codec='mp3';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
mHFDde_wav=handles.mHFDde_wav;
% 存入文件
% codec,fs,vr,mse,psnr,ssim
% mp3,
outfile=handles.filename_fs16k_outfile;
newCell_title={'filename','codec',...
    'filesize','fs','mse','psnr','mHFDde','mHFDde_wav'};
 
newCell_zhi={filename,codec,...
            filesize,fs,mse,psnr,mHFDde,mHFDde_wav};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_mp3_mse,'string',mse);
set(handles.edit_mp3_psnr,'string',psnr);
set(handles.edit_mp3_mHFD,'string',mHFDde);

end


function edit_mp3_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_flac_8k_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_flac_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_ogg_8k_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_ssim (see GCBO) 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_ogg_8k_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in pushbutton_aac_calculate.
function pushbutton_aac_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aac_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
mse=sqrt(err);
disp(['MSE=' num2str(mse) ]);
MAXVAL=65535;
psnr = 20*log10(MAXVAL/mse); 
disp(['PSNR=' num2str(psnr)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_aac_segSNR,'string',ssnr);
% disp(ssnr);

%ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFD
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=1600;step=800;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH(xx_0,win,step);
    [HBH_de_1]=FD_HBH(xx_1,win,step);
    [HBH_de_2]=FD_HBH(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
disp(mHFDde);

% 编码方式
codec='aac';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
mHFDde_wav=handles.mHFDde_wav;
% 存入文件
% codec,fs,vr,mse,psnr,ssim
% aac,
outfile=handles.filename_fs16k_outfile;
newCell_title={'filename','codec',...
    'filesize','fs','mse','psnr','mHFDde','mHFDde_wav'};
 
newCell_zhi={filename,codec,...
            filesize,fs,mse,psnr,mHFDde,mHFDde_wav};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_aac_mse,'string',mse);
set(handles.edit_aac_psnr,'string',psnr);
set(handles.edit_aac_mHFD,'string',mHFDde);

end
    

% --- Executes on button press in pushbutton_wav_generateAll.
function pushbutton_wav_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);

filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);

filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);

filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);
 

% --- Executes on button press in pushbutton_flac_8k_generate.
function pushbutton_flac_8k_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_flac_8k_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


% --- Executes on button press in pushbutton_flac_8k_calculate.
function pushbutton_flac_8k_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_flac_8k_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
MSE=sqrt(err);
disp(['MSE=' num2str(MSE) ]);
MAXVAL=65535;
PSNR = 20*log10(MAXVAL/MSE); 
set(handles.edit_flac_8k_mse,'string',MSE);
set(handles.edit_flac_8k_psnr,'string',PSNR);
disp(['PSNR=' num2str(PSNR)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_mp3_segSNR,'string',ssnr);
% disp(ssnr);

%ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFD
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=800;step=400;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH_8k(xx_0,win,step);
    [HBH_de_1]=FD_HBH_8k(xx_1,win,step);
    [HBH_de_2]=FD_HBH_8k(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
set(handles.edit_flac_8k_mHFD,'string',mHFDde);
disp(mHFDde);

end


% --- Executes on button press in pushbutton_flac_generate.
function pushbutton_flac_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_flac_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


function edit_flac_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_flac_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_flac_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_flac_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_flac_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_flac_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wma_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wma_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wma_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_wma_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_wma_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wma_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_flac_calculate.
function pushbutton_flac_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_flac_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
% 这里不同于mp3，c1x=131839,c2x=131584,c1大。
% 也就是wma长度变短了，相对于wav。
% deltx=(c1x-c2x)/2;
% a=zeros(1,deltx);
% y2=[a,y2(:,:),a];
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
mse=sqrt(err);
disp(['MSE=' num2str(mse) ]);
MAXVAL=65535;
psnr = 20*log10(MAXVAL/mse); 
disp(['PSNR=' num2str(psnr)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_wma_segSNR,'string',ssnr);
% disp(ssnr);

%ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFD
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=1600;step=800;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH(xx_0,win,step);
    [HBH_de_1]=FD_HBH(xx_1,win,step);
    [HBH_de_2]=FD_HBH(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
disp(mHFDde);

% 编码方式
codec='flac';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
mHFDde_wav=handles.mHFDde_wav;
% 存入文件
% codec,fs,vr,mse,psnr,ssim
% flac,
outfile=handles.filename_fs16k_outfile;
newCell_title={'filename','codec',...
    'filesize','fs','mse','psnr','mHFDde','mHFDde_wav'};
 
newCell_zhi={filename,codec,...
            filesize,fs,mse,psnr,mHFDde,mHFDde_wav};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_flac_mse,'string',mse);
set(handles.edit_flac_psnr,'string',psnr);
set(handles.edit_flac_mHFD,'string',mHFDde);

end


% --- Executes on button press in pushbutton_aac_8k_generate.
function pushbutton_aac_8k_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aac_8k_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


% --- Executes on button press in pushbutton_aac_8k_calculate.
function pushbutton_aac_8k_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aac_8k_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
MSE=sqrt(err);
disp(['MSE=' num2str(MSE) ]);
MAXVAL=65535;
PSNR = 20*log10(MAXVAL/MSE); 
set(handles.edit_aac_8k_mse,'string',MSE);
set(handles.edit_aac_8k_psnr,'string',PSNR);
disp(['PSNR=' num2str(PSNR)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_mp3_segSNR,'string',ssnr);
% disp(ssnr);

%ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFD
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=800;step=400;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH_8k(xx_0,win,step);
    [HBH_de_1]=FD_HBH_8k(xx_1,win,step);
    [HBH_de_2]=FD_HBH_8k(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
set(handles.edit_aac_8k_mHFD,'string',mHFDde);
disp(mHFDde);

end


% --- Executes on button press in pushbutton_mp3_8k_calculate.
function pushbutton_mp3_8k_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp3_8k_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
MSE=sqrt(err);
disp(['MSE=' num2str(MSE) ]);
MAXVAL=65535;
PSNR = 20*log10(MAXVAL/MSE); 
set(handles.edit_mp3_8k_mse,'string',MSE);
set(handles.edit_mp3_8k_psnr,'string',PSNR);
disp(['PSNR=' num2str(PSNR)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_mp3_segSNR,'string',ssnr);
% disp(ssnr);

%ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFD
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=800;step=400;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH_8k(xx_0,win,step);
    [HBH_de_1]=FD_HBH_8k(xx_1,win,step);
    [HBH_de_2]=FD_HBH_8k(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
set(handles.edit_mp3_8k_mHFD,'string',mHFDde);
disp(mHFDde);

end


function edit_mp3_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_flac_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_flac_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_flac_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_flac_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_flac_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_flac_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wma_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wma_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wma_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_wma_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_wma_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wma_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_flac_8k_play.
function pushbutton_flac_8k_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_flac_8k_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_flac_play.
function pushbutton_flac_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_flac_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_aac_8k_play.
function pushbutton_aac_8k_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aac_8k_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_mp3_8k_play.
function pushbutton_mp3_8k_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp3_8k_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_mp3_8k_generate.
function pushbutton_mp3_8k_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp3_8k_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


% --- Executes on button press in pushbutton_aac_play.
function pushbutton_aac_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aac_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_wav_play.
function pushbutton_wav_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];
str_cmd=['ffplay ',file_in];
system(str_cmd);  


function edit_aac_8k_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_8k_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_8k_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_8k_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_8k_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_8k_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_8k_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_8k_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_8k_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_8k_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_8k_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_8k_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_8k_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_8k_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_8k_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_8k_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_8k_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_8k_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_8k_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_8k_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_8k_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_8k_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_8k_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_8k_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_8k_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_8k_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_8k_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_8k_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_8k_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_8k_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_8k_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_8k_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_flac_8k_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_flac_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_flac_8k_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_flac_8k_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_flac_8k_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_flac_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wma_8k_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wma_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wma_8k_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_wma_8k_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_wma_8k_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wma_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_flac_8k_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_flac_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_flac_8k_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_flac_8k_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_flac_8k_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_flac_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wma_8k_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wma_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wma_8k_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_wma_8k_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_wma_8k_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wma_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ogg_8k_generate.
function pushbutton_ogg_8k_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ogg_8k_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


% --- Executes on button press in pushbutton_ogg_8k_calculate.
function pushbutton_ogg_8k_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ogg_8k_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
MSE=sqrt(err);
disp(['MSE=' num2str(MSE) ]);
MAXVAL=65535;
PSNR = 20*log10(MAXVAL/MSE); 
set(handles.edit_ogg_8k_mse,'string',MSE);
set(handles.edit_ogg_8k_psnr,'string',PSNR);
disp(['PSNR=' num2str(PSNR)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_mp3_segSNR,'string',ssnr);
% disp(ssnr);

%ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFD
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=800;step=400;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH_8k(xx_0,win,step);
    [HBH_de_1]=FD_HBH_8k(xx_1,win,step);
    [HBH_de_2]=FD_HBH_8k(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
set(handles.edit_ogg_8k_mHFD,'string',mHFDde);
disp(mHFDde);

end


% --- Executes on button press in pushbutton_ogg_8k_play.
function pushbutton_ogg_8k_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ogg_8k_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


function edit_ogg_8k_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_8k_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_8k_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_8k_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ogg_8k_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_8k_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_8k_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_8k_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ogg_8k_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_8k_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_8k_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_8k_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ogg_8k_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_8k_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_8k_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_8k_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ogg_generate.
function pushbutton_ogg_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ogg_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 16k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 16k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


function edit_ogg_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ogg_segSNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_segSNR as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_segSNR as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_segSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_segSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ogg_calculate.
function pushbutton_ogg_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ogg_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];

[y1,fs1]=audioread(file_in);
[y2,fs2]=audioread(file_out2);
y1=y1(:,1);
y2=y2(:,1);
[c1x,c1y]=size(y1);
[c2x,c2y]=size(y2);
disp(['c1x=' num2str(c1x) ]);
disp(['c2x=' num2str(c2x) ]);
deltx=(c2x-c1x)/2;
y2=y2((deltx+1):(c2x-deltx),:);
[c2x,c2y]=size(y2);
disp(['c2x=' num2str(c2x) ]);
disp(['c1y=' num2str(c1y) ]);
disp(['c2y=' num2str(c2y) ]);
R=c1x;
C=c1y;
err = sum((y1-y2).^2)/(R*C);
mse=sqrt(err);
disp(['MSE=' num2str(mse) ]);
MAXVAL=65535;
psnr = 20*log10(MAXVAL/mse); 
disp(['PSNR=' num2str(psnr)]);

% fprintf('testing narrowband.\n');
% % pesq=pesq_mex(y1, y2, fs1, 'narrowband');
% pesq=PESQ_MEX(y1, y2, fs1, 'narrowband');
% set(handles.edit_mp3_pesq,'string',pesq);
% disp(pesq);

% fprintf('testing ssnr.\n');
% ssnr = segsnr( y1, y2, fs1 );
% set(handles.edit_ogg_segSNR,'string',ssnr);
% disp(ssnr);

%ssim
% audioIn = audioIn./max(abs(audioIn));
% sound(audioIn,fs)
% S = melSpectrogram(audioIn,fs)

% mHFD
if ~exist(string(file_out2),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_out2);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=1600;step=800;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH(xx_0,win,step);
    [HBH_de_1]=FD_HBH(xx_1,win,step);
    [HBH_de_2]=FD_HBH(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
mHFDde=HBH1600800de_mean;
disp(mHFDde);

% 编码方式
codec='ogg';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
mHFDde_wav=handles.mHFDde_wav;
% 存入文件
% codec,fs,vr,mse,psnr,ssim
% ogg,
outfile=handles.filename_fs16k_outfile;
newCell_title={'filename','codec',...
    'filesize','fs','mse','psnr','mHFDde','mHFDde_wav'};
 
newCell_zhi={filename,codec,...
            filesize,fs,mse,psnr,mHFDde,mHFDde_wav};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_ogg_mse,'string',mse);
set(handles.edit_ogg_psnr,'string',psnr);
set(handles.edit_ogg_mHFD,'string',mHFDde);

end


function edit_ogg_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ogg_pesq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_pesq as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_pesq as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_pesq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_pesq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ogg_play.
function pushbutton_ogg_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ogg_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


function edit_mp3_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wma_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wma_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wma_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_wma_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_wma_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wma_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_flac_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_flac_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_flac_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_flac_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_flac_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_flac_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ogg_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ogg_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_ogg_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ogg_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ogg_8k_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_8k_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_8k_ssim as a double


function edit_ogg_8k_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ogg_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ogg_8k_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_ogg_8k_mHFD as a double


function edit_wma_8k_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wma_8k_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wma_8k_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_wma_8k_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_wma_8k_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wma_8k_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_flac_8k_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_flac_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_flac_8k_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_flac_8k_mHFD as a double


function edit_aac_8k_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_8k_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_8k_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_8k_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_aac_8k_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aac_8k_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_aac_8k_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_aac_8k_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aac_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_8k_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_8k_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_8k_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_8k_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mp3_8k_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp3_8k_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_mp3_8k_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_mp3_8k_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp3_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wav_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wav_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wav_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_wav_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_wav_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wav_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_wav_calculate.
function pushbutton_wav_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];

% mHFD
if ~exist(string(file_in),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_in);
    x=x(:,1);
%     disp(x);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=1600;step=800;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH(xx_0,win,step);
    [HBH_de_1]=FD_HBH(xx_1,win,step);
    [HBH_de_2]=FD_HBH(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
m_HFD_de=HBH1600800de_mean;
set(handles.edit_wav_mHFD,'string',m_HFD_de);
disp(m_HFD_de);

handles.mHFDde_wav=m_HFD_de;
guidata(hObject, handles);

end


% --- Executes on button press in pushbutton_wav_8k_load.
function pushbutton_wav_8k_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_8k_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.wav'},'Load Wav File');
[x,Fs] = audioread([PathName '/' FileName]);
x = x(:,1);
% assignin('base','Fs',Fs);
handles.x = x ./ max(abs(x));
handles.Fs = Fs;
axes(handles.axes_signal_8k);
handles.Time = 0:1/Fs:(length(handles.x)-1)/Fs;
plot(handles.Time, handles.x);
axis([0 max(handles.Time) -1 1]);
xlabel('Time (s)')
ylabel('Magnitude')

axes(handles.axes_signalSpec_8k);
Fn = handles.Fs/2;
Fy = fft(handles.x)/length(handles.x);
Fv = linspace(0, 1, fix(length(handles.x)/2) + 1)*Fn;
Iv = 1:length(Fv);
plot(Fv, abs(Fy(Iv,1))*2)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

filename=FileName(1:end-4);
% file_in=[filename,'.wav'];
% file_out_8k=[filename,'_8k.wav'];
% str_cmd_8k=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out_8k];
% system(str_cmd_8k);    

handles.fileLoaded = 1;
handles.filename_8k=filename;
handles.PathName_8k=PathName;
handles.FileName_8k=FileName;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_wav_8k_generateAll.
function pushbutton_wav_8k_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_8k_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];

fses = [8000 32000 44000 48000 64000];
file_fs = fses(get(handles.popupmenu_file_fs, 'value'));
disp(file_fs);

str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);

file_out1=[filename,'.aac'];
file_out2=[filename,'_aac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);

file_out1=[filename,'.flac'];
file_out2=[filename,'_flac.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);

file_out1=[filename,'.ogg'];
file_out2=[filename,'_ogg.wav'];
str_cmd1=['ffmpeg -i ',file_in,' -ac 1 -ar 8k ',file_out1];
str_cmd2=['ffmpeg -i ',file_out1,' -ac 1 -ar 8k ',file_out2];
system(str_cmd1);    
system(str_cmd2);


% --- Executes on button press in pushbutton_wav_8k_play.
function pushbutton_wav_8k_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_8k_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];
str_cmd=['ffplay ',file_in];
system(str_cmd);  


function edit_wav_8k_mHFD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wav_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wav_8k_mHFD as text
%        str2double(get(hObject,'String')) returns contents of edit_wav_8k_mHFD as a double


% --- Executes during object creation, after setting all properties.
function edit_wav_8k_mHFD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wav_8k_mHFD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_wav_8k_calculate.
function pushbutton_wav_8k_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_8k_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_8k;
file_in=[filename,'.wav'];
file_out1=[filename,'.mp3'];
file_out2=[filename,'_mp3.wav'];

% mHFD
if ~exist(string(file_in),'file')
    disp(['Error. \n No this file: ',string(file_out2)]);
else
    [x fs]=audioread(file_in);
    x=x(:,1);
%     disp(x);
    tt=length(x)/fs;
    start_time = 0;
    end_time = tt;
    sig=x((fs*start_time+1):fs*end_time);
    xx=double(sig);
    
    win=800;step=400;
    xx_left=[0,0,0,0,0,0,0,0]';
    xx_0=[xx_left;xx(1:end-8)];
    xx_1=xx;
    xx_2=[xx(9:end);xx_left];

    [HBH_de_0]=FD_HBH_8k(xx_0,win,step);
    [HBH_de_1]=FD_HBH_8k(xx_1,win,step);
    [HBH_de_2]=FD_HBH_8k(xx_2,win,step);
    HBH1600800de=(HBH_de_0+HBH_de_1+HBH_de_2)/3;
    HBH1600800de_mean=mean(HBH1600800de);
    
m_HFD_de=HBH1600800de_mean;
set(handles.edit_wav_8k_mHFD,'string',m_HFD_de);
disp(m_HFD_de);

end


% HFD
% function [HBH_xx,HBH_de,HBH_dede] = FD_HBH(serie,win,step)
function [HBH_de] = FD_HBH(serie,win,step)
    win=win;step=step;
    xx=enframe(serie,win,step);

    for i=1:size(xx,1)-1
        x1=xx(i,:);x2=xx(i+1,:);
        y=(x1+x2)/2; 
        s=y;
        t_HBH=abs(2-Higuchi_FD(s,16));
        m(i,:)=t_HBH;
    end

    dtm=zeros(size(m));
    for i=3:size(m,1)-2
        dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);
    end
    dtm=dtm/10;

% HBH_xx=m;
HBH_de=dtm;


% HFD_8k
% function [HBH_xx,HBH_de,HBH_dede] = FD_HBH(serie,win,step)
function [HBH_de] = FD_HBH_8k(serie,win,step)
    win=win;step=step;
    xx=enframe(serie,win,step);

    for i=1:size(xx,1)-1
        x1=xx(i,:);x2=xx(i+1,:);
        y=(x1+x2)/2;
        s=y;
        t_HBH=abs(2-Higuchi_FD(s,8));
        m(i,:)=t_HBH;
    end

    dtm=zeros(size(m));
    for i=3:size(m,1)-2
        dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);
    end
    dtm=dtm/10;

% HBH_xx=m;
HBH_de=dtm;


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
