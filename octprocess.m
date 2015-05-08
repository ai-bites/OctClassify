%% OCT Files Browser
function octprocess()
%% Callback: Browse
    function browseButton_Callback(hObject, eventdata, handles)
        folder_name = uigetdir();
        if(folder_name == 0)
            return
        end
        h = findobj('Tag', 'loadImagesEdit');
        set(h,'String',folder_name);
    end

%% Callback: Load Dicom Images
    function loadFilesButton_Callback(hObject, eventdata, handles)
        loadImagesEdit = findobj('Tag', 'loadImagesEdit');
        fileListBox = findobj('Tag', 'fileListBox');
        files_dir = get(loadImagesEdit,'String');
        files = dir(strcat(files_dir,filesep,'*.mat'));
        [sorted_files_names,~] = sortrows({files.name}');
        sorted_files_names = sorted_files_names(3:end);
        set(fileListBox,'String',sorted_files_names,'Value',1);
        % Load First File
        first_file_name = strcat(files_dir,filesep,sorted_files_names(1));
        readFile(first_file_name{:});
    end

%% Callback: File List Box
    function fileListBox_Callback(hObject, eventdata, handles)
        files_dir = get(loadImagesEdit,'String');
        files_names = get(fileListBox,'String');
        selected_file_index = get(fileListBox,'Value');
        selected_file_name = files_names(selected_file_index);
        file_name = strcat(files_dir,filesep,selected_file_name);
        readFile(file_name{:});
    end

%% Callback: Image List Box
    function imageListBox_Callback(hObject, eventdata, handles)
        selected_image_index = get(imageListBox,'Value');
        displayImage(imgs(:,:,selected_image_index));
    end


%% Display Image
    function displayImage(selected_image)
        % Default behavior is showing in default axes of current figure
        % imageAxes must be cleared every time before showing new image
        % Otherwise, large memory leak
        cla(imageAxes);
        imshow(selected_image, []);
    end

%% Read File
    function readFile(selected_file_path)
        file = load(selected_file_path);
        imgs = file.images;
        age = file.Age;
        
        displayFileImages();
    end

    function displayFileImages()
        imageListBox = findobj('Tag', 'imageListBox');
        [~,~,imgs_count] = size(imgs);
        images_names = 1:imgs_count;
        set(imageListBox,'String',images_names,'Value',1);
        % Load First Image
        first_img = imgs(:,:,1);
        displayImage(first_img);
        set(findobj('Tag', 'subjectAgeEdit'),'String',age);
    end

%% All Globla Variables and GUI Construction

clear all;
close all;
clc;

database_path = 'D:\University\Scene Segmentation\project\dataset';

%% Global Variables
imgs = [];
age = 0;

%% Figure
wMax = 100;
hMax = 100;

hFig = figure('Visible','off','Menu','none', 'Name','OCT Files Reader',...
    'Resize','on', 'Position', [0 0 1000 600]);

imageAxes = axes('Parent',hFig,'Units','normalized',...
    'position',[37/wMax 10/hMax 60/wMax 80/hMax]);

%% Image Directory
wDir = 85;
hDir = 7;

dirBG = uibuttongroup('Units','Normalized','Title','Images Directory',...
    'BackgroundColor',[1 0.5 0],'Position',[1/wMax 92/hMax wDir/wMax 7/hMax]);

loadImagesEdit = uicontrol('Style','edit','Parent', dirBG,'Units','normalized',...
    'String',database_path,'Tag','loadImagesEdit',...
    'Position',[1/wDir 1/7 60/wDir 5/7]);

browseButton = uicontrol('Style','pushbutton','Parent',dirBG,'Units','normalized',...
    'String','Browse',...
    'Position',[62/wDir 1/7 8/wDir 5/7],'Callback',@browseButton_Callback);

loadFilesButton = uicontrol('Style','pushbutton','Parent',dirBG,'Units','normalized',...
    'String','Load Files Images',...
    'Position',[72/wDir 1/7 12/wDir 5/7],'Callback',@loadFilesButton_Callback);

%% Files ListBox
wFListBG = 33;
hFListBG = 34;

filelistBG = uibuttongroup('Units','Normalized','Title','Files List',...
    'Position',[1/wMax 57/hMax wFListBG/wMax hFListBG/hMax]);

fileListBox = uicontrol('Style','listbox','Parent',filelistBG,'Units','normalized',...
    'BackgroundColor','white','Tag','fileListBox',...
    'Position',[1/wFListBG 1/hFListBG 31/wFListBG 33/hFListBG],'Callback',@fileListBox_Callback);


%% Image ListBox
wIListBG = 33;
hIListBG = 34;

imagelistBG = uibuttongroup('Units','Normalized','Title','Image List',...
    'Position',[1/wMax 22/hMax wIListBG/wMax hIListBG/hMax]);

imageListBox = uicontrol('Style','listbox','Parent',imagelistBG,'Units','normalized',...
    'BackgroundColor','white','Tag','imageListBox',...
    'Position',[1/wIListBG 1/hIListBG 31/wIListBG 33/hIListBG],'Callback',@imageListBox_Callback);

%% Original Patient Parameters Handles
wOrgBG = 33;
hOrgBG = 20;

orgParameterBG = uibuttongroup('Units','Normalized','Title','Information',...
    'Position',[1/wMax 1/hMax wOrgBG/wMax hOrgBG/hMax]);

subjectAgeLabel = uicontrol('Style','text','Parent',orgParameterBG,'Units','normalized',...
    'String','Subject Age',...
    'Position',[1/wOrgBG 15/hOrgBG 7/wOrgBG 4/hOrgBG]);

subjectAgeEdit = uicontrol('Style','edit','Parent',orgParameterBG,'Units','normalized',...
    'Tag','subjectAgeEdit','Enable','off',...
    'Position',[9/wOrgBG 15/hOrgBG 8/wOrgBG 4/hOrgBG]);

set(hFig, 'Visible','on');

end