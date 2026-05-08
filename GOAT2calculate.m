clear all
%% Calculates area of visual field change
%Changesave = [];
subject = 'DKL'; % Change this line only
pre = strcat(subject,'_pre.mat');
post = strcat(subject,'_post.mat');
load(pre)
load(post)
load('ChangeTable.mat')

%% Blindspot check for reliability
% Determines if a blindspot was detected in a given eye
% Calculates the size of the blindspot(s) currently in pixels
% Calculates the total difference in size, as well as the number of
% gain/loss pixels

if exist('Blindspot_OD_pre') && exist('Blindspot_OD_post')
    ODBlindspotDiff = sum(sum(Blindspot_OD_pre)) - sum(sum(Blindspot_OD_post));
    compositeODBlindspot = imfuse(Blindspot_OD_pre,Blindspot_OD_post);
    ODBSgainPixels = (compositeODBlindspot(:,:,1) == 0) & (compositeODBlindspot(:,:,2) == 255) & (compositeODBlindspot(:,:,3) == 0);
    ODBSlossPixels = (compositeODBlindspot(:,:,1) == 255) & (compositeODBlindspot(:,:,2) == 0) & (compositeODBlindspot(:,:,3) == 255);
    
    ODBSpre = sum(sum(Blindspot_OD_pre));
    ODBSpost = sum(sum(Blindspot_OD_post));
    ODBSgain = sum(sum(ODBSgainPixels));
    ODBSloss = sum(sum(ODBSlossPixels));
else
    ODBSpre = 0;
    ODBSpost = 0;
    ODBSgain = 0;
    ODBSloss = 0;
end

if exist('Blindspot_OS_pre') && exist('Blindspot_OS_post')
    OSBlindspotDiff = sum(sum(Blindspot_OS_pre)) - sum(sum(Blindspot_OS_post));
    compositeOSBlindspot = imfuse(Blindspot_OS_pre,Blindspot_OS_post);
    OSBSgainPixels = (compositeOSBlindspot(:,:,1) == 0) & (compositeOSBlindspot(:,:,2) == 255) & (compositeOSBlindspot(:,:,3) == 0);
    OSBSlossPixels = (compositeOSBlindspot(:,:,1) == 255) & (compositeOSBlindspot(:,:,2) == 0) & (compositeOSBlindspot(:,:,3) == 255);
    
    OSBSpre = sum(sum(Blindspot_OS_pre));
    OSBSpost = sum(sum(Blindspot_OS_post));
    OSBSgain = sum(sum(OSBSgainPixels));
    OSBSloss = sum(sum(OSBSlossPixels));
else
    OSBSpre = 0;
    OSBSpost = 0;
    OSBSgain = 0;
    OSBSloss = 0;
end

%% Scotoma analysis

if exist('Scotoma_OD_pre') && exist('Scotoma_OD_post')
    ODScotomaDiff = sum(sum(Scotoma_OD_pre)) - sum(sum(Scotoma_OD_post));
    compositeODScotoma = imfuse(Scotoma_OD_pre,Scotoma_OD_post);
    ODScotomagainPixels = (compositeODScotoma(:,:,1) == 0) & (compositeODScotoma(:,:,2) == 255) & (compositeODScotoma(:,:,3) == 0);
    ODScotomalossPixels = (compositeODScotoma(:,:,1) == 255) & (compositeODScotoma(:,:,2) == 0) & (compositeODScotoma(:,:,3) == 255);
    
    ScotomaODpre = sum(sum(Scotoma_OD_pre));
    ScotomaODpost = sum(sum(Scotoma_OD_post));
    ScotomaODgain = sum(sum(ODScotomagainPixels));
    ScotomaODloss = sum(sum(ODScotomalossPixels));
else
    ScotomaODpre = 0;
    ScotomaODpost = 0;
    ScotomaODgain = 0;
    ScotomaODloss = 0;
end

if exist('Scotoma_OS_pre') && exist('Scotoma_OS_post')
    OSScotomaDiff = sum(sum(Scotoma_OS_pre)) - sum(sum(Scotoma_OS_post));
    compositeOSScotoma = imfuse(Scotoma_OS_pre,Scotoma_OS_post);
    OSScotomagainPixels = (compositeOSScotoma(:,:,1) == 0) & (compositeOSScotoma(:,:,2) == 255) & (compositeOSScotoma(:,:,3) == 0);
    OSScotomalossPixels = (compositeOSScotoma(:,:,1) == 255) & (compositeOSScotoma(:,:,2) == 0) & (compositeOSScotoma(:,:,3) == 255);
    
    ScotomaOSpre = sum(sum(Scotoma_OS_pre));
    ScotomaOSpost = sum(sum(Scotoma_OS_post));
    ScotomaOSgain = sum(sum(OSScotomagainPixels));
    ScotomaOSloss = sum(sum(OSScotomalossPixels));
else
    ScotomaOSpre = 0;
    ScotomaOSpost = 0;
    ScotomaOSgain = 0;
    ScotomaOSloss = 0;
end

%% OD deficit info
% Pre
OD01pre = sum(sum(ISO1_OD_pre));
OD02pre = sum(sum(ISO2_OD_pre));
OD03pre = sum(sum(ISO3_OD_pre));

% Post
OD01post = sum(sum(ISO1_OD_post));
OD02post = sum(sum(ISO2_OD_post));
OD03post = sum(sum(ISO3_OD_post));

%% OD field change info
compositeOD1 = imfuse(ISO1_OD_post,ISO1_OD_pre);
compositeOD2 = imfuse(ISO2_OD_post,ISO2_OD_pre);
compositeOD3 = imfuse(ISO3_OD_post,ISO3_OD_pre);

