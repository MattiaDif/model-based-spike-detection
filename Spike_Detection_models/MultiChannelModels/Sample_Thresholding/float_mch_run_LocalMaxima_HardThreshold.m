clear all
close all
clc


if(~isdeployed)
    cd(fileparts(which(mfilename)));
end



mdl_name = "float_mch_LocalMaxima_HardThreshold";


%% Simulation parameters
fs = 30000; %Hz - sampling frequency
fn = fs/2;  %Hz - Nyquist frequency
refractory = 10^-3; %refractory period
th=[-60, -60, -60, -60]; % sweeping  thresholds
sim_type = 'Normal'; %simulation speed
sim_stop_time = '5';   %s


%% Performance analysis parameters
% w_len = fs/1000;  %samples --> 1ms
% peak_diff = 15; %samples --> max spike position distance between recording and ground truth
% spiketrain = 1; %number of ground_truth
%peak_diff --> tolerance

%% Data loading
filename = 'tetrode_test_20';

signal = load([filename,'.mat']);
ground = load([filename,'_gt.mat']);


%% Simulation with different thresholds
numSims = size(th,1);   %number of simulation depending on number of thresholds

%Simulation parameters
mdl=convertStringsToChars(mdl_name);
load_system(mdl);
set_param(mdl, 'SimulationMode', sim_type)
set_param(mdl,'StartTime','0','StopTime',sim_stop_time)
BlockPaths = find_system(mdl,'Type','Block')
BlockDialogParameters = get_param([mdl '/threshold'],'DialogParameters')

%Input setting
for curr_sim = 1:numSims
    in(curr_sim) = Simulink.SimulationInput(mdl);
%     in(curr_sim) = setBlockParameter(in(curr_sim), [mdl '/threshold'], 'const', num2str(th(curr_sim,:)));
end

%Simulation running
out = sim(in,'ShowProgress', 'on');
