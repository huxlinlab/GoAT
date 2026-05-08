
function varargout = GoAT_2_1(varargin)
% GOAT_2_1 MATLAB code for GoAT_2_1.fig
%      GOAT_2_1, by itself, creates a new GOAT_2_1 or raises the existing
%      singleton*.
%
%      H = GOAT_2_1 returns the handle to a new GOAT_2_1 or the handle to
%      the existing singleton*.
%
%      GOAT_2_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GOAT_2_1.M with the given input arguments.
%
%      GOAT_2_1('Property','Value',...) creates a new GOAT_2_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GoAT_2_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GoAT_2_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GoAT_2_1

% Last Modified by GUIDE v2.5 15-May-2019 21:54:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GoAT_2_1_OpeningFcn, ...
                   'gui_OutputFcn',  @GoAT_2_1_OutputFcn, ...
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

% --- Executes just before GoAT_2_1 is made visible.
function GoAT_2_1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GoAT_2_1 (see VARARGIN)
global reference
warning('off','all')
GoATLogo = imread('GoATLogo.jpg');
imshow(GoATLogo,'Parent',handles.axes3)

set(handles.axes1,'YTick',[],'XTick',[]);
set(handles.axes2,'YTick',[],'XTick',[]);

filename = ['reference.tif']; %Specify which reference sheet is used
I2 = imread(filename);
if strcmp(filename, 'referenceMarco.png')
    I2 = im2gray(I2);
else
    I2 = rgb2gray(I2);
end
reference = I2;
% Choose default command line output for GoAT_2_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
imshow(reference,'Parent',handles.axes1)
imshow(reference,'Parent',handles.axes2)

% UIWAIT makes GoAT_2_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GoAT_2_1_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton2 (Upload Pre Field).
function pushbutton2_Callback(~, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pre_field
try
[preFile,prePath] = uigetfile('icon.tiff','icon.tif',...
                        'Select an Image File');
pre_field = imread(strcat(prePath,preFile));

pre_field = pre_field(:,:,1:3);
pre_field = rgb2gray(pre_field);
imshow(pre_field,'Parent',handles.axes1)
set(handles.pushbutton6,'visible','on');
catch
    set(0,'units','pixels');
    resolution = get(0,'screensize');
    fig_width = resolution(3)/3;
    fig_height = resolution(4)/6;
    error = 'Error in upload';
    figure('Position',[resolution(3)/2-fig_width/2 resolution(4)/2-fig_height/2 fig_width fig_height],...
    'DockControls','off','MenuBar','none','NumberTitle','off')
    mTextBox = uicontrol('style','text','Position',[0 fig_height*.5 fig_width 25],'FontSize',20);
    set(mTextBox,'String',error)
    successCheck = 0;
    btn = uicontrol('Style', 'pushbutton', 'String', 'Close Error Message','Position', [fig_width/3 fig_height*.2 175 40],...
    'Callback','close gcf','FontSize',15);
end

% --- Executes on button press in pushbutton3 (Upload Post Field).
function pushbutton3_Callback(~, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global post_field
try
[postFile,postPath] = uigetfile('icon.tiff','icon.tif',...
                        'Select an Image File');
post_field = imread(strcat(postPath,postFile));
post_field = post_field(:,:,1:3);
post_field = rgb2gray(post_field);
imshow(post_field,'Parent',handles.axes2)
set(handles.pushbutton7,'visible','on');
catch ME
    set(0,'units','pixels');
    resolution = get(0,'screensize');
    fig_width = resolution(3)/3;
    fig_height = resolution(4)/6;
    error = 'Error in upload';
    figure('Position',[resolution(3)/2-fig_width/2 resolution(4)/2-fig_height/2 fig_width fig_height],...
    'DockControls','off','MenuBar','none','NumberTitle','off')
    mTextBox = uicontrol('style','text','Position',[0 fig_height*.5 fig_width 25],'FontSize',20);
    set(mTextBox,'String',error)
    successCheck = 0;
    btn = uicontrol('Style', 'pushbutton', 'String', 'Close Error Message','Position', [fig_width/3 fig_height*.2 175 40],...
    'Callback','close gcf','FontSize',15);
end

% --- Executes on button press in pushbutton4 (Align).
function pushbutton4_Callback(~, ~, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pre_field post_field reference aligned_postField aligned_preField successCheck
[aligned_preField, aligned_postField, successCheck] = GOAT2align(pre_field, post_field, reference);

% --- Executes on button press in pushbutton5 (Analyze).
function pushbutton5_Callback(~, ~, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global aligned_preField aligned_postField successCheck
[successCheck] = GOAT2masks(aligned_preField, aligned_postField);

% --- Executes on button press in pushbutton6 (Rotate Pre).
function pushbutton6_Callback(~, ~, handles)
global pre_field
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt                      = {'Rotate by X degrees'};    % Asks for subject to enter ID number
dlg_title                   = 'Input';
num_lines                   = 1;
angle                       = inputdlg(prompt,dlg_title,num_lines);
angle = str2num(angle{1});
pre_field = imrotate(pre_field,angle);
imshow(pre_field,'Parent',handles.axes1)

% --- Executes on button press in pushbutton7 (Rotate Post).
function pushbutton7_Callback(~, ~, handles)
global post_field
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt                      = {'Rotate by X degrees'};    % Asks for subject to enter ID number
dlg_title                   = 'Input';
num_lines                   = 1;
angle                       = inputdlg(prompt,dlg_title,num_lines);
angle                       = str2num(angle{1});
post_field = imrotate(post_field,angle);
imshow(post_field,'Parent',handles.axes2)

% --- Executes on button press in pushbutton10 (Reset)
function pushbutton10_Callback(~, ~, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reference
cla(handles.axes1,'reset')
cla(handles.axes2,'reset')
set(handles.axes1,'YTick',[],'XTick',[]);
set(handles.axes2,'YTick',[],'XTick',[]);
imshow(reference,'Parent',handles.axes1)
imshow(reference,'Parent',handles.axes2)
clear global pre_field post_field aligned_postField aligned_preField
filename = 'reference.tif';
I2 = imread(filename);
I2 = rgb2gray(I2);

reference = I2;
