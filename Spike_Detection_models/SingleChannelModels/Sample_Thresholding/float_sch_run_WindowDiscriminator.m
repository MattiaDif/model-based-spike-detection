clear all
close all
clc


if(~isdeployed)
    cd(fileparts(which(mfilename)));
end


if isfile('D:\GitHub\model-based-spike-detection\Spike_Detection_models\Results\result.mat')
    load 'D:\GitHub\model-based-spike-detection\Spike_Detection_models\Results\result.mat'; %result structureù
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


%% Get simulation output
for curr_sim = 1:numSims
    
    simOut = out(curr_sim);
    ground_truth_ts(curr_sim,:) = simOut.logsout.get('ground_truth').Values;
    recording_ts(curr_sim,:) = simOut.logsout.get('recording').Values;
    DAC_fsm_counter_max_ts(curr_sim,:) = simOut.logsout.get('DAC_fsm_counter==max').Values;
    spikes_ts(curr_sim,:) = simOut.logsout.get('spikes').Values;
    interspike_ts(curr_sim,:) = simOut.logsout.get('interspike').Values;

    recording(curr_sim,:) = recording_ts(curr_sim).Data;
    DAC_fsm_counter_max(curr_sim,:) = DAC_fsm_counter_max_ts(curr_sim).Data;
    spikes(curr_sim,:) = spikes_ts(curr_sim).Data;
    interspike(curr_sim,:) = interspike_ts(curr_sim).Data;
    
    ground_truth(curr_sim,:) = zeros(1,size(recording,2));
    for train = 1:spiketrain
        ground_truth(curr_sim,:) = ground_truth(curr_sim,:) + ground_truth_ts(curr_sim).Data(:,train)';
    end


    % Performance evaluation
    P(curr_sim) = sum(round(ground_truth(curr_sim,:)));    %P    %round due to some quantization error (some samples were e-11 instead of 0)
    NDS(curr_sim) = sum(round(spikes(curr_sim,:)));  %NDS

    spikes_locks{curr_sim,:} = find(round(spikes(curr_sim,:)));    %samples
    ground_locks{curr_sim,:} = find(round(ground_truth(curr_sim,:))); %samples
    
    TP(curr_sim) = 0;
    for i=1:length(spikes_locks{curr_sim,:})
        locks_diff = [];
        TP_temp = [];
        locks_diff = abs(spikes_locks{curr_sim,:}(i) - ground_locks{curr_sim,:});
        TP_temp = find(locks_diff <= peak_diff);
        if isempty(TP_temp)
            TP(curr_sim) = TP(curr_sim);
        else
            TP(curr_sim) = TP(curr_sim) + 1;
        end
    end

    FN(curr_sim) = P(curr_sim) - TP(curr_sim);
    FP(curr_sim) = NDS(curr_sim) - TP(curr_sim);
    
    N(curr_sim) = ((length(recording(curr_sim,:)))-P(curr_sim)*w_len)/w_len;
    
    TN(curr_sim) = N(curr_sim) - FP(curr_sim);
    accuracy(curr_sim) = (TP(curr_sim) + TN(curr_sim))/(P(curr_sim)+N(curr_sim));
    perf(curr_sim) = TP(curr_sim)/(FP(curr_sim)+FN(curr_sim));
    eff(curr_sim) = perf(curr_sim)/(perf(curr_sim)+1);
    sens(curr_sim) = TP(curr_sim)/(TP(curr_sim)+FN(curr_sim));
    spec(curr_sim) = TN(curr_sim)/N(curr_sim);
    prec(curr_sim) = TP(curr_sim)/(TP(curr_sim)+FP(curr_sim));
    NPV(curr_sim) = TN(curr_sim)/(TN(curr_sim)+FN(curr_sim));
    FNR(curr_sim) = FN(curr_sim)/(FN(curr_sim)+TP(curr_sim));
    FPR(curr_sim) = FP(curr_sim)/(FP(curr_sim)+TP(curr_sim));
    F1score(curr_sim) = 2*TP(curr_sim)/(2*TP(curr_sim)+FN(curr_sim)+FP(curr_sim));
    MCC(curr_sim) = (TP(curr_sim)*TN(curr_sim)-FP(curr_sim)*FN(curr_sim))/...
                    sqrt((TP(curr_sim)+FP(curr_sim))*(TP(curr_sim)+FN(curr_sim))*(TN(curr_sim)+FP(curr_sim))*(TN(curr_sim)+FN(curr_sim)));

    FPrate(curr_sim) = FP(curr_sim)/N(curr_sim);
    TPrate(curr_sim) = TP(curr_sim)/P(curr_sim);
        
end


%% ROC, confusion matrix, AUC
FPrate = [1 FPrate 0];
TPrate = [1 TPrate 0];

figure
plot(flip(FPrate),flip(TPrate),'r','LineWidth',2)
xlabel('FP rate')
ylabel('TP rate')
title('Hard Threshold ROC')
set(gca,'FontSize',14)
axis([0 1 0 1])

AUC = -trapz(FPrate,TPrate);










