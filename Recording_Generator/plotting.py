import MEArec as mr
import MEAutility as mu
import yaml
from pprint import pprint
import matplotlib.pylab as plt
#matplotlib notebook

template_path = 'data/neuronexus32_templates.h5'
recording_path = 'data/neuronexus32_recording_10.h5'

# load recordings
tempgen = mr.load_templates(template_path)

# load recordings
recgen = mr.load_recordings(recording_path)



#plot
#mr.plot_templates(recgen, single_axes=False, ncols=4)
#mr.plot_templates(recgen, single_axes=True, cmap='rainbow')
#mr.plot_templates(tempgen, template_ids=32, drifting=True, cmap='Reds')
#mr.plot_recordings(recgen)
mr.plot_recordings(recgen, start_time=0, end_time=5, overlay_templates=True)
#mr.plot_waveforms(recgen, electrode='max', cmap='rainbow')
#mr.plot_rasters(recgen.spiketrains)
#mr.plot_pca_map(recgen, cmap='coolwarm')

plt.show()