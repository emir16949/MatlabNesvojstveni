function varargout = Zavrsni(varargin)
% ZAVRSNI MATLAB code for Zavrsni.fig
%      ZAVRSNI, by itself, creates a new ZAVRSNI or raises the existing
%      singleton*.
%
%      H = ZAVRSNI returns the handle to a new ZAVRSNI or the handle to
%      the existing singleton*.
%
%      ZAVRSNI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZAVRSNI.M with the given input arguments.
%
%      ZAVRSNI('Property','Value',...) creates a new ZAVRSNI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Zavrsni_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Zavrsni_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Zavrsni

% Last Modified by GUIDE v2.5 11-Sep-2017 00:26:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Zavrsni_OpeningFcn, ...
                   'gui_OutputFcn',  @Zavrsni_OutputFcn, ...
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


% --- Executes just before Zavrsni is made visible.
function Zavrsni_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Zavrsni (see VARARGIN)

% Choose default command line output for Zavrsni
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Zavrsni wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Zavrsni_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = str2num(get(handles.edit1, 'String'));
b = str2num(get(handles.edit2, 'String'));

switch get(get(handles.uipanel1,'SelectedObject'),'Tag')
    case 'radiobutton1',  f = @(x) sinx_x(x);
    case 'radiobutton2',  f = @(x) one_1_plus_xx(x);
    case 'radiobutton3',  f = @(x) one_sqrtx(x); gama = 1 / 2;
    case 'radiobutton4',  f = @(x) one_xx(x); gama = 2;
    case 'radiobutton5',  f = @(x) one_xxxx(x); gama = 4;
    case 'radiobutton6',  f = @(x) one_x(x);
    case 'radiobutton7',  f = @(x) exp_xx(x); gama = 1;
    case 'radiobutton8',  f = @(x) exp_x(x);
end

if a == -Inf
    a = -1e10;
end;
if b == Inf
    b = 1e10;
end;

switch get(get(handles.uipanel4,'SelectedObject'),'Tag')
    case 'radiobutton9',
        I = Simpson2(f, a, b);
    case 'radiobutton10',
        eps = 10e-10;
        if (a ~= 0 && b == 0)
            I = Simpson2(f, a, b - eps);
        elseif (a == 0 && b ~= 0)
            I = Simpson2(f, a + eps, b);
        else
            I = Simpson2(f, a, b);
        end;
    case 'radiobutton11',
        f1 = @(x) f_pomocna(x, f);
        if (a ~= -1e10 && b ~= 1e10)
            I = Simpson2(f, a, b);
        elseif (a == -1e10)
            if (b < 0)
                I = Simpson2(f1, 1 / b, 0);
            elseif (b >= 0 && b ~= 1e10)
                I = Simpson2(f1, -0.5, 0) + Simpson2(f, -2, b);
            else
                I = Simpson2(f1, -0.5, 0) + Simpson2(f, -2, 2) + Simpson2(f1, 0, 0.5);
            end;
        else
            if (a > 0)
                I = Simpson2(f1, 0, 1 / a);
            else
                I = Simpson2(f, a, 2) + Simpson2(f1, 0, 0.5);
            end;
        end;
    case 'radiobutton12',
        if (a == 0)
            f1 = @(x) x .^ (gama / (1 - gama)) * f(x .^ (1 / (1 - gama)) + a);
        else
            f1 = @(x) x .^ (gama / (1 - gama)) * f(b - x .^ (1 / (1 - gama)));
        end;
        I = (1 / (1 - gama)) * Simpson2(f1, 0, (b - a) .^ (1 - gama));
    case 'radiobutton13',
        I = adaptive(f, a, b);
end

set(handles.text6, 'string', num2str(I));


function I = adaptive (f, a, b, eps, j)
if nargin == 3
    eps = 10e-10;
    j = 0;
elseif nargin == 4
    j = 0;
end;
j = j + 1;
if (j == 480)
    I = Inf;
    return;
end

I1 = Simpson1(f, a, b, 10);
I2 = Simpson1(f, a, b, 1000);
if (I2 >= 1e10)
    I = Inf;
    return;
end
if abs(I1 - I2) <= eps
    I = I2;
    return;
end
c = (a + b) / 2;
I = adaptive (f, a, c, eps, j) + adaptive (f, c, b, eps, j);


function I = Simpson1 (f, a, b, N)

h = (b - a) / N;
sum = f(a) + f(b);
mi = 4;
for i = 1:N - 1
    sum = sum + mi * f(a + i * h);
    mi = 6 - mi;
end
I = h * sum / 3;


function I = Simpson2 (f, a, b)

N = 2;
h = (b - a) / N;
sum = (f(a) + f(b)) / 2;
T_staro = sum;
I_staro = 0;
if h > 1e6
    Nmax = h;
else
    Nmax = 1000000;
end
Nmin = 1000;
eps = 10e-10;
while (N < Nmax)
    for i = 1 : N/2
        sum = sum + f(a + (2 * i - 1) * h);
    end
    I = (4 * h * sum - T_staro) / 3;
    if (abs(I - I_staro) <= eps && N > Nmin)
        break;
    end
    T_staro = h * sum;
    I_staro = I;
    N = 2 * N;
    h = h / 2;
end;


function y = f_pomocna (x, f)
if (x == 0)
    y = 0;
else
    y = x.^(-2) * f(1 / x);
end;



function y = sinx_x (x)
if x == 0
    y = 1;
else
    y = sin(x) / x;
end;


function y = one_1_plus_xx (x)
    y = 1 / (1 + x * x);


function y = one_sqrtx (x)
if x == 0
    y = 0;
else
    y = 1 / sqrt(x);
end;


function y = one_xx (x)
if (x == 0)
    y = 0;
else
    y = 1 / (x * x);
end;


function y = one_xxxx (x)
if (x == 0)
    y = 0;
else
    y = 1 / (x * x * x * x);
end;


function y = one_x (x)
if x == 0
    y = 0;
else
    y = 1 / x;
end;


function y = exp_xx (x)
    y = exp(-x*x);


function y = exp_x (x)
    y = exp(x);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
