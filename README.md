# RTL-to-GDSII Design of an EEG Denoising System

## Overview

This project implements an EEG denoising system in Verilog and demonstrates the complete RTL-to-GDSII ASIC design flow. The system uses Bandpass and Notch filtering to reduce unwanted noise components from EEG signals, followed by Energy-Based Threshold Classification to identify clean and noisy signal segments.

## Features

* Bandpass Filtering
* Notch Filtering
* Energy Calculation
* Threshold-Based Noise Detection
* Clean and Noise Signal Classification
* ASIC Physical Design Flow

## System Architecture
<img width="1536" height="1024" alt="ChatGPT Image Jun 23, 2026, 10_29_41 PM" src="https://github.com/user-attachments/assets/0d47b3f9-206b-4e66-b428-84bae32130f5" />


Raw EEG Signal
→ Bandpass Filter
→ Notch Filter
→ Energy Calculation
→ Threshold Detector
→ Noise Classifier
→ Clean Signal Output / Noise Signal Output

## ASIC Design Flow

* RTL Design in Verilog
* Logic Synthesis
* Floorplanning
* Placement
* Clock Tree Synthesis (CTS)
* Routing
* Physical Verification
* GDSII Generation

## Tools Used

* Icarus Verilog
* OpenLane
* OpenROAD
* Sky130 PDK
* GTKWave

## Applications

* Brain-Computer Interfaces (BCI)
* Biomedical Signal Processing
* Neuro-monitoring Systems
* Low-Power Healthcare ASICs

## Author

Megha R