gainOD1Pixels = (compositeOD1(:,:,1) == 0) & (compositeOD1(:,:,2) == 255) & (compositeOD1(:,:,3) == 0);
lossOD1Pixels = (compositeOD1(:,:,1) == 255) & (compositeOD1(:,:,2) == 0) & (compositeOD1(:,:,3) == 255);

gainOD2Pixels = (compositeOD2(:,:,1) == 0) & (compositeOD2(:,:,2) == 255) & (compositeOD2(:,:,3) == 0);
lossOD2Pixels = (compositeOD2(:,:,1) == 255) & (compositeOD2(:,:,2) == 0) & (compositeOD2(:,:,3) == 255);

gainOD3Pixels = (compositeOD3(:,:,1) == 0) & (compositeOD3(:,:,2) == 255) & (compositeOD3(:,:,3) == 0);
lossOD3Pixels = (compositeOD3(:,:,1) == 255) & (compositeOD3(:,:,2) == 0) & (compositeOD3(:,:,3) == 255);

%figure;imshow(gainOD1Pixels)

OD01gain = sum(sum(gainOD1Pixels));
OD02gain = sum(sum(gainOD2Pixels));
OD03gain = sum(sum(gainOD3Pixels));

OD01loss = sum(sum(lossOD1Pixels));
OD02loss = sum(sum(lossOD2Pixels));
OD03loss = sum(sum(lossOD3Pixels));

%% OS deficit info
% Pre
OS01pre = sum(sum(ISO1_OS_pre));
OS02pre = sum(sum(ISO2_OS_pre));
OS03pre = sum(sum(ISO3_OS_pre));

% Post
OS01post = sum(sum(ISO1_OS_post));
OS02post = sum(sum(ISO2_OS_post));
OS03post = sum(sum(ISO3_OS_post));

%% OS field change info
compositeOS1 = imfuse(ISO1_OS_post,ISO1_OS_pre);
compositeOS2 = imfuse(ISO2_OS_post,ISO2_OS_pre);
compositeOS3 = imfuse(ISO3_OS_post,ISO3_OS_pre);

gainOS1Pixels = (compositeOS1(:,:,1) == 0) & (compositeOS1(:,:,2) == 255) & (compositeOS1(:,:,3) == 0);
lossOS1Pixels = (compositeOS1(:,:,1) == 255) & (compositeOS1(:,:,2) == 0) & (compositeOS1(:,:,3) == 255);

gainOS2Pixels = (compositeOS2(:,:,1) == 0) & (compositeOS2(:,:,2) == 255) & (compositeOS2(:,:,3) == 0);
lossOS2Pixels = (compositeOS2(:,:,1) == 255) & (compositeOS2(:,:,2) == 0) & (compositeOS2(:,:,3) == 255);

gainOS3Pixels = (compositeOS3(:,:,1) == 0) & (compositeOS3(:,:,2) == 255) & (compositeOS3(:,:,3) == 0);
lossOS3Pixels = (compositeOS3(:,:,1) == 255) & (compositeOS3(:,:,2) == 0) & (compositeOS3(:,:,3) == 255);

OS01gain = sum(sum(gainOS1Pixels));
OS02gain = sum(sum(gainOS2Pixels));
OS03gain = sum(sum(gainOS3Pixels));

OS01loss = sum(sum(lossOS1Pixels));
OS02loss = sum(sum(lossOS2Pixels));
OS03loss = sum(sum(lossOS3Pixels));
%% Save output
T = table(subject,OS01pre,OS02pre,OS03pre,OD01pre,OD02pre,OD03pre...
    ,OS01post,OS02post,OS03post,OD01post,OD02post,OD03post...
    ,OS01gain,OS02gain,OS03gain,OD01gain,OD02gain,OD03gain...
    ,OS01loss,OS02loss,OS03loss,OD01loss,OD02loss,OD03loss...
    ,OSBSpre,ODBSpre,OSBSpost,ODBSpost,OSBSgain,ODBSgain,OSBSloss,ODBSloss...
    ,ScotomaOSpre,ScotomaODpre,ScotomaOSpost,ScotomaODpost,ScotomaOSgain,ScotomaODgain,ScotomaOSloss,ScotomaODloss);



T.Properties.VariableNames = {'Subject','OSDeficit1pre','OSDeficit2pre','OSDeficit3pre','ODDeficit1pre','ODDeficit2pre','ODDeficit3pre'...
                              ,'OSDeficit1post','OSDeficit2post','OSDeficit3post','ODDeficit1post','ODDeficit2post','ODDeficit3post'...
                              ,'gainOS1Pixels','gainOS2Pixels','gainOS3Pixels','gainOD1Pixels','gainOD2Pixels','gainOD3Pixels'...
                              ,'lossOS1Pixels','lossOS2Pixels','lossOS3Pixels','lossOD1Pixels','lossOD2Pixels','lossOD3Pixels'...
                              ,'BlindspotOSpre','BlindspotODpre','BlindspotOSpost','BlindspotODpost','BlindspotOSgain','BlindspotODgain','BlindspotOSloss','BlindspotODloss'...
                              ,'ScotomaOSpre','ScotomaODpre','ScotomaOSpost','ScotomaODpost','ScotomaOSgain','ScotomaODgain','ScotomaOSloss','ScotomaODloss'};

Changesave = [Changesave;T];
save('ChangeTable.mat','Changesave')
%% Convert table from Pixels to Degrees
% Scale Factor: 9.45 px/deg
scale_factor = 9.45;
subjects = Changesave.Subject;
Changesave.Subject = [];

func = (@(x) ((x/scale_factor)*.1));
Changetest = varfun(func,Changesave);
