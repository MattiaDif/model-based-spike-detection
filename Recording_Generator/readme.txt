recording --> dataset for the performance analysis
test --> data provided for model testing on github


-neuronexus32_recording_(noise_level):
recordings generated from neuronexus32_templates with the following parameters:

TEMPLATE - njobs = None (13x20)
#intracellular
template_params['sim_time'] = 2
template_params['target_spikes'] = [3, 50]
template_params['cut_out'] = [2, 5]
template_params['dt'] = 1/30
template_params['delay'] = 10
template_params['weights'] = [0.25, 1.75]

#extracellular
template_params['n'] = 20
template_params['probe'] = 'Neuronexus-32'
template_params['rot'] ='physrot'
template_params['ncontacts'] = 10
template_params['overhang'] = 30
template_params['offset'] = 0
template_params['xlim'] = None
template_params['ylim'] = None
template_params['zlim'] = None
template_params['det_thresh'] = 30
template_params['seed'] = None

#drift
template_params['drifting'] = True
template_params['max_drift'] = 100
template_params['min_drift'] = 20
template_params['drift_steps'] = 50
template_params['drift_xlim'] = [-10, 10]
template_params['drift_ylim'] = [-10, 10]
template_params['drift_zlim'] = [20, 80]


RECORDING
#spike trains
#recordings_params['rates'] = [3, 3, 5]
#recordings_params['types'] = ['E', 'E', 'I']
recordings_params['spiketrains']['n_exc'] = 2
recordings_params['spiketrains']['n_inh'] = 1
recordings_params['spiketrains']['f_exc'] = 5
recordings_params['spiketrains']['f_inh'] = 15
recordings_params['spiketrains']['st_exc'] = 1
recordings_params['spiketrains']['st_inh'] = 3
recordings_params['spiketrains']['min_rate'] = 0.5
recordings_params['spiketrains']['ref_per'] = 2
recordings_params['spiketrains']['process'] = 'poisson'
recordings_params['spiketrains']['gamma_shape'] = 2
recordings_params['spiketrains']['t_start'] = 0
recordings_params['spiketrains']['duration'] = 180

#cell types
recordings_params['cell_types']['excitatory'] = ['STPC', 'TTPC1', 'TTPC2', 'UTPC']
recordings_params['cell_types']['inhibitory'] = ['BP', 'BTC', 'ChC', 'DBC', 'LBC', 'MC', 'NBC', 'NGC', 'SBC']

#templates
recordings_params['templates']['min_dist'] = 25
recordings_params['templates']['min_amp'] = 50
recordings_params['templates']['max_amp'] = 500
recordings_params['templates']['xlim'] = None
recordings_params['templates']['ylim'] = None
recordings_params['templates']['zlim'] = None
recordings_params['templates']['n_jitters'] = 10
recordings_params['templates']['upsample'] = 8
recordings_params['templates']['pad_len'] = [3, 3]
recordings_params['templates']['overlap_threshold'] = 0.9
recordings_params['templates']['seed'] = None

#recording
recordings_params['recordings']['dtype'] = 'float64'
recordings_params['recordings']['fs'] = None
recordings_params['recordings']['sync_rate'] = 0
recordings_params['recordings']['sync_jitt'] = 1
recordings_params['recordings']['modulation'] = 'electrode'
recordings_params['recordings']['sdrand'] = 0.05
recordings_params['recordings']['chunk_duration'] = 20

recordings_params['recordings']['bursting'] = False
recordings_params['recordings']['exp_decay'] = 0.1
recordings_params['recordings']['n_burst_spikes'] = 10
recordings_params['recordings']['max_burst_duration'] = 100
recordings_params['recordings']['shape_mod'] = False
recordings_params['recordings']['shape_stretch'] = 30
recordings_params['recordings']['n_bursting'] = 3

