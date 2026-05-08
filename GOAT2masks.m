%% Mask creation

function [successCheck] = GOAT2masks(aligned_preField,aligned_postField)
% Image Analysis
% Invert the images, fill the now dark spaces, binarize the images, overlay
% Does a good job showing overall change, but isn't sensitive to different isopters
try
set(0,'units','pixels');
resolution = get(0,'screensize');
fig_width = resolution(3)/3;
fig_height = resolution(4)/6;
f = waitbar(0,'Initalizing...');

invert_pre = imcomplement(aligned_preField);
FillAlignInvertPre = imfill(invert_pre);
invert_post = imcomplement(aligned_postField);
FillAlignInvertPost = imfill(invert_post);
waitbar(.33,f,'Cleaning images...');
BiFillAlignInvertPre = imbinarize(FillAlignInvertPre,'global');
BiFillAlignInvertPost = imbinarize(FillAlignInvertPost,'global');
ThreshBiFillAlignInvertPre = bwareaopen(BiFillAlignInvertPre,10000);
ThreshBiFillAlignInvertPost = bwareaopen(BiFillAlignInvertPost,10000);

waitbar(.67,f,'Fusing...');
newPre = imcomplement(imcomplement(ThreshBiFillAlignInvertPre)+imcomplement(imbinarize(aligned_preField)));
newPost = imcomplement(imcomplement(ThreshBiFillAlignInvertPost)+imcomplement(imbinarize(aligned_postField)));

testFillPre = imfill(newPre);
testFillPost = imfill(newPost);

waitbar(1,f,'Opening Image Segmenter...');
% instructions = 'Save names: ISO1_pre, ISO2_pre, ISO3_pre';
% figure('Position',[resolution(3)/2-fig_width/2 resolution(4)/2-fig_height/2 fig_width fig_height],...
% 'DockControls','off','MenuBar','none','NumberTitle','off')
% mTextBox = uicontrol('style','text','Position',[0 fig_height*.5 fig_width 25],'FontSize',20);
% set(mTextBox,'String',instructions)

imageSegmenter(testFillPre)
%imageSegmenter(aligned_preField)
currkey=0;
% do not move on until enter key is pressed
while currkey~=1
    pause; % wait for a keypress
    currkey=get(gcf,'CurrentKey'); 
    if currkey == 'return'
        currkey = 1;
    else
        currkey = 0;
    end
end
% instructions = 'Save names: ISO1_post, ISO2_post, ISO3_post';
% figure('Position',[resolution(3)/2-fig_width/2 resolution(4)/2-fig_height/2 fig_width fig_height],...
% 'DockControls','off','MenuBar','none','NumberTitle','off')
% mTextBox = uicontrol('style','text','Position',[0 fig_height*.5 fig_width 25],'FontSize',20);
% set(mTextBox,'String',instructions)
imageSegmenter(testFillPost)
%imageSegmenter(aligned_postField)
close(f)
successCheck = 1;
catch ME
   keyboard
    set(0,'units','pixels');
    resolution = get(0,'screensize');
    fig_width = resolution(3)/3;
    fig_height = resolution(4)/6;
    error = 'Unknown error, please review';
    figure('Position',[resolution(3)/2-fig_width/2 resolution(4)/2-fig_height/2 fig_width fig_height],...
    'DockControls','off','MenuBar','none','NumberTitle','off')
    mTextBox = uicontrol('style','text','Position',[0 fig_height*.5 fig_width 25],'FontSize',20);
    set(mTextBox,'String',error)
    close(f)
    successCheck = 0;
    
    btn = uicontrol('Style', 'pushbutton', 'String', 'Close Error Message','Position', [fig_width/3 fig_height*.2 175 40],...
    'Callback','close gcf','FontSize',15);
end