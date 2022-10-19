function [init, Ca_out, fname_out] = FP_norm()

p = path;
disp('Pick the folder with FP trace to analyze');                            % display in command window info about what type of folder you should pick 
filestosort = uigetdir;                                                    % open folder selection dialog box
path(p, filestosort);                                                      % temporarily add random folder to the path to read things about it
tempp = path; 
d     = dir(filestosort); 
filelist = listdlg('PromptString', 'Pick files to sort: ', ...
                    'ListSize', [300,500],...
                    'SelectionMode', 'single',...
                    'ListString', {d.name}); 
                
fname=[filestosort,'/',d(filelist).name]; 

fname_out = d(filelist).name(1:end-4);

load(fname);

data.Ca = Ca;
data.iso = iso;

%% hardcoded variables - need to know from recording
sr=1017.25;
FL = sr;% sampling rate in hz

%% auditory (or whatever other) stimulus - should be represented by ttl pulses
% check this first to get rid of any junk in the beginning to disregard as
% you are setting things up 

ts=800; 


end_rec = floor(length(data.Ca)-125);

%% calculate time from indices
if length(data.Ca(ts:end_rec)) == length(data.iso(ts:end_rec))                     % making sure our actual/control data is the same length
    time=(1:length(data.Ca(ts:end_rec)))/sr;                                   % N data points/sampling rate
end

%% get into specifics from data files (extract isosbestic and calcium imaging)
ch405=double(data.iso(ts:end_rec));                                            % load isosbestic data (but ignore long pre stim baseline)
ch490=double(data.Ca(ts:end_rec));                                             % load calcium imaging data (but ignore long pre stim baseline)

%% filter/smooth the data 
% using a lowess filter
% F490=smooth(ch490,0.002,'lowess'); 
% F405=smooth(ch405,0.002,'lowess');

% or using a moving average
F490=smooth(ch490,499,'moving'); 
F405=smooth(ch405,499,'moving');

%% correct gcamp signal based on isosbestic channel
bls=polyfit(F405(1:end),F490(1:end),1);                                    % regression of isosbestic and signals against each other
% figure; scatter(F405(10:end-10),F490(10:end-10))                                   % plot to check it out
yfit=bls(1).*F405+bls(2);

%% df/f
df=(F490(:)-yfit(:))./yfit(:);                                             % not percentage df/f
% df=df.*100;                                                              % this is in percentage df/f

%% zscore 
ind=20*sr;
df_b=df(1:ind,1);
zs_df=(df-mean(df_b))./std(df_b);

%% plot everything (general)
figure;
subplot(411);plot(time, df.*100,'k'); hold on;
%plot(allstimtime, ones(numel(allstimtime),1), 'b.');
ylabel('%dF/F')
title('df'); 
subplot(412);plot(time, zs_df, 'k'); 
title('zscore');
subplot(413);plot(time, F405, 'r'); 
title('isosbestic');
subplot(414); plot(time, F490, 'g'); 
title('gcamp');
xlabel('Time (s)');

Ca_out = df;

input = [input_onset input_offset];

init = [];
resp = [];

if any(input_offset(:) == 0 ) == 1
    for i = 1:length(input)
        if input(i,2) == 0
            init(i) = input(i,1);
        else
            resp(i) = input(i,1);
        end
    end
else
    for i = 1:length(input)
        if round(input(i,2) - input(i,1),2) == 0.47
            init(i) = input(i,1);
        else
            resp(i) = input(i,1);
        end
    end
end
            

init(init==0) = [];
resp(resp==0) = [];

init = init'*FL;
init = init-ts;
resp = resp'*FL;
resp = resp-ts;

num_points_init = 0.1*ones(1,length(init));
num_points_resp = 0.1*ones(1,length(resp));

figure; plot(Ca_out); hold on; plot(init,num_points_init,'sr', 'MarkerSize',5,'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'none');
hold on; plot(resp,num_points_resp,'sr', 'MarkerSize',5,'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none');
end

