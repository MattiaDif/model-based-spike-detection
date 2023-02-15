clear all
close all
clc


if(~isdeployed)
    cd(fileparts(which(mfilename)));
end


mdl_name = "float_sch_SWTTEO";


%wavelet
wname = 'sym5';
% iter = 2;
%[phi,psi,xval] = wavefun(wname,iter);
wav_approx = [-0.019538882735286728
                -0.021101834024758855
                0.17532808990845047
                0.01660210576452232
                -0.6339789634582119
                0.7234076904024206
                -0.1993975339773936
                -0.039134249302383094
                -0.029519490925774643
                0.027333068345077982
                ]';  %sym5 decomposition high-pass filter
    
% wav_detail = [0.027333068345077982
%                 0.029519490925774643
%                 -0.039134249302383094
%                 0.1993975339773936
%                 0.7234076904024206
%                 0.6339789634582119
%                 0.01660210576452232
%                 -0.17532808990845047
%                 -0.021101834024758855
%                 0.019538882735286728
%                 ]'; %sym5 decomposition low-pass filter



%% Simulation parameters
fs = 30000; %Hz - sampling frequency
fn = fs/2;  %Hz - Nyquist frequency
refractory = 10^-3; %refractory period
TEO_buffer = length(wav_approx)-1;    %TEO buffer length
TEO_buffer_overlap = TEO_buffer-1;    %TEO buffer overlap
feature_buffer = fs;    %feature buffer length
feature_gain = [3];   %adaptive threshold gain
hamming_w_length = 32;  %hamming window length in samples
buffer_hamming_length = hamming_w_length;   %buffer length before smoothing in samples
buffer_hamming_length_overlap = buffer_hamming_length - 1;
sim_type = 'normal'; %simulation speed
sim_stop_time = '5';   %s




%% Performance analysis parameters
w_len = fs/1000;  %samples --> 1ms
peak_diff = 25; %samples --> max spike position distance between recording and ground truth
spiketrain = 1; %ground_truth selected for performance evaluation
%peak_diff --> tolerance


%% Data loading
filename = 'monotrode_test_20';

signal = load([filename,'.mat']);
ground = load([filename,'_gt.mat']);

signal = load([filename,'.mat']);
ground = load([filename,'_gt.mat']);

% load(['sim_results_',num2str(noise_level),'.mat']);


%% Simulation with different thresholds
numSims = length(feature_gain);   %number of simulation depending on number of feature gain

%Simulation parameters
mdl=convertStringsToChars(mdl_name);
load_system(mdl);
set_param(mdl, 'SimulationMode', sim_type)
set_param(mdl,'StartTime','0','StopTime',sim_stop_time)
BlockPaths = find_system(mdl,'Type','Block')
BlockDialogParameters = get_param([mdl '/th gain'],'DialogParameters')

%Input setting
for curr_sim = 1:numSims
    in(curr_sim) = Simulink.SimulationInput(mdl);
    in(curr_sim) = setBlockParameter(in(curr_sim), [mdl '/th gain'], 'Gain', num2str(feature_gain(curr_sim)));
end

%Simulation running
out = sim(in,'ShowProgress', 'on');





