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


%% Get simulation output
for curr_sim = 1:numSims
    
    simOut = out(curr_sim);
    ground_truth_ts(curr_sim,:) = simOut.logsout.get('ground_truth').Values;
    recording_ts(curr_sim,:) = simOut.logsout.get('recording').Values;
    PWM_ts(curr_sim,:) = simOut.logsout.get('PWM%').Values;
    threshold_ts(curr_sim,:) = simOut.logsout.get('threshold').Values;
    sample_above_th_ts(curr_sim,:) = simOut.logsout.get('sample_above_th').Values;
    spikes_ts(curr_sim,:) = simOut.logsout.get('spikes').Values;
    interspike_ts(curr_sim,:) = simOut.logsout.get('interspike').Values;
    
    % to avoid the first 30s of recording to allow the achievement of the
    % convergence by the adaptive threshold except for PWM (in this case I
    % avoided just 1 second due to the length of the example signal)
    recording(curr_sim,:) = recording_ts(curr_sim).Data(1,1,fs+1:end);
    PWM(curr_sim,:) = PWM_ts(curr_sim).Data;
    threshold(curr_sim,:) = threshold_ts(curr_sim).Data(1,1,fs+1:end);
    sample_above_th(curr_sim,:) = sample_above_th_ts(curr_sim).Data(1,1,fs+1:end);
    spikes(curr_sim,:) = spikes_ts(curr_sim).Data(1,1,fs+1:end);
    interspike(curr_sim,:) = interspike_ts(curr_sim).Data(1,1,fs+1:end);
    
    ground_truth(curr_sim,:) = zeros(1,size(recording,2));
    for train = 1:spiketrain
        ground_truth(curr_sim,:) = ground_truth(curr_sim,:) + ground_truth_ts(curr_sim).Data(fs+1:end,train)';
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
title('SigmaDelta ROC')
set(gca,'FontSize',14)
axis([0 1 0 1])

AUC = abs(trapz(FPrate,TPrate));





