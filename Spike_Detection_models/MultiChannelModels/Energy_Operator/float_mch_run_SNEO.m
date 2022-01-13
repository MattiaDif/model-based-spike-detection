clear all
close all
clc


mdl_name = "float_mch_SNEO";


%% Simulation parameters
fs = 30000; %Hz - sampling frequency
fn = fs/2;  %Hz - Nyquist frequency
refractory = 10^-3; %refractory period
w_smooth = fs/1000;  %smoothing window length
TEO_buffer = w_smooth;    %TEO buffer length
TEO_buffer_overlap = TEO_buffer - 1;    %TEO buffer overlap
feature_buffer = fs;    %feature buffer length
feature_gain = [4];   %adaptive threshold gain
sim_type = 'normal'; %simulation speed
sim_stop_time = '5';   %s


%% Performance analysis parameters
% w_len = fs/1000;  %samples --> 1ms
% peak_diff = 25; %samples --> max spike position distance between recording and ground truth
% spiketrain = 1; %ground_truth selected for performance evaluation
%peak_diff --> tolerance

%% Data loading
filename = 'tetrode_test_20';

signal = load([filename,'.mat']);
ground = load([filename,'_gt.mat']);


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

