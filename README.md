[![View model-based-spike-detection on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/105670-model-based-spike-detection)

# Model-based online implementation of spike detection algorithms for neuroengineering applications

Spike detection algorithms development in Simulink® to evaluate the preferable contestant for the intended embedded (µC or Field Programmable Gate Array - FPGA) implementation. A Model-Based Design approach for neuroengineering applications enables to (i) simulate, and forecast pros and cons of the code execution on target hardware, and (ii) carry out preliminary analysis about the algorithms conduct in real-time.

With this repo you can test and compare different spike detection models implemented in Simulink to simulate real-time signal processing, or to evaluate the performance of different spike detection algorithms on your own signals. Test recordings are available so that you can try the repo functionalities. 

<br />

<img src="https://github.com/MattiaDif/model-based-spike-detection/blob/main/img/models.png?raw=true" width="800">

<p>
    <b>Fig.1 - Spike detection models developed in both single- and multi-channel modality</b></figcaption>
</p>

<br />
<br />

<img src="https://github.com/MattiaDif/model-based-spike-detection/blob/main/img/SNEO.png?raw=true" width="800">

<p>
    <b>Fig.2 - SNEO Simulink model</b></figcaption>
</p>

<br />

## Required Software

1. MATLAB® and Simulink® version R2020a or later


## Installation

To clone this repo open your terminal and run:

`git clone https://github.com/MattiaDif/model-based-spike-detection.git`

Rember to add the repo to the Matlab path!

## Repo description

Inside Spike_Detection_Models:

1. SingleChannelModels: folder that contains the Simulink model for spike detection in single-channel modality subdivided by category. The files named with the prefix float_sch are the spike detection Simulink models, while the files named with the prefix float_sch_run are the Matlab scripts to control the model parameters and lunch the simulation.

2. MultiChannelModels: folder that contains the Simulink model for spike detection in mutli-channel modality subdivided by category. The files named with the prefix float_mch are the spike detection Simulink models, while the files named with the prefix float_mch_run are the Matlab scripts to control the model parameters and lunch the simulation.

3. TestData: folder that contains data for testing the model in Simulink (see the reame.txt file in the folder for further details).

4. Recording_Generator: folder that contains Python scripts to generate simulated multichannel recording exploting MEArec ([MEArec repo](https://github.com/alejoe91/MEArec.git)).


## Background

Different spike detection models has been developed in Simulink to investigate their feasibility in a real-time environment. The algorithms are subdivided among 3 main categories according to the spike detection methods found in literature:
1. Sample Thresholding: a spike is detected if the sample overcomes a threshold.
2. Energy Operator: non-linear energy operator (NEO) computation to enhance the high frequency content. A spike is detected if the NEO sample overcomes a threshold.
3. Template Matching: spike detection based on the similarity between a waveform and a template. A spike is detected if the similarity metric is greater than a set value.


## CORE TEAM
The following people have contributed to the current state of the project. Specifically:
- Development: [Stefano Buccelli](https://www.iit.it/it/people-details/-/people/stefano-buccelli) [1], [Mattia Di Florio](https://rubrica.unige.it/personale/UUZFUllo) [1],[3].
- Conceptualization/Supervision: [Vijay Iyer](https://www.mathworks.com/matlabcentral/profile/authors/6910229) [2], [Akshay Rajhans](https://www.mathworks.com/matlabcentral/profile/authors/4409783) [2], [Stefano Buccelli](https://www.iit.it/it/people-details/-/people/stefano-buccelli) [1], [Michela Chiappalone](https://rubrica.unige.it/personale/UkNHWlNg) [1],[3].

For any questions, please reach via email Mattia Di Florio (di.florio.mattia@gmail.com) or Stefano Buccelli (stefano.buccelli@iit.it) or write an issue!

1. Rehab Technologies IIT-INAIL Lab, Istituto Italiano di Tecnologia, Via Morego 30, 12 16163 Genova, Italy
2. MathWorks, 1 Lakeside Campus Drive, Natick, MA 01760, USA
3. Department of Informatics, Bioengineering, Robotics, System Engineering (DIBRIS), 20 University of Genova, Via all’Opera Pia 13, 16145, Genova, Italy


## REFERENCE
For further information please refer to the scientific publication: [link](https://doi.org/10.1109/EMBC48229.2022.9871444)

If you use this repo, please cite:

"Di Florio, M., Iyer, V., Rajhans, A., Buccelli, S., & Chiappalone, M. (2022, July). Model-based online implementation of spike detection algorithms for neuroengineering applications. In 2022 44th Annual International Conference of the IEEE Engineering in Medicine & Biology Society (EMBC) (pp. 736-739). IEEE."

