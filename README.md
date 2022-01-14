# Model-based online implementation of spike detection algorithms for neuroengineering applications

This work aimed at designing and implementing in Simulink environment different kind of spike detection algorithms to evaluate the best candidate for the next FPGA implementation of a closed-loop system. Moreover, by exploiting a model-based design approach it is possible to simulate, analyze and forecast pros and cons of the code execution on hardware and to conduct preliminary observations about how the algorithms behave in real-time.

<br />

<p>
    <img src="https://github.com/MattiaDif/model-based-spike-detection/blob/main/img/SNEO.png" width=100% height=100%>
    <figcaption  align = "center"> <b>Fig.1 - SNEO Simulink model</b></figcaption>
</p>

<br />

## Installation

To clone this repo open your terminal and run:

`git clone https://github.com/MattiaDif/model-based-spike-detection.git`

Rember to add the repo to the Matlab path!

## Repo description

Inside Spike_Detection_Models:

1. SingleChannelModels: folder that contains the Simulink model for spike detection in single-channel modality subdivided by category. The files named with the prefix float_sch are the spike detection Simulink models, while the files named with the prefix float_sch_run are the Matlab scripts to control the model parameters and lunch the simulation.

2. MultiChannelModels: folder that contains the Simulink model for spike detection in mutli-channel modality subdivided by category. The files named with the prefix float_mch are the spike detection Simulink models, while the files named with the prefix float_mch_run are the Matlab scripts to control the model parameters and lunch the simulation.

2. TestData: folder that contains data for testing the model in Simulink (see the reame.txt file in the folder for further details).

Recording_Generator: folder that contains Python scripts to generate simulated multichannel recording exploting MEArec ([MEArec repo](https://github.com/alejoe91/MEArec.git)).

## Background

Different spike detection models has been developed in Simulink to investigate their feasibility in a real-time environment. The algorithms are subdivided among 3 main categories according to the spike detection methods found in literature:
1. Sample Thresholding: a spike is detected if the sample overcomes a threshold.
2. Energy Operator: non-linear energy operator (NEO) computation to enhance the high frequency content. A spike is detected if the NEO sample overcomes a threshold.
3. Template Matching: spike detection based on the similarity between a waveform and a template. A spike is detected if the similarity metric is greater than a set value.
