clear all
%% Calculates area of visual field change
% T2save = [];
subject = 'DCD';
pre = strcat(subject,'_pre.mat');
post = strcat(subject,'_post.mat');
load(pre)
load(post)
convert = 1;
load('Table2.mat')

%% Pre deficit info
% Fuse left and right eye pre training
compositePreISO1 = imfuse(ISO1_OS_pre,ISO1_OD_pre);
compositePreISO2 = imfuse(ISO2_OS_pre,ISO2_OD_pre);
compositePreISO3 = imfuse(ISO3_OS_pre,ISO3_OD_pre);

% Convert RGB image to grayscale
grayCompositePreISO1 = rgb2gray(compositePreISO1);
grayCompositePreISO2 = rgb2gray(compositePreISO2);
grayCompositePreISO3 = rgb2gray(compositePreISO3);

% Binarize Grayscale image
BWcompositePreISO1 = imbinarize(grayCompositePreISO1);
BWcompositePreISO2 = imbinarize(grayCompositePreISO2);
BWcompositePreISO3 = imbinarize(grayCompositePreISO3);

%% Post deficit info
% Fuse left and right eye post training
compositePostISO1 = imfuse(ISO1_OS_post,ISO1_OD_post);
compositePostISO2 = imfuse(ISO2_OS_post,ISO2_OD_post);
compositePostISO3 = imfuse(ISO3_OS_post,ISO3_OD_post);

% Convert RGB image to grayscale
grayCompositePostISO1 = rgb2gray(compositePostISO1);
grayCompositePostISO2 = rgb2gray(compositePostISO2);
grayCompositePostISO3 = rgb2gray(compositePostISO3);
% Binarize Grayscale image
BWcompositePostISO1 = imbinarize(grayCompositePostISO1);
BWcompositePostISO2 = imbinarize(grayCompositePostISO2);
BWcompositePostISO3 = imbinarize(grayCompositePostISO3);

%% Split image into left/right hemifield
n=fix(size(BWcompositePreISO1,1)/2);
% Pre
leftBWcompositePreISO1 = BWcompositePreISO1(1:n,:,:);
rightBWcompositePreISO1 = BWcompositePreISO1(n+1:end,:,:);

leftBWcompositePreISO2 = BWcompositePreISO2(1:n,:,:);
rightBWcompositePreISO2 = BWcompositePreISO2(n+1:end,:,:);

leftBWcompositePreISO3 = BWcompositePreISO3(1:n,:,:);
rightBWcompositePreISO3 = BWcompositePreISO3(n+1:end,:,:);

% Post
leftBWcompositePostISO1 = BWcompositePostISO1(1:n,:,:);
rightBWcompositePostISO1 = BWcompositePostISO1(n+1:end,:,:);

leftBWcompositePostISO2 = BWcompositePostISO2(1:n,:,:);
rightBWcompositePostISO2 = BWcompositePostISO2(n+1:end,:,:);

leftBWcompositePostISO3 = BWcompositePostISO3(1:n,:,:);
rightBWcompositePostISO3 = BWcompositePostISO3(n+1:end,:,:);

%% Calculate Area of each isopter per hemifield, pre and post training in pixels
% Pre
leftVisualFieldISO1pre = sum(sum(leftBWcompositePreISO1));
leftVisualFieldISO2pre = sum(sum(leftBWcompositePreISO2));
leftVisualFieldISO3pre = sum(sum(leftBWcompositePreISO3));

rightVisualFieldISO1pre = sum(sum(rightBWcompositePreISO1));
rightVisualFieldISO2pre = sum(sum(rightBWcompositePreISO2));
rightVisualFieldISO3pre = sum(sum(rightBWcompositePreISO3));

% Post
leftVisualFieldISO1post = sum(sum(leftBWcompositePostISO1));
leftVisualFieldISO2post = sum(sum(leftBWcompositePostISO2));
leftVisualFieldISO3post = sum(sum(leftBWcompositePostISO3));

rightVisualFieldISO1post = sum(sum(rightBWcompositePostISO1));
rightVisualFieldISO2post = sum(sum(rightBWcompositePostISO2));
rightVisualFieldISO3post = sum(sum(rightBWcompositePostISO3));


%% Save output
T2 = table(subject, leftVisualFieldISO1pre, leftVisualFieldISO2pre, leftVisualFieldISO3pre...
          , rightVisualFieldISO1pre, rightVisualFieldISO2pre, rightVisualFieldISO3pre...
          , leftVisualFieldISO1post, leftVisualFieldISO2post, leftVisualFieldISO3post...
          , rightVisualFieldISO1post, rightVisualFieldISO2post, rightVisualFieldISO3post);



T2.Properties.VariableNames = {'Subject','leftVisualFieldISO1pre', 'leftVisualFieldISO2pre', 'leftVisualFieldISO3pre'...
          , 'rightVisualFieldISO1pre', 'rightVisualFieldISO2pre', 'rightVisualFieldISO3pre'...
          , 'leftVisualFieldISO1post', 'leftVisualFieldISO2post', 'leftVisualFieldISO3post'...
          , 'rightVisualFieldISO1post', 'rightVisualFieldISO2post', 'rightVisualFieldISO3post'};

T2save = [T2save;T2];
save('Table2.mat','T2save')

%% Convert table from Pixels to Degrees
if convert == 1
    % Scale Factor: 9.45 px/deg
    scale_factor = 9.45;
    subjects = T2save.Subject;

    T2save.Subject = [];

    func = (@(x) ((x/scale_factor)*.1));
    test = varfun(func,T2save);
end