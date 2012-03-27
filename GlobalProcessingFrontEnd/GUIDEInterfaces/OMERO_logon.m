function varargout = OMERO_logon(varargin)
% OMERO_LOGON M-file for OMERO_logon.fig
%      OMERO_LOGON, by itself, creates a new OMERO_LOGON or raises the existing
%      singleton*.
%
%      H = OMERO_LOGON returns the handle to a new OMERO_LOGON or the handle to
%      the existing singleton*.
%
%      OMERO_LOGON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OMERO_LOGON.M with the given input arguments.
%
%      OMERO_LOGON('Property','Value',...) creates a new OMERO_LOGON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OMERO_logon_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OMERO_logon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OMERO_logon

% Last Modified by GUIDE v2.5 10-Feb-2012 15:56:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OMERO_logon_OpeningFcn, ...
                   'gui_OutputFcn',  @OMERO_logon_OutputFcn, ...
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


% --- Executes just before OMERO_logon is made visible.
function OMERO_logon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OMERO_logon (see VARARGIN)

% Choose default command line output for OMERO_logon
handles.output = hObject;

handles.server = '??';
handles.userName = '??';
handles.passwd = '??';

handles.output = {'??', '??', '??'};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OMERO_logon wait for user response (see UIRESUME)
 uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = OMERO_logon_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.figure1);


% --- Executes during object creation, after setting all properties.
function Server_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Server (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Server_Callback(hObject, eventdata, handles)
% hObject    handle to Server (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Server as text
%        str2double(get(hObject,'String')) returns contents of Server as a double
server = get(hObject,'String');

% Save the new  value
handles.server = server;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function UserName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UserName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function UserName_Callback(hObject, eventdata, handles)
% hObject    handle to UserName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UserName as text
%        str2double(get(hObject,'String')) returns contents of UserName as a double
userName = get(hObject,'String');

% Save the new  value
handles.userName = userName;
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function passwd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to passwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function passwd_Callback(hObject, eventdata, handles)
% hObject    handle to passwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of passwd as text
%        str2double(get(hObject,'String')) returns contents of passwd as a double

passwd = get(hObject,'String');

% Save the new  value
handles.passwd = passwd;
guidata(hObject,handles);




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

server = handles.server;
userName = handles.userName;
passwd = handles.passwd;


handles.output = {server, userName, passwd};


guidata(hObject,handles);


uiresume(handles.figure1);


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)