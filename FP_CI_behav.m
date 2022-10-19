%% Program to align FP traces to CI behavior


%%Import behavioral and calcium data

          
BEHAV = behav_import; %% matrix with 4 columns: tone, response, initiation delay, and response time

FL = 1017.25;

tone_length = 100*FL/1000; %100 ms

%CONFIRM TONES FOR CI PROGRAMMING
tone1 = 1313;
tone2 = 313;
tone3 = 6563;
tone4 = 1938;
tone5 = 563;
tone6 = 876;
tone7 = 2876;
tone8 = 4313;


tones = BEHAV(:,1);
responses = BEHAV(:,4);
init_delay = (BEHAV(:,3)*FL)/1000;
resp_time = (BEHAV(:,2)*FL)/100; %change based on name of behav data file

if resp_time(1) == 0        %%accounts for indexing error in behavior collection
    resp_time(1) = [];
else
end

init_delay(init_delay==0) = [];
resp_time(resp_time==0) = [];
responses(tones==0) = [];
tones(tones==0) = [];
init_delay = rmmissing(init_delay);
resp_time = rmmissing(resp_time);



[trigger_pks_locs, Lfilter, fname] = FPA_Analysis_Script_EG;
%put break and check that tones and triggers match up


compiled_tones = [trigger_pks_locs tones];
compiled_resp = [trigger_pks_locs responses];
tone_resp = [tones responses];

%% Frequency alloction
TONE(1).freq = tone1;
TONE(2).freq = tone2;
TONE(3).freq = tone3;
TONE(4).freq = tone4;
TONE(5).freq = tone5;
TONE(6).freq = tone6;
TONE(7).freq = tone7;
TONE(8).freq = tone8;
%% Assigning deltaf/f for each tone

