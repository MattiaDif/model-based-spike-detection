import MEArec as mr
import MEAutility as mu
import yaml
from pprint import pprint
import matplotlib.pylab as plt
import numpy as np
#matplotlib notebook

save_flag = 0   #1 --> save recording, 0 --> not save

template_path = 'data/neuronexus32_templates.h5'
recording_path = 'data/neuronexus32_templates_{}.h5'


#generate and saving recordings
recordings_params = mr.get_default_recordings_params()
pprint(recordings_params)



#setting parameters
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
recordings_params['spiketrains']['duration'] = 10

#cell types
recordings_params['cell_types']['excitatory'] = ['STPC', 'TTPC1', 'TTPC2', 'UTPC']
recordings_params['cell_types']['inhibitory'] = ['BP', 'BTC', 'ChC', 'DBC', 'LBC', 'MC', 'NBC', 'NGC', 'SBC']

#templates
recordings_params['templates']['min_dist'] = 25
recordings_params['templates']['min_amp'] = 100
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

recordings_params['recordings']['noise_level'] = 10
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
recordings_params['recordings']['n_drifting'] = 5
recordings_params['recordings']['preferred_dir'] = [0, 0, 1]
recordings_params['recordings']['angle_tol'] = 15
recordings_params['recordings']['slow_drift_velocity'] = 5
recordings_params['recordings']['fast_drift_period'] = 10
recordings_params['recordings']['fast_drift_max_jump'] = 20
recordings_params['recordings']['fast_drift_min_jump'] = 5
recordings_params['recordings']['t_start_drift'] = 0

#seed
recordings_params['seeds']['spiketrains'] = None
recordings_params['seeds']['templates'] = None
recordings_params['seeds']['convolution'] = None
recordings_params['seeds']['noise'] = None



pprint(recordings_params)


#generate and check multinoise recordings 
noise_levels = [10, 20, 30]

recgen_list = []

for n in noise_levels:
    print('Noise level: ', n)
    recordings_params['recordings']['noise_level'] = n
    recordings_params['recordings']['seed'] = np.random.randint(1000)
    recgen = mr.gen_recordings(templates=template_path, params=recordings_params, verbose=False)
    recgen_list.append(recgen)



print('Recordings shape', recgen.recordings.shape)
print('Selected templates shape', recgen.recordings.shape)
print('Sample template locations', recgen.template_locations[:3])
print('Number of neurons', len(recgen.spiketrains))
print('Sample spike train', recgen.spiketrains[0].times)



#multinoise recording plots
fig = plt.figure(1)
ax = [fig.add_subplot(311), fig.add_subplot(312), fig.add_subplot(313)]

colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
for i, recgen in enumerate(recgen_list[::-1]):
    mr.plot_recordings(recgen, ax=ax[i], start_time=0, end_time=10)

#fig = plt.figure(2)
#ax = [fig.add_subplot(311), fig.add_subplot(312), fig.add_subplot(313)]

#for i, recgen in enumerate(recgen_list[::-1]):
    #mr.plot_templates(recgen, ax=ax[i], single_axes=False, ncols=4)

#fig = plt.figure(3)
#ax = [fig.add_subplot(311), fig.add_subplot(312), fig.add_subplot(313)]

#for i, recgen in enumerate(recgen_list[::-1]):
    #mr.plot_templates(recgen, ax=ax[i], single_axes=True, cmap='rainbow')



#plotting the templates and the recordings
#mr.plot_templates(recgen, single_axes=False, ncols=4)
#plt.savefig('template.png')
#mr.plot_templates(recgen, single_axes=True, cmap='rainbow')
#mr.plot_recordings(recgen)
#mr.plot_recordings(recgen, start_time=0, end_time=10, overlay_templates=True)
#plt.savefig('recording_1st_s.png')
#mr.plot_waveforms(recgen, electrode='max', cmap='rainbow')
#plt.savefig('waveforms.png')
#mr.plot_rasters(recgen.spiketrains)
#plt.savefig('raster.png')
#mr.plot_pca_map(recgen, cmap='coolwarm')

plt.show()


#save the generated recording
if save_flag == 1:
    for i, recgen in enumerate(recgen_list):
        mr.save_recording_generator(recgen=recgen, filename=recording_path.format(noise_levels[i]))