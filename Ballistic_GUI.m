function varargout = Ballistic_GUI(varargin)
% BALLISTIC_GUI MATLAB code for Ballistic_GUI.fig
%      BALLISTIC_GUI, by itself, creates a new BALLISTIC_GUI or raises the existing
%      singleton*.
%
%      H = BALLISTIC_GUI returns the handle to a new BALLISTIC_GUI or the handle to
%      the existing singleton*.
%
%      BALLISTIC_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BALLISTIC_GUI.M with the given input arguments.
%
%      BALLISTIC_GUI('Property','Value',...) creates a new BALLISTIC_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ballistic_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ballistic_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ballistic_GUI

% Last Modified by GUIDE v2.5 07-Dec-2021 22:30:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ballistic_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Ballistic_GUI_OutputFcn, ...
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


% --- Executes just before Ballistic_GUI is made visible.
function Ballistic_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ballistic_GUI (see VARARGIN)

% Choose default command line output for Ballistic_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ballistic_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clc;
format long;

%% ��������� �����
global rocketParams
rocketParams = struct('m0', 20,'mk', 5, 'alfa', 0.3, 'U', 1.05, 'c', 1.1, 'S', 0.001, 'Vctrl', 0.343, 'teta', 10);

% rocketParams.m0       :[��] - ��������� ����� ������, ������������ ��������
% rocketParams.mk       :[��] - �������� ����� + ����������� �����
% rocketParams.alfa     :[��/�] - ������ �������
% rocketParams.U        :[��/�] - �������� ��������� ����� �� �����
% rocketParams.c        : - ����������� �������� �������������
% rocketParams.S        :[��] - ������� ����������� ������� ������
% rocketParams.Vctrl	:[��/�] - �������� ��������, ��� ������� ����������� �������������� ������������ � ���������� �������
%%

%% ��������� �����
global globalParams
globalParams = struct('g', 0.0098,'R', 6371);

% globalParams.g	:[��/�] - �������������� ����������
% globalParams.R	:[��] - ������ �������
%%

%% ��������� ��� ������� ���� �������������
global useFs
useFs = false;

% useFs	:[boolean] - ���� ������������� ��������� ��� ����
% �������������
%%

% ����� ��������� ������� �� ��������� ���������� ������� �������
var_g_edittext_Callback(handles.var_g_edittext, eventdata, handles);
var_R_edittext_Callback(handles.var_R_edittext, eventdata, handles);
var_FS_checkbox_Callback(handles.var_FS_checkbox, eventdata, handles)

global PathAxes VelAxes

PathAxes = handles.path_axes;
VelAxes = handles.vel_axes;

grid (PathAxes, 'on')                   % ����� ������������ ����� � �������
title(PathAxes, '����������')           % ������� ����
xlabel(PathAxes, 'x(t)')                % ������� ��� �������
ylabel(PathAxes, 'y(t)')                % ������� ��� �������
set(get(PathAxes,'ylabel'),'rotation',0)% �������������� ��������� ��� �������
hold(PathAxes, 'on');                   % 
grid (VelAxes, 'on')                   % ����� ������������ ����� � �������
title(VelAxes, '������� ����������')   % ������� ����
xlabel(VelAxes, 'y(t)')                % ������� ��� �������
ylabel(VelAxes, 'V(t)')                % ������� ��� �������
set(get(VelAxes,'ylabel'),'rotation',0)% �������������� ��������� ��� �������
hold(VelAxes, 'on');


% --- Outputs from this function are returned to the command line.
function varargout = Ballistic_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function var_g_edittext_Callback(hObject, eventdata, handles)
% hObject    handle to var_g_edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of var_g_edittext as text
%        str2double(get(hObject,'String')) returns contents of var_g_edittext as a double
global globalParams

globalParams.g = GetValue(hObject);



% --- Executes during object creation, after setting all properties.
function var_g_edittext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var_g_edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in var_FS_checkbox.
function var_FS_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to var_FS_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of var_FS_checkbox
global useFs
useFs = ~get(hObject,'Value');


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3



function var_R_edittext_Callback(hObject, eventdata, handles)
% hObject    handle to var_R_edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of var_R_edittext as text
%        str2double(get(hObject,'String')) returns contents of var_R_edittext as a double
global globalParams

globalParams.R = GetValue(hObject);


% --- Executes during object creation, after setting all properties.
function var_R_edittext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var_R_edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in params_pushbutton.
function params_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to params_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rocketParams

fig = figure('Position', [550 400 550 140], 'numbertitle','off', 'Name', '���������');

data = struct2cell(rocketParams);
cnames = fieldnames(rocketParams);
rnames = 1:numel(rocketParams);

uiTable = uitable('Parent', fig, 'Data', data(:, :)', 'ColumnName', cnames,... 
              'RowName', rnames, 'Position', [20 20 510 100]);
set(uiTable, 'ColumnEditable', true);

uiTable.CellEditCallback = @uiTable_Callback;

clear variables


% --- Executes on button press in start_pushbutton.
function start_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to start_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ballistic_Main();

% --- Executes on button press in clear_pushbutton.
function clear_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clear_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.path_axes)
cla(handles.vel_axes)


% --- Executes on button press in addnew_pushbutton.
function addnew_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to addnew_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rocketParams

N = size(rocketParams, 2);