recordings_params['recordings']['noise_level'] = noise_level
recordings_params['recordings']['noise_mode'] = 'uncorrelated'
recordings_params['recordings']['noise_color'] = True
recordings_params['recordings']['noise_half_distance'] = 100
recordings_params['recordings']['far_neurons_n'] = 300
recordings_params['recordings']['far_neurons_max_amp'] = 10
recordings_params['recordings']['far_neurons_noise_floor'] = 0.5
recordings_params['recordings']['far_neurons_exc_inh_ratio'] = 0.8
recordings_params['recordings']['color_peak'] = 500
recordings_params['recordings']['color_q'] = 1
recordings_params['recordings']['random_noise_floor'] = 1

recordings_params['recordings']['filter'] = False
recordings_params['recordings']['filter_cutoff'] = [300, 6000]
recordings_params['recordings']['filter_order'] = 3

recordings_params['recordings']['overlap'] = False
recordings_params['recordings']['extract_waveforms'] = True

recordings_params['recordings']['drifting'] = True
recordings_params['recordings']['drift_mode'] = 'slow'
recordings_params['recordings']['n_drifting'] = 50
recordings_params['recordings']['preferred_dir'] = [0, 0, 1]
recordings_params['recordings']['angle_tol'] = 15
recordings_params['recordings']['slow_drift_velocity'] = 10
recordings_params['recordings']['fast_drift_period'] = 10
recordings_params['recordings']['fast_drift_max_jump'] = 20
recordings_params['recordings']['fast_drift_min_jump'] = 5
recordings_params['recordings']['t_start_drift'] = 0

#seed
recordings_params['seeds']['spiketrains'] = None
recordings_params['seeds']['templates'] = None
recordings_params['seeds']['convolution'] = None
recordings_params['seeds']['noise'] = None




-monotrode_test_(noise_level):
recordings generated from monotrode_templates with the following parameters:

TEMPLATE - njobs = 10(x1)
#intracellular
template_params['sim_time'] = 2
template_params['target_spikes'] = [3, 50]
template_params['cut_out'] = [2, 5]
template_params['dt'] = 1/30
template_params['delay'] = 10
template_params['weights'] = [0.25, 1.75]

#extracellular
template_params['n'] = 1
template_params['probe'] = 'monotrode'
template_params['rot'] ='physrot'
template_params['ncontacts'] = 10
template_params['overhang'] = 30
template_params['offset'] = 0
template_params['xlim'] = None
template_params['ylim'] = None
template_params['zlim'] = None
template_params['det_thresh'] = 30
template_params['seed'] = None

#drift
template_params['drifting'] = True
template_params['max_drift'] = 100
template_params['min_drift'] = 20
template_params['drift_steps'] = 50
template_params['drift_xlim'] = [-10, 10]
template_params['drift_ylim'] = [-10, 10]
template_params['drift_zlim'] = [20, 80]


RECORDING
#spike trains
#recordings_params['rates'] = [3, 3, 5]
#recordings_params['types'] = ['E', 'E', 'I']
recordings_params['spiketrains']['n_exc'] = 1
recordings_params['spiketrains']['n_inh'] = 0
recordings_params['spiketrains']['f_exc'] = 5
recordings_params['spiketrains']['f_inh'] = 15
recordings_params['spiketrains']['st_exc'] = 1
recordings_params['spiketrains']['st_inh'] = 3
recordings_params['spiketrains']['min_rate'] = 0.5
recordings_params['spiketrains']['ref_per'] = 2
recordings_params['spiketrains']['process'] = 'poisson'
recordings_params['spiketrains']['gamma_shape'] = 2
recordings_params['spiketrains']['t_start'] = 0
recordings_params['spiketrains']['duration'] = 30

#cell types
recordings_params['cell_types']['excitatory'] = ['STPC', 'TTPC1', 'TTPC2', 'UTPC']
recordings_params['cell_types']['inhibitory'] = ['BP', 'BTC', 'ChC', 'DBC', 'LBC', 'MC', 'NBC', 'NGC', 'SBC']

#templates
recordings_params['templates']['min_dist'] = 25
recordings_params['templates']['min_amp'] = 50
recordings_params['templates']['max_amp'] = 500
recordings_params['templates']['xlim'] = None
recordings_params['templates']['ylim'] = None
recordings_params['templates']['zlim'] = None
recordings_params['templates']['n_jitters'] = 10
recordings_params['templates']['upsample'] = 8
recordings_params['templates']['pad_len'] = [3, 3]
recordings_params['templates']['overlap_threshold'] = 0.9
recordings_params['templates']['seed'] = None