for ii=1:length(tones)
       if tones(ii) == tone1
        TONE(1).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-FL:trigger_pks_locs(ii)+(3*FL));
        TONE(1).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
        TONE(1).init_delay(ii) = init_delay(ii);
        TONE(1).response(ii) = responses(ii);
        TONE(1).resp_time(ii) = resp_time(ii);
        TONE(1).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));

        TONE(1).z(ii,:) = (TONE(1).deltaf(ii,:)-mean(TONE(1).baseline(ii,:)))./std(TONE(1).baseline(ii,:));
        TONE(1).z_resp(ii,:) = (TONE(1).deltaf_resp(ii,:)-mean(TONE(1).baseline(ii,:)))./std(TONE(1).baseline(ii,:));

        
    elseif tones(ii) == tone2
         TONE(2).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
         TONE(2).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
         TONE(2).init_delay(ii) = init_delay(ii);
         TONE(2).response(ii) = responses(ii);
         TONE(2).resp_time(ii) = resp_time(ii);
         TONE(2).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));
         
        TONE(2).z(ii,:) = (TONE(2).deltaf(ii,:)-mean(TONE(2).baseline(ii,:)))./std(TONE(2).baseline(ii,:));
        TONE(2).z_resp(ii,:) = (TONE(2).deltaf_resp(ii,:)-mean(TONE(2).baseline(ii,:)))./std(TONE(2).baseline(ii,:));


    elseif tones(ii) == tone3
         TONE(3).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
         TONE(3).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
         TONE(3).init_delay(ii) = init_delay(ii);
         TONE(3).response(ii) = responses(ii);
         TONE(3).resp_time(ii) = resp_time(ii);
         TONE(3).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));

         TONE(3).z(ii,:) = (TONE(3).deltaf(ii,:)-mean(TONE(3).baseline(ii,:)))./std(TONE(3).baseline(ii,:));
        TONE(3).z_resp(ii,:) = (TONE(3).deltaf_resp(ii,:)-mean(TONE(3).baseline(ii,:)))./std(TONE(3).baseline(ii,:));


    elseif tones(ii) == tone4
         TONE(4).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
         TONE(4).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
         TONE(4).init_delay(ii) = init_delay(ii);
         TONE(4).response(ii) = responses(ii);
         TONE(4).resp_time(ii) = resp_time(ii);
         TONE(4).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));

         TONE(4).z(ii,:) = (TONE(4).deltaf(ii,:)-mean(TONE(4).baseline(ii,:)))./std(TONE(4).baseline(ii,:));
        TONE(4).z_resp(ii,:) = (TONE(4).deltaf_resp(ii,:)-mean(TONE(4).baseline(ii,:)))./std(TONE(4).baseline(ii,:));


    elseif tones(ii) == tone5
         TONE(5).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
         TONE(5).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
         TONE(5).init_delay(ii) = init_delay(ii);
         TONE(5).response(ii) = responses(ii);
         TONE(5).resp_time(ii) = resp_time(ii);
         TONE(5).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));

         TONE(5).z(ii,:) = (TONE(5).deltaf(ii,:)-mean(TONE(5).baseline(ii,:)))./std(TONE(5).baseline(ii,:));
        TONE(5).z_resp(ii,:) = (TONE(5).deltaf_resp(ii,:)-mean(TONE(5).baseline(ii,:)))./std(TONE(5).baseline(ii,:));


    elseif tones(ii) == tone6
         TONE(6).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
         TONE(6).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
         TONE(6).init_delay(ii) = init_delay(ii);
         TONE(6).response(ii) = responses(ii);
         TONE(6).resp_time(ii) = resp_time(ii);
         TONE(6).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));

         TONE(6).z(ii,:) = (TONE(6).deltaf(ii,:)-mean(TONE(6).baseline(ii,:)))./std(TONE(6).baseline(ii,:));
        TONE(6).z_resp(ii,:) = (TONE(6).deltaf_resp(ii,:)-mean(TONE(6).baseline(ii,:)))./std(TONE(6).baseline(ii,:));


    elseif tones(ii) == tone7
         TONE(7).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
         TONE(7).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
         TONE(7).init_delay(ii) = init_delay(ii);
         TONE(7).response(ii) = responses(ii);
         TONE(7).resp_time(ii) = resp_time(ii);
         TONE(7).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));

         TONE(7).z(ii,:) = (TONE(7).deltaf(ii,:)-mean(TONE(7).baseline(ii,:)))./std(TONE(7).baseline(ii,:));
        TONE(7).z_resp(ii,:) = (TONE(7).deltaf_resp(ii,:)-mean(TONE(7).baseline(ii,:)))./std(TONE(7).baseline(ii,:));


    elseif tones(ii) == tone8
         TONE(8).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
         TONE(8).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
         TONE(8).init_delay(ii) = init_delay(ii);
         TONE(8).response(ii) = responses(ii);
         TONE(8).resp_time(ii) = resp_time(ii);
         TONE(8).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));
         
         TONE(8).z(ii,:) = (TONE(8).deltaf(ii,:)-mean(TONE(8).baseline(ii,:)))./std(TONE(8).baseline(ii,:));
        TONE(8).z_resp(ii,:) = (TONE(8).deltaf_resp(ii,:)-mean(TONE(8).baseline(ii,:)))./std(TONE(8).baseline(ii,:));


    else
    end
    TONE(9).deltaf(ii,:) = Lfilter(trigger_pks_locs(ii)-(FL):trigger_pks_locs(ii)+(3*FL));
    TONE(9).deltaf_resp(ii,:) = Lfilter(trigger_pks_locs(ii)+resp_time(ii)-FL:trigger_pks_locs(ii)+resp_time(ii)+(3*FL));
    TONE(9).init_delay(ii) = init_delay(ii);
    TONE(9).response(ii) = responses(ii);
    TONE(9).resp_time(ii) = resp_time(ii);
    TONE(9).baseline(ii,:) = Lfilter((trigger_pks_locs(ii)-init_delay(ii)-(3*FL)):trigger_pks_locs(ii)-init_delay(ii));
    
    TONE(9).z(ii,:) = (TONE(9).deltaf(ii,:)-mean(TONE(9).baseline(ii,:)))./std(TONE(9).baseline(ii,:));
    TONE(9).z_resp(ii,:) = (TONE(9).deltaf_resp(ii,:)-mean(TONE(9).baseline(ii,:)))./std(TONE(9).baseline(ii,:));

end


%% Remove zeroes

for iii = 1:(size(TONE,2))
    if size(TONE(iii).deltaf,1) > 1
        TONE(iii).deltaf = TONE(iii).deltaf(any(TONE(iii).deltaf,2),:);
        TONE(iii).deltaf_resp = TONE(iii).deltaf_resp(any(TONE(iii).deltaf_resp,2),:);
        TONE(iii).init_delay(TONE(iii).init_delay==0) = [];
        TONE(iii).response(TONE(iii).response==0) = [];
        TONE(iii).resp_time(TONE(iii).resp_time==0) = [];
        TONE(iii).baseline = TONE(iii).baseline(any(TONE(iii).baseline,2),:);
        TONE(iii).z = TONE(iii).z(any(TONE(iii).z,2),:);
        TONE(iii).z_resp = TONE(iii).z_resp(any(TONE(iii).z_resp,2),:);
    else
    end
end


%% Analysis based on response type

%1 or 3 = hit or false positive;

detect = [1 3];