% rocketParams.m0       :[��] - ��������� ����� ������, ������������ ��������
% rocketParams.mk       :[��] - �������� ����� + ����������� �����
% rocketParams.alfa     :[��/�] - ������ �������
% rocketParams.U        :[��/�] - �������� ��������� ����� �� �����
% rocketParams.c        : - ����������� �������� �������������
% rocketParams.S        :[��] - ������� ����������� ������� ������
% rocketParams.Vctrl	:[��/�] - �������� ��������, ��� ������� ����������� �������������� ������������ � ���������� �������
% 'm0', 20,'mk', 5, 'alfa', 0.3, 'U', 1.05, 'c', 1.1, 'S', 0.001, 'Vctrl', 0.343

Ttitle = ['��������� ����� (', num2str(N + 1), ') ������'];
Stitle = {'��������� ����� ������, ������������ �������� [��]', ...
          '�������� ����� + ����������� ����� [��]', ...
          '������ ������� [��/�]', ...
          '�������� ��������� ����� �� ����� [��/�]', ...
          '����������� �������� ������������� (����������� ��� ������� �������������)', ...
          '������� ����������� ������� ������ (����������� ��� ������� �������������) [��]', ...
          '��������� �������� �� �������� (�� ��������� - ������� �����) [��/�]', ...
          '���� �������� [�������]'}; ...
         
definput = {num2str(20), ...                 % �������� �� ��������� ��� ����������� ����
            num2str(5), ...                 
            num2str(0.3), ...
            num2str(1.05), ...
            num2str(1.1), ...
            num2str(0.001), ...
            num2str(0.343), ...
            num2str(10) };
answer = inputdlg(Stitle, Ttitle, [1 100], definput);   % �������� ���������� ����������� ����, ����������� ���� ��� ��������� ����� �������������� ������, 
                                                        % � ������������� ��������, ��������� �������������

if ~any(cellfun(@isempty, answer))  % ��������� ��� �� ������ �������� � �������
    rocketParams(N + 1).m0 = str2num(answer{1});
    rocketParams(N + 1).mk = str2num(answer{2});
    rocketParams(N + 1).alfa = str2num(answer{3});
    rocketParams(N + 1).U = str2num(answer{4});
    rocketParams(N + 1).c = str2num(answer{5});
    rocketParams(N + 1).S = str2num(answer{6});
    rocketParams(N + 1).Vctrl = str2num(answer{7});
    rocketParams(N + 1).teta = str2num(answer{8});
end

clear variables



% --- Executes on button press in remove_pushbutton.
function remove_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to remove_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rocketParams

N = size(rocketParams, 2);

if (N-1) >= 1
    Ttitle = ['�������� ������ ��������'];
    Stitle = {'�������� ����� ������� ������� (�� ��������� - ���������)'};
    definput = {num2str(N)};
    answer = inputdlg(Stitle, Ttitle, [1 100], definput);   % �������� ���������� ����������� ����, ����������� ���� ��� ��������� ����� �������������� ������, 
                                                            % � ������������� ��������, ��������� �������������
    n = str2num(answer{1});

    if ~cellfun(@isempty, answer)  % ��������� ��� �� ������ �������� � ������
        rocketParams(n) = [];
    end
end


% --- Executes on button press in pinfo_pushbutton.
function pinfo_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pinfo_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts.Interpreter = 'tex';
% Include the desired Default answer
opts.Default = 'ok';
% Use the TeX interpreter to format the question
quest = {   '������ ���������: ������ ���������� ����� �������������� ������.', ...
            '��� ������� ������ ������������� ��� ���������� �����������', ...
            '����� ��� ���������� ������������ �������� (������ ����� ����������', ...
            '�������� ��������), ��� ���������� ������, ��������� ��������������', ...
            '������������ ��������.', ...
            '', ...
            '������� ����. ���������', ...
            '', ...
            '������������ ������ �� ����������� ��������:', ...
            'm(t)*dV/dt = alfa*U - Fs - g*R^2/(R+h)^2', ...
            'dy/dt = V', ...
            '��� U - �������� ��������� ����� �� �����', ...
            'alfa - �������� ��������� �����', ...
            'Fs - ���� �������������', ...
            'Fs = 0.5*c*S*p(�����), ��� � - ����������� �������� �������������', ...
            'S - ������� ����������� ������� ������', ...
            'p(�����) = p(0)*10^(-0.125*h)', ...
            '', ...
            '���������� �������������� ������������ � �������', ...
            'dV/dt = (alfa*U-Fs)/m(t) - gg*sin(teta)', ...
            'd(teta)/dt = -gg*cos(teta)/V', ...
            'dx/dt = V*cos(teta)', ...
            'dy/dt = V*sin(teta)', ...
            'gg = g*R^2/(R+y)^2', ...
            'teta - ���� �������� ������', ...
            'Vctrl - ��������� �������� (�� ��������� - �������� �����)', ...
            '', ...
            ''};
answer = questdlg(quest,'������� ����������',...
                  'ok',opts);


%% ��������� �������, ����������� �������������

%% ���������� ���������
function new_value = GetValue(hObject) % ����������� ������ �� edittext � ��������� ��������

new_value = str2double(get(hObject,'String'));

%% Callback �������
function uiTable_Callback(hObject, eventdata)   % �����, ������������ ��� ���������� ������ ������� �������������

global rocketParams

data = get(hObject, 'Data');
new_value = eventdata.NewData;
ind = eventdata.Indices;

if isnumeric(new_value) % ���������� ����� ���������

    names = fieldnames(rocketParams);

    rocketParams(ind(1)) = setfield(rocketParams(ind(1)), char(names(ind(2))), new_value);

end
