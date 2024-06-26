clear all
close all
clc


if(~isdeployed)
    cd(fileparts(which(mfilename)));
end


mdl_name = "float_sch_SigmaDelta_AdaptiveThreshold";


%% Simulation parameters
fs = 30000; %Hz - sampling frequency
fn = fs/2;  %Hz - Nyquist frequency
refractory = 10^-3; %refractory period
ToStd = 1.27;   %conversion coefficient from % to std
buffer_PWM = 128;   %length of the PWM buffer
buffer_PWM_overlap = 0; %overlap of the PWM buffer
feature_gain = [5];   %%adaptive threshold gain
prop_coeff = 0.1;   %proportional coefficiant of the integrator
sim_type = 'normal'; %simulation speed
sim_stop_time = '5';   %s --> at least 40s, see below


%% Performance analysis parameters
w_len = fs/1000;  %samples --> 1ms
peak_diff = 15; %samples --> max spike position distance between recording and ground truth
spiketrain = 1; %ground_truth selected for performance evaluation
%peak_diff --> tolerance

%% Data loading
filename = 'monotrode_test_20';

signal = load([filename,'.mat']);
ground = load([filename,'_gt.mat']);


%% Simulation with different thresholds
numSims = length(feature_gain);   %number of simulation depending on number of thresholds

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





