%% Calculates evoked spiking after CI stimulation for individual sweeps at individual recording sites

function [num,xval, SWEEP] = CI_spike_rate_EG(input_all,dur,rms_multiple,aud_index)%(handles)
load mtlb

sample_rate = 33333;   
numtones = 1;         
numtrials = 20;          % number of trials for each tone          
base_start = 6334;
base_end = 13000;    % sample number to stop baseline % 200 ms total   

basedur = base_end-base_start;


ms = dur/1000;
stim_start = 13550;  % sample number to start stimulation % starts at tone onset: 400 ms    
stimdur = ms*sample_rate;
stim_end = stim_start+stimdur;

base_multiple = round(abs(basedur/stimdur));
 
 
input = input_all(:,aud_index,:); % auditory trace


for i = 1:size(input_all,3)

    SWEEP(i).raw = input_all(:,aud_index,i);
    SWEEP(i).base = (SWEEP(i).raw(base_start:base_end));
    SWEEP(i).stim = (SWEEP(i).raw(stim_start:stim_end));

    SWEEP(i).rmsinput = rms(SWEEP(i).raw(1:base_end));
    [SWEEP(i).all_pks, SWEEP(i).all_locs] = findpeaks(SWEEP(i).raw,'MinPeakHeight',rms_multiple*SWEEP(i).rmsinput);
    SWEEP(i).num_points = 0.1*ones(1,length(SWEEP(i).all_locs));
    
   
    SWEEP(i).basespikes = sum(SWEEP(i).all_locs<base_end & SWEEP(i).all_locs>base_start)/base_multiple;
    base_locs = (SWEEP(i).all_locs<base_end & SWEEP(i).all_locs>base_start);
    SWEEP(i).basespike_loc = SWEEP(i).all_locs;
    SWEEP(i).basespike_loc(base_locs==0) = [];
    
    SWEEP(i).spontrate = sum(SWEEP(i).all_locs<base_end & SWEEP(i).all_locs>base_start)/(basedur/sample_rate);

    SWEEP(i).stimspikes = sum(SWEEP(i).all_locs<stim_end & SWEEP(i).all_locs>stim_start);
    stim_locs = (SWEEP(i).all_locs<stim_end & SWEEP(i).all_locs>stim_start);
    SWEEP(i).stimspike_loc = SWEEP(i).all_locs;
    SWEEP(i).stimspike_loc(stim_locs==0) = [];
end


for n = 1:size(SWEEP,2)
    spikeTimes = SWEEP(n).all_locs';
    stimTimes = 13350;
    SWEEP(n).PSTH = PSTH(spikeTimes, stimTimes);
end

PSTH_all = [];

for m = 1:size(SWEEP,2)
    PSTH_all = [PSTH_all SWEEP(m).PSTH];
end

[num,xval] = hist(PSTH_all, 200);



