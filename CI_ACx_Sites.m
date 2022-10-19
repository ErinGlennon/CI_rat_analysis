%% Generates z-scored responses across sweeps for individual cortical recording sites and stimuli

function [zscore spont_avg] = CI_ACx_Sites(dur, rms_multiple, aud_index)

p = path;                                                                  % to restore the path afterwards
disp('Pick the folder with files to analyze');                            % display in command window info about what type of folder you should pick 
filestosort = uigetdir;                                                    % open folder selection dialog box
path(p, filestosort);                                                      % temporarily add random folder to the path to read things about it
tempp = path; 
d     = dir(filestosort); 
filelist = listdlg('PromptString', 'Pick files to sort: ', ...
                    'SelectionMode', 'multiple',...
                    'ListString', {d.name}); 
 


                
for list = 1:size(filelist,2)
   fname=[filestosort,'/',d(filelist(list)).name];
   input_all=abfload(fname); 
   raw = input_all(:,aud_index,:); % auditory trace
   [CI(list).PSTH CI(list).xval CI(list).SWEEP] = CI_spike_rate_EG(input_all,dur,rms_multiple,aud_index);
   
   sample_rate = 33333;
  
   
   stim_avg = mean([CI(list).SWEEP.stimspikes]);
   stim_std = std([CI(list).SWEEP.stimspikes]);
    
   base_avg = mean([CI(list).SWEEP.basespikes]);
   base_std = std([CI(list).SWEEP.basespikes]);

   base_dur = length(CI(list).SWEEP(1).base)/sample_rate;
   stim_dur = length(CI(list).SWEEP(1).stim)/sample_rate;
   
   CI(list).zscore = (stim_avg-base_avg)/base_std;
   CI(list).spont_avg = mean([CI(list).SWEEP.spontrate]);
   
   spont_base_avg = CI(list).spont_avg*stim_dur;
   spont_base_std = std([CI(list).SWEEP.spontrate])*stim_dur;
   
   CI(list).zscore_spont = (stim_avg-spont_base_avg)/spont_base_std;
   
   CI(list).dur = dur;
   CI(list).rms_multiple = rms_multiple;
   

   
end

for n = 1:size(CI, 2)
    CI_PSTH_all(n,:) = CI(n).PSTH;
end

zscore = [CI.zscore];
spont_avg = [CI.spont_avg];

truncname = strsplit(convertCharsToStrings(filestosort),'/');
truncname = convertStringsToChars(truncname(end));

save(truncname, 'CI');

clc;
