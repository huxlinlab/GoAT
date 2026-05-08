%% GUI Version Align Function
function [aligned_preField, aligned_postField, successCheck] = GOATalign(pre_field, post_field, reference)
% Co-register images to reference
% Final output: aligned_preField, aligned_postField
try
f = waitbar(0,'Aligning...');

pre_field = imresize(pre_field, [size(reference,1) size(reference,2)]);
post_field = imresize(post_field, [size(reference,1) size(reference,2)]);

ptsOriginal  = detectSURFFeatures(reference);
ptsDistorted = detectSURFFeatures(pre_field);

[featuresOriginal,   validPtsOriginal]  = extractFeatures(reference,  ptsOriginal);
[featuresDistorted, validPtsDistorted]  = extractFeatures(pre_field, ptsDistorted);

indexPairs = matchFeatures(featuresOriginal, featuresDistorted);

matchedOriginal  = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));

% Prior alignment method
% [tform, inlierOrig, inlierDistort] = estimateGeometricTransform(...
%     matchedDistorted, matchedOriginal, 'similarity');

[tform, ~, ~] = estgeotform2d(matchedDistorted, matchedOriginal, 'projective');

outputView = imref2d(size(reference));
aligned_preField  = imwarp(pre_field,tform,'OutputView',outputView);
clearvars -except reference aligned_preField postfilename post_field f

waitbar(.33,f,'Aligning...');

% Post field
ptsOriginal  = detectSURFFeatures(reference);
ptsDistorted = detectSURFFeatures(post_field);

[featuresOriginal,   validPtsOriginal]  = extractFeatures(reference,  ptsOriginal);
[featuresDistorted, validPtsDistorted]  = extractFeatures(post_field, ptsDistorted);

indexPairs = matchFeatures(featuresOriginal, featuresDistorted);

matchedOriginal  = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));
waitbar(.67,f,'Aligning...');

% Prior alignment method
% [tform, inlierOrig, inlierDistort] = estimateGeometricTransform(...
%     matchedDistorted, matchedOriginal, 'similar');

[tform, ~, ~] = estgeotform2d(matchedDistorted, matchedOriginal, 'projective');

waitbar(1,f,'Finishing');
outputView = imref2d(size(reference));
aligned_postField  = imwarp(post_field,tform,'OutputView',outputView);
successCheck = 1;
close(f)
% Test quality of alignment

figure('Name','Alignment Check','NumberTitle','off'), imshowpair(imcomplement(aligned_preField)+imcomplement(reference),imcomplement(aligned_postField)+imcomplement(reference),'montage')
catch ME
    keyboard
    set(0,'units','pixels');
    resolution = get(0,'screensize');
    fig_width = resolution(3)/3;
    fig_height = resolution(4)/6;
    error = 'Error in selected fields, please review';
    figure('Position',[resolution(3)/2-fig_width/2 resolution(4)/2-fig_height/2 fig_width fig_height],...
    'DockControls','off','MenuBar','none','NumberTitle','off')
    mTextBox = uicontrol('style','text','Position',[0 fig_height*.5 fig_width 25],'FontSize',20);
    set(mTextBox,'String',error)
    close(f)
    aligned_preField = [];
    aligned_postField = [];
    successCheck = 0;
    btn = uicontrol('Style', 'pushbutton', 'String', 'Close Error Message','Position', [fig_width/3 fig_height*.2 175 40],...
    'Callback','close gcf','FontSize',15);
end