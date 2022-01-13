clear all
close all
clc


mdl_name = "float_mch_TemplateMatchingContinuous";


filename = 'tetrode_test_20';
load([filename,'_waveforms_mean.mat']);

%% Simulation parameters
load([filename,'.mat']);
fs = 30000; %Hz - sampling frequency
fn = fs/2;  %Hz - Nyquist frequency
refractory = 10^-3; %refractory period
template = double(mean_waveform{1, 1})';  %template extracted from MEArec dataset
% template2 = double(mean_waveform{1, 2}(:,str2num(ch(3:end))))';
% template3 = double(mean_waveform{1, 3}(:,str2num(ch(3:end))))';
buffer_rec = length(template);    %buffer length
buffer_overlap = buffer_rec - 1;    %buffer overlap
score = [3000];
sim_type = 'normal'; %simulation speed
sim_stop_time = '5';   %s


%% Performance analysis parameters
% w_len = fs/1000;  %samples --> 1ms
% peak_diff = 65; %samples --> max spike position distance between recording and ground truth
% spiketrain = 1; %ground_truth selected for performance evaluation


%% Data loading
filename = 'tetrode_test_20';

signal = load([filename,'.mat']);
ground = load([filename,'_gt.mat']);


%% Simulation with different thresholds
numSims = length(score);   %number of simulation depending on number of thresholds

%Simulation parameters
mdl=convertStringsToChars(mdl_name);
load_system(mdl);
set_param(mdl, 'SimulationMode', sim_type)
set_param(mdl,'StartTime','0','StopTime',sim_stop_time)
BlockPaths = find_system(mdl,'Type','Block')
BlockDialogParameters = get_param([mdl '/template matching/score_th'],'DialogParameters')
% BlockDialogParameters = get_param([mdl '/template matching2/score_th'],'DialogParameters')
% BlockDialogParameters = get_param([mdl '/template matching2/score_th'],'DialogParameters')


%Input setting
for curr_sim = 1:numSims
    in(curr_sim) = Simulink.SimulationInput(mdl);
    in(curr_sim) = setBlockParameter(in(curr_sim), [mdl '/template matching/score_th'], 'const', num2str(score(curr_sim)));
%     in(curr_sim) = setBlockParameter(in(curr_sim), [mdl '/template matching2/score_th'], 'const', num2str(score(curr_sim)));
%     in(curr_sim) = setBlockParameter(in(curr_sim), [mdl '/template matching3/score_th'], 'const', num2str(score(curr_sim)));
end

%Simulation running
out = sim(in,'ShowProgress', 'on');