for vii = 1:(size(TONE,2))
    for viii = 1:size(TONE(vii).deltaf,1)
        if ismember(TONE(vii).response(viii),detect) == 1
            TONE(vii).detect(viii,:) = TONE(vii).deltaf(viii,:);
            TONE(vii).detect_resp(viii,:) = TONE(vii).deltaf_resp(viii,:);
            
            TONE(vii).detect_z(viii,:) = TONE(vii).z(viii,:);
            TONE(vii).detect_resp_z(viii,:) = TONE(vii).z_resp(viii,:);
            
            TONE(vii).detect_baseline(viii,:) = TONE(vii).baseline(viii,:);
        else
            TONE(vii).withold(viii,:) = TONE(vii).deltaf(viii,:);
            TONE(vii).withold_resp(viii,:) = TONE(vii).deltaf_resp(viii,:);
            
            TONE(vii).withold_z(viii,:) = TONE(vii).z(viii,:);
            TONE(vii).withold_resp_z(viii,:) = TONE(vii).z_resp(viii,:);
            
            TONE(vii).withold_baseline(viii,:) = TONE(vii).baseline(viii,:);
        end
    end
end



for ix = 1:(size(TONE,2))
    TONE(ix).withold = TONE(ix).withold(any(TONE(ix).withold,2),:);
    TONE(ix).detect = TONE(ix).detect(any(TONE(ix).detect,2),:);
    
    TONE(ix).withold_z = TONE(ix).withold_z(any(TONE(ix).withold_z,2),:);
    TONE(ix).detect_z = TONE(ix).detect_z(any(TONE(ix).detect_z,2),:);
    
    TONE(ix).withold_resp = TONE(ix).withold_resp(any(TONE(ix).withold_resp,2),:);
    TONE(ix).detect_resp = TONE(ix).detect_resp(any(TONE(ix).detect_resp,2),:);
    
    TONE(ix).withold_resp_z = TONE(ix).withold_resp_z(any(TONE(ix).withold_resp_z,2),:);
    TONE(ix).detect_resp_z = TONE(ix).detect_resp_z(any(TONE(ix).detect_resp_z,2),:);
    
    TONE(ix).withold_baseline = TONE(ix).withold_baseline(any(TONE(ix).withold_baseline,2),:);
    TONE(ix).detect_baseline = TONE(ix).detect_baseline(any(TONE(ix).detect_baseline,2),:);
end



%% Plotting routine

x = (1:size(TONE(1).deltaf,2));

if size(TONE(1).detect,1) > 1
    figure; shadedErrorBar(x,TONE(1).detect_resp,{@mean,@std}); ylim([-.02 .04]); title('Target Resp') % original targt tone plotted
    figure; shadedErrorBar(x,TONE(1).detect,{@mean,@std}); ylim([-.02 .04]); title('Target Tone') % original targt tone plotted
else
end


%%

baseline_m = mean(Lfilter(1:120*FL));
baseline_SD = std(Lfilter(1:120*FL));

%% Peak analysis


for i = 1:size(TONE,2)
    for ii = 1:size(TONE(i).detect_resp,1)
        
               [TONE(i).resp_min_z(ii) TONE(i).resp_min_loc_z(ii)] = min(TONE(i).detect_resp_z(ii,1017:2034));
        [TONE(i).resp_peak_z(ii) TONE(i).resp_peak_loc_z(ii)] = max(TONE(i).detect_resp_z(ii,(1016+TONE(i).resp_min_loc_z(ii)):3051));

        
        [TONE(i).resp_min(ii) TONE(i).resp_min_loc(ii)] = min(TONE(i).detect_resp(ii,1017:2034));
        [TONE(i).resp_peak(ii) TONE(i).resp_peak_loc(ii)] = max(TONE(i).detect_resp(ii,(1016+TONE(i).resp_min_loc(ii)):3051));
    end
        TONE(i).resp_mag = TONE(i).resp_peak-TONE(i).resp_min;
        TONE(i).resp_mag_z = TONE(i).resp_peak_z-TONE(i).resp_min_z;
        
    for iii = 1:size(TONE(i).detect,1)
        
        [TONE(i).tone_min_z(iii) TONE(i).tone_min_loc_z(iii)] = min(TONE(i).detect_z(iii,1017:2034));
        [TONE(i).tone_peak_z(iii) TONE(i).tone_peak_loc_z(iii)] = max(TONE(i).detect_z(iii,(1016+TONE(i).tone_min_loc_z(iii)):2034));
        
        [TONE(i).tone_min(iii) TONE(i).tone_min_loc(iii)] = min(TONE(i).detect(iii,1017:2034));
        [TONE(i).tone_peak(iii) TONE(i).tone_peak_loc(iii)] = max(TONE(i).detect(iii,(1016+TONE(i).tone_min_loc(iii)):2034));
    end
        TONE(i).tone_mag = TONE(i).tone_peak-TONE(i).tone_min;
        TONE(i).tone_mag_z = TONE(i).tone_peak_z-TONE(i).tone_min_z;
end


%% Save


fname_save = strcat(fname, '-analysis.mat');
save(fname_save, 'TONE')



close all; clear all