#recording
recordings_params['recordings']['dtype'] = 'float32'
recordings_params['recordings']['fs'] = None
recordings_params['recordings']['sync_rate'] = 0
recordings_params['recordings']['sync_jitt'] = 1
recordings_params['recordings']['modulation'] = 'electrode'
recordings_params['recordings']['sdrand'] = 0.05
recordings_params['recordings']['chunk_duration'] = 20

recordings_params['recordings']['bursting'] = False
recordings_params['recordings']['exp_decay'] = 0.1
recordings_params['recordings']['n_burst_spikes'] = 10
recordings_params['recordings']['max_burst_duration'] = 100
recordings_params['recordings']['shape_mod'] = False
recordings_params['recordings']['shape_stretch'] = 30
recordings_params['recordings']['n_bursting'] = 3

recordings_params['recordings']['noise_level'] = noise_level
recordings_params['recordings']['noise_mode'] = 'uncorrelated'
recordings_params['recordings']['noise_color'] = True
recordings_params['recordings']['noise_half_distance'] = 100
recordings_params['recordings']['far_neurons_n'] = 300
recordings_params['recordings']['far_neurons_max_amp'] = 10
recordings_params['recordings']['far_neurons_noise_floor'] = 0.5
recordings_params['recordings']['far_neurons_exc_inh_ratio'] = 0.8
recordings_params['recordings']['color_peak'] = 500
recordings_params['recordings']['color_q'] = 1
recordings_params['recordings']['random_noise_floor'] = 1

recordings_params['recordings']['filter'] = False
recordings_params['recordings']['filter_cutoff'] = [300, 6000]
recordings_params['recordings']['filter_order'] = 3

recordings_params['recordings']['overlap'] = False
recordings_params['recordings']['extract_waveforms'] = True

recordings_params['recordings']['drifting'] = False
recordings_params['recordings']['drift_mode'] = 'slow'
recordings_params['recordings']['n_drifting'] = 50
recordings_params['recordings']['preferred_dir'] = [0, 0, 1]
recordings_params['recordings']['angle_tol'] = 15
recordings_params['recordings']['slow_drift_velocity'] = 10
recordings_params['recordings']['fast_drift_period'] = 10
recordings_params['recordings']['fast_drift_max_jump'] = 20
recordings_params['recordings']['fast_drift_min_jump'] = 5
recordings_params['recordings']['t_start_drift'] = 0

#seed
recordings_params['seeds']['spiketrains'] = None
recordings_params['seeds']['templates'] = None
recordings_params['seeds']['convolution'] = None
recordings_params['seeds']['noise'] = None





-monotrode_test_(noise_level):
recordings generated from tetrode_templates with the following parameters:

TEMPLATE - njobs = 10(x2)
#intracellular
template_params['sim_time'] = 2
template_params['target_spikes'] = [3, 50]
template_params['cut_out'] = [2, 5]
template_params['dt'] = 1/30
template_params['delay'] = 10
template_params['weights'] = [0.25, 1.75]

#extracellular
template_params['n'] = 2
template_params['probe'] = 'tetrode'
template_params['rot'] ='physrot'
template_params['ncontacts'] = 10
template_params['overhang'] = 30
template_params['offset'] = 0
template_params['xlim'] = None
template_params['ylim'] = None
template_params['zlim'] = None
template_params['det_thresh'] = 30
template_params['seed'] = None

#drift
template_params['drifting'] = True
template_params['max_drift'] = 100
template_params['min_drift'] = 20
template_params['drift_steps'] = 50
template_params['drift_xlim'] = [-10, 10]
template_params['drift_ylim'] = [-10, 10]
template_params['drift_zlim'] = [20, 80]


