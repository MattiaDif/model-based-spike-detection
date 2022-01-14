import MEArec as mr
import MEAutility as mu
import yaml
from pprint import pprint
import matplotlib.pylab as plt
#matplotlib notebook

save_flag = 1   #1 --> save recording, 0 --> not save

template_path = 'data/tetrode_templates.h5'


#load default configuration of MEArec
default_info, mearec_home = mr.get_default_config()
pprint(default_info)



#template generation and saving
#define cell model folder
cell_folder = default_info['cell_models_folder']
template_params = mr.get_default_templates_params()
pprint(template_params)



#setting parameters
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



pprint(template_params)
#the templates are not saved, but the intracellular simulations are saved in 'templates_folder'



#the tempgen variable is a TemplateGenerator object -->  It contains the templates, 
#locations, rotations, and celltypes of the generated templates
tempgen = mr.gen_templates(cell_models_folder=cell_folder, params=template_params, n_jobs=10)
print('Templates shape', tempgen.templates.shape)
print('Sample locations', tempgen.locations[:])
print('Sample rotations', tempgen.rotations[:])
print('Sample cell types', tempgen.celltypes[:])



#template saving
if save_flag == 1:
    mr.save_template_generator(tempgen, filename=template_path)
