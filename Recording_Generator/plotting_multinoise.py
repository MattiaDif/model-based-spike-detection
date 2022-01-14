import MEArec as mr
import MEAutility as mu
import yaml
from pprint import pprint
import matplotlib.pylab as plt
#matplotlib notebook


template_path = 'data/neuronexus32_templates.h5'
#recording_path = 'data/neuronexus32_example_20.h5' --> SEE the specific line for the data loading below


# load recordings
tempgen = mr.load_templates(template_path)

# load recordings
noise_levels = [10, 20, 30]

recgen_list = []

recgen = mr.load_recordings('data/neuronexus32_recording_10.h5')
recgen_list.append(recgen)
recgen = mr.load_recordings('data/neuronexus32_recording_20.h5')
recgen_list.append(recgen)
recgen = mr.load_recordings('data/neuronexus32_recording_30.h5')
recgen_list.append(recgen)


#multinoise recording plots
fig = plt.figure(1)
ax = [fig.add_subplot(311), fig.add_subplot(312), fig.add_subplot(313)]

colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
for i, recgen in enumerate(recgen_list[::-1]):
    mr.plot_recordings(recgen, ax=ax[i], end_time=60, colors=colors[i])

fig = plt.figure(2)
ax = [fig.add_subplot(311), fig.add_subplot(312), fig.add_subplot(313)]
#ax.set_title('Neuronexus32 recordings', fontsize=22)

colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
for i, recgen in enumerate(recgen_list[::-1]):
    mr.plot_recordings(recgen, ax=ax[i], start_time=0, end_time=5, overlay_templates=True)



#fig = plt.figure()

#mr.plot_templates(recgen, single_axes=True, cmap='rainbow')

plt.show()