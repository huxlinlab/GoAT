%% Calculation of total vision in deficit side only
clear all
Tsave = [];
% s = dir;
% for i = 3:length(s)-1
%     load(s(i).name);
    subject = 'KQT';
    pre = strcat(subject,'_pre.mat');
    load(pre)
    deficit_side = 'L';
    divideLine = 853;
    if exist('DeficitTable.mat')
        load('DeficitTable.mat')
    end
    keyboard
    
    % Crop image to field only
       ISO1_OD_pre(1:175,:) = [];
       ISO2_OD_pre(1:175,:) = [];
       ISO3_OD_pre(1:175,:) = [];

       ISO1_OS_pre(1:175,:) = [];
       ISO2_OS_pre(1:175,:) = [];
       ISO3_OS_pre(1:175,:) = [];
       
       ISO1_OD_pre(1706:end,:) = [];
       ISO2_OD_pre(1706:end,:) = [];
       ISO3_OD_pre(1706:end,:) = [];

       ISO1_OS_pre(1706:end,:) = [];
       ISO2_OS_pre(1706:end,:) = [];
       ISO3_OS_pre(1706:end,:) = [];

    if strcmp(deficit_side,'R')
        % Deficit Side
       deficitSide_ISO1_OD_pre = ISO1_OD_pre(divideLine:end,:);
       deficitSide_ISO2_OD_pre = ISO2_OD_pre(divideLine:end,:);
       deficitSide_ISO3_OD_pre = ISO3_OD_pre(divideLine:end,:);

       deficitSide_ISO1_OS_pre = ISO1_OS_pre(divideLine:end,:);
       deficitSide_ISO2_OS_pre = ISO2_OS_pre(divideLine:end,:);
       deficitSide_ISO3_OS_pre = ISO3_OS_pre(divideLine:end,:);
       
       % Intact side
       intactSide_ISO1_OD_pre = ISO1_OD_pre(1:divideLine,:);
       intactSide_ISO2_OD_pre = ISO2_OD_pre(1:divideLine,:);
       intactSide_ISO3_OD_pre = ISO3_OD_pre(1:divideLine,:);

       intactSide_ISO1_OS_pre = ISO1_OS_pre(1:divideLine,:);
       intactSide_ISO2_OS_pre = ISO2_OS_pre(1:divideLine,:);
       intactSide_ISO3_OS_pre = ISO3_OS_pre(1:divideLine,:);
       
    elseif strcmp(deficit_side,'L')
       % Deficit Side
       deficitSide_ISO1_OD_pre = ISO1_OD_pre(1:divideLine,:);
       deficitSide_ISO2_OD_pre = ISO2_OD_pre(1:divideLine,:);
       deficitSide_ISO3_OD_pre = ISO3_OD_pre(1:divideLine,:);

       deficitSide_ISO1_OS_pre = ISO1_OS_pre(1:divideLine,:);
       deficitSide_ISO2_OS_pre = ISO2_OS_pre(1:divideLine,:);
       deficitSide_ISO3_OS_pre = ISO3_OS_pre(1:divideLine,:);
       
       % Intact Side
       intactSide_ISO1_OD_pre = ISO1_OD_pre(divideLine:end,:);
       intactSide_ISO2_OD_pre = ISO2_OD_pre(divideLine:end,:);
       intactSide_ISO3_OD_pre = ISO3_OD_pre(divideLine:end,:);

       intactSide_ISO1_OS_pre = ISO1_OS_pre(divideLine:end,:);
       intactSide_ISO2_OS_pre = ISO2_OS_pre(divideLine:end,:);
       intactSide_ISO3_OS_pre = ISO3_OS_pre(divideLine:end,:);
    end
% end

%% OD deficit info
% Pre
OD01pre = sum(sum(deficitSide_ISO1_OD_pre));
OD02pre = sum(sum(deficitSide_ISO2_OD_pre));
OD03pre = sum(sum(deficitSide_ISO3_OD_pre));

%% OS deficit info
% Pre
OS01pre = sum(sum(deficitSide_ISO1_OS_pre));
OS02pre = sum(sum(deficitSide_ISO2_OS_pre));
OS03pre = sum(sum(deficitSide_ISO3_OS_pre));

%% Save output
T = table(subject,OS01pre,OS02pre,OS03pre,OD01pre,OD02pre,OD03pre);

T.Properties.VariableNames = {'Subject','OSDeficit1pre','OSDeficit2pre','OSDeficit3pre'...
    ,'ODDeficit1pre','ODDeficit2pre','ODDeficit3pre'};

Tsave = [Tsave;T];
save('DeficitTable.mat','Tsave')

scale_factor = 9.45;
subjects = Tsave.Subject;
Tsave.Subject = [];

func = (@(x) ((x/scale_factor)*.1));
test = varfun(func,Tsave);