%% Analyzes NRT data collected in Custom Sound (output is Excel)

p = path;
disp('Pick the folder with NRT to analyze');                            % display in command window info about what type of folder you should pick 
filestosort = uigetdir;                                                    % open folder selection dialog box
path(p, filestosort);                                                      % temporarily add random folder to the path to read things about it
tempp = path; 
d     = dir(filestosort); 
filelist = listdlg('PromptString', 'Pick files to sort: ', ...
                    'ListSize', [300,500],...
                    'SelectionMode', 'single',...
                    'ListString', {d.name}); 
                
fname=[filestosort,'/',d(filelist).name]; 


T = readmatrix(fname);
probe = T(:,1:4);
probe(:,3) = [];


opts = detectImportOptions(fname);
opts.SelectedVariableNames = [1:4];
opts.DataRange = 'B2';
opts.Sheet = 'NRT Recordings';
opts.VariableTypes(1,3) = {'double'};
traces = readmatrix(fname,opts);



for i = 1:length(probe)
    NRT(i).CL = probe(i,3);
    NRT(i).channel = probe(i,2);
    for ii = 1:length(traces)
        if traces(ii,1) == i
            NRT(i).trace(ii) = traces(ii,4);
            NRT(i).trace(NRT(i).trace==0) = [];  
            NRT(i).trace = NRT(i).trace';
            
            NRT(i).time(ii) = traces(ii,3);
            NRT(i).time(NRT(i).time==0) = []; 
            NRT(i).time = NRT(i).time';
        else
        end
    end
end

for peaks = 1:length(NRT)
    if isempty(NRT(peaks).trace) == 0
        [NRT(peaks).p1,I_p1]= max(NRT(peaks).trace(1:10));
        NRT(peaks).p1_loc = NRT(peaks).time(I_p1);
        
        [NRT(peaks).n1, I_n1] = min(NRT(peaks).trace(1:10));
        NRT(peaks).n1_loc = NRT(peaks).time(I_n1);
        
        NRT(peaks).amplitude = NRT(peaks).p1 - NRT(peaks).n1;

        [NRT(peaks).p1_2, I_p1_2] = max(NRT(peaks).trace(1:5));
        NRT(peaks).p1_2_loc = NRT(peaks).time(I_p1_2);
        
        [NRT(peaks).n1_2, I_n1_2] = min(NRT(peaks).trace(1:5));
        NRT(peaks).n1_2_loc = NRT(peaks).time(I_n1_2);
        
        NRT(peaks).amplitude_2 = NRT(peaks).p1_2 - NRT(peaks).n1_2;
    else
    end
end


fname_out = d(filelist).name(1:end-16);
fname_save = strcat(fname_out, '_NRT');
save(fname_save, 'NRT')

clear all; close all