RECORDING
#spike trains
#recordings_params['rates'] = [3, 3, 5]
#recordings_params['types'] = ['E', 'E', 'I']
recordings_params['spiketrains']['n_exc'] = 2
recordings_params['spiketrains']['n_inh'] = 0
recordings_params['spiketrains']['f_exc'] = 5
recordings_params['spiketrains']['f_inh'] = 15
recordings_params['spiketrains']['st_exc'] = 1
recordings_params['spiketrains']['st_inh'] = 3
recordings_params['spiketrains']['min_rate'] = 0.5
recordings_params['spiketrains']['ref_per'] = 2
recordings_params['spiketrains']['process'] = 'poisson'
recordings_params['spiketrains']['gamma_shape'] = 2
recordings_params['spiketrains']['t_start'] = 0
recordings_params['spiketrains']['duration'] = 30

#cell types
recordings_params['cell_types']['excitatory'] = ['STPC', 'TTPC1', 'TTPC2', 'UTPC']
recordings_params['cell_types']['inhibitory'] = ['BP', 'BTC', 'ChC', 'DBC', 'LBC', 'MC', 'NBC', 'NGC', 'SBC']

#templates
recordings_params['templates']['min_dist'] = 25
recordings_params['templates']['min_amp'] = 50
recordings_params['templates']['max_amp'] = 500
recordings_params['templates']['xlim'] = None
recordings_params['templates']['ylim'] = None
recordings_params['templates']['zlim'] = None
recordings_params['templates']['n_jitters'] = 10
recordings_params['templates']['upsample'] = 8
recordings_params['templates']['pad_len'] = [3, 3]
recordings_params['templates']['overlap_threshold'] = 0.9
recordings_params['templates']['seed'] = None

#recording
recordings_params['recordings']['dtype'] = 'float32'
recordings_params['recordings']['fs'] = None
recordings_params['recordings']['sync_rate'] = 0
recordings_params['recordings']['sync_jitt'] = 1
recordings_params['recordings']['modulation'] = 'electrode'
recordings_params['recordings']['sdrand'] = 0.05
recordings_params['recordings']['chunk_duration'] = 20

recordings_params['recordings']['bursting'] = False
recordings_params['recordings']['exp_decay'] = 0.1
recordings_params['recordings']['n_burst_spikes'] = 10
recordings_params['recordings']['max_burst_duration'] = 100
recordings_params['recordings']['shape_mod'] = False
recordings_params['recordings']['shape_stretch'] = 30
recordings_params['recordings']['n_bursting'] = 3

recordings_params['recordings']['noise_level'] = noise_level
recordings_params['recordings']['noise_mode'] = 'uncorrelated'
recordings_params['recordings']['noise_color'] = True
recordings_params['recordings']['noise_half_distance'] = 100
recordings_params['recordings']['far_neurons_n'] = 300
recordings_params['recordings']['far_neurons_max_amp'] = 10
recordings_params['recordings']['far_neurons_noise_floor'] = 0.5
recordings_params['recordings']['far_neurons_exc_inh_ratio'] = 0.8
recordings_params['recordings']['color_peak'] = 500
recordings_params['recordings']['color_q'] = 1
recordings_params['recordings']['random_noise_floor'] = 1

recordings_params['recordings']['filter'] = False
recordings_params['recordings']['filter_cutoff'] = [300, 6000]
recordings_params['recordings']['filter_order'] = 3

recordings_params['recordings']['overlap'] = False
recordings_params['recordings']['extract_waveforms'] = True

recordings_params['recordings']['drifting'] = False
recordings_params['recordings']['drift_mode'] = 'slow'
recordings_params['recordings']['n_drifting'] = 50
recordings_params['recordings']['preferred_dir'] = [0, 0, 1]
recordings_params['recordings']['angle_tol'] = 15
recordings_params['recordings']['slow_drift_velocity'] = 10
recordings_params['recordings']['fast_drift_period'] = 10
recordings_params['recordings']['fast_drift_max_jump'] = 20
recordings_params['recordings']['fast_drift_min_jump'] = 5
recordings_params['recordings']['t_start_drift'] = 0

#seed
recordings_params['seeds']['spiketrains'] = None
recordings_params['seeds']['templates'] = None
recordings_params['seeds']['convolution'] = None
recordings_params['seeds']['noise'] = None
