clear all
close all
clc


if(~isdeployed)
    cd(fileparts(which(mfilename)));
end


mdl_name = "float_sch_WindowDiscriminator";


%% Simulation parameters
fs = 30000; %Hz - sampling frequency
fn = fs/2;  %Hz - Nyquist frequency
refractory = 10^-3; %refractory period

% inclusione exclusion amplitude thresholds
th1 = [-39.975]; th2 = [-148.98]; th3 = [-24.96]; th4 = [13.065];
th5 = [-11]; th6 = [-11]; th7 = [-11]; th8 = [-11];

DAC_stop_max = 15;  % if DAC_sto_max = 15 --> spike detected

% inclusion exclusion temporal thresholds
start1 = 0; stop1 = 1;
start2 = 1; stop2 = 6;
start3 = 4; stop3 = 11;
start4 = 3; stop4 = 15;
start5 = 3; stop5 = 2;
start6 = 3; stop6 = 2;
start7 = 3; stop7 = 2;
start8 = 3; stop8 = 2;

%DAC_type
DAC_type1 = 0; DAC_type2 = 1; DAC_type3 = 1; DAC_type4 = 1;
DAC_type5 = 0; DAC_type6 = 0; DAC_type7 = 0; DAC_type8 = 0;

%DAC_enable
DAC_enable1 = 1; DAC_enable2 = 1; DAC_enable3 = 1; DAC_enable4 = 1;
DAC_enable5 = 0; DAC_enable6 = 0; DAC_enable7 = 0; DAC_enable8 = 0;

sim_type = 'normal'; %simulation speed
sim_stop_time = '5';   %s


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
numSims = 1;   %number of simulation depending on number of thresholds

%Simulation parameters
mdl=convertStringsToChars(mdl_name);
load_system(mdl);
set_param(mdl, 'SimulationMode', sim_type)
set_param(mdl,'StartTime','0','StopTime',sim_stop_time)
BlockPaths = find_system(mdl,'Type','Block')
% BlockDialogParameters = get_param([mdl '/threshold'],'DialogParameters')

%Input setting
for curr_sim = 1:numSims
    in(curr_sim) = Simulink.SimulationInput(mdl);
end

%Simulation running
out = sim(in,'ShowProgress', 'on');










