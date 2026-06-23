# RTL-to-GDSII Design of an EEG Denoising System

## Abstract

Electroencephalography (EEG) signals are widely used for monitoring brain activity in medical diagnosis, brain-computer interfaces, and neurological research. However, EEG signals are highly susceptible to various sources of noise such as baseline drift, power-line interference, muscle artifacts, and environmental disturbances. This project presents the RTL-to-GDSII implementation of an EEG denoising system that performs signal preprocessing and noise classification using a hardware-efficient architecture. The design employs a Bandpass Filter, Notch Filter, Energy Calculator, Threshold Detector, and Noise Classifier to identify clean and noisy EEG segments. The complete design flow was implemented from Register Transfer Level (RTL) design through physical implementation and GDSII generation.

---

# 1. Introduction

EEG is a non-invasive technique used to record the electrical activity of the brain through electrodes placed on the scalp. EEG signals are typically low-amplitude signals and are vulnerable to noise contamination. Reliable EEG analysis requires preprocessing techniques to reduce unwanted noise components.

Hardware-based EEG preprocessing systems are attractive for real-time biomedical applications due to their low latency, high throughput, and low power consumption. This project focuses on implementing an EEG denoising system suitable for ASIC realization using the RTL-to-GDSII design methodology.

---

# 2. Problem Statement

Raw EEG signals often contain:

* Baseline drift
* High-frequency noise
* Power-line interference (50/60 Hz)
* Motion artifacts
* Electromagnetic interference

These unwanted components can affect signal quality and reduce the accuracy of subsequent EEG analysis. Therefore, an efficient hardware solution is required to improve signal quality and identify noisy EEG segments.

---

# 3. Objective

The primary objectives of this project are:

* Design a hardware-efficient EEG denoising architecture.
* Remove unwanted frequency components using filtering techniques.
* Detect noisy EEG segments using energy-based threshold classification.
* Separate clean and noisy EEG outputs.
* Implement the complete design using Verilog HDL.
* Perform RTL-to-GDSII ASIC implementation.

---

# 4. System Architecture

The proposed EEG denoising system consists of the following stages:

Raw EEG Signal
→ Bandpass Filter
→ Notch Filter
→ Energy Calculator
→ Threshold Detector
→ Noise Classifier
→ Clean Signal Output / Noise Signal Output

The filtering stages reduce unwanted noise components, while the classification stages determine whether the processed EEG segment should be considered clean or noisy.

---

# 5. Module Description

## 5.1 Bandpass Filter

### Purpose

The Bandpass Filter allows EEG frequencies of interest to pass while attenuating unwanted low-frequency and high-frequency components.

### Functions

* Removes baseline drift.
* Suppresses high-frequency noise.
* Preserves useful EEG frequency components.

### Benefits

* Improves signal quality.
* Reduces unnecessary processing of unwanted frequencies.

---

## 5.2 Notch Filter

### Purpose

The Notch Filter is used to remove narrowband power-line interference.

### Functions

* Eliminates 50 Hz interference commonly present in power systems.
* Prevents contamination of EEG signal measurements.

### Benefits

* Improves signal reliability.
* Enhances preprocessing accuracy.

---

## 5.3 Energy Calculator

### Purpose

The Energy Calculator extracts a simple yet effective feature from the filtered EEG signal.

### Energy Equation

E = Σ x²(n)

where:

* E = Signal energy
* x(n) = EEG sample

### Functions

* Measures signal strength over a predefined observation window.
* Generates a feature used for classification.

### Benefits

* Hardware-friendly implementation.
* Low computational complexity.

---

## 5.4 Threshold Detector

### Purpose

The Threshold Detector compares the calculated energy against a predefined threshold value.

### Decision Rule

If:

Energy > Threshold

then:

Signal is classified as noisy.

Otherwise:

Signal is classified as clean.

### Benefits

* Simple implementation.
* Fast decision making.
* Suitable for real-time operation.

---

## 5.5 Noise Classifier

### Purpose

The Noise Classifier routes the filtered EEG signal based on the threshold decision.

### Outputs

#### Clean Output

Contains EEG segments classified as clean.

#### Noise Output

Contains EEG segments classified as noisy.

### Benefits

* Enables signal quality monitoring.
* Facilitates further processing of valid EEG segments.

---

# 6. RTL Design Methodology

The system was implemented using Verilog HDL following a modular design approach.

Each functional block was developed as an independent module:

* Bandpass Filter Module
* Notch Filter Module
* Energy Calculator Module
* Threshold Detector Module
* Noise Classifier Module
* Top-Level Integration Module

The modular architecture improves scalability, readability, and maintainability.

---

# 7. RTL-to-GDSII Implementation Flow

The design was implemented using a standard ASIC design flow.

## 7.1 RTL Design

Behavioral description of the system using Verilog HDL.

## 7.2 Logic Synthesis

RTL was synthesized into gate-level netlists using standard cell libraries.

## 7.3 Floorplanning

Chip dimensions and core utilization were determined.

## 7.4 Placement

Standard cells were positioned within the floorplan.

## 7.5 Clock Tree Synthesis (CTS)

Clock distribution networks were generated to minimize clock skew.

## 7.6 Routing

Physical interconnections between cells were created.

## 7.7 Physical Verification

Design Rule Checks (DRC) and Layout Versus Schematic (LVS) verification were performed.

## 7.8 GDSII Generation

Final layout data was exported in GDSII format for fabrication readiness.

---

# 8. Results

The implemented architecture successfully:

* Removed unwanted frequency components using filtering stages.
* Eliminated power-line interference.
* Calculated signal energy.
* Classified EEG segments as clean or noisy.
* Generated separate clean and noise outputs.

The design demonstrates the feasibility of implementing biomedical signal preprocessing using a hardware-oriented RTL-to-GDSII design flow.

---

# 9. Applications

* Brain-Computer Interfaces (BCI)
* Neuro-monitoring Systems
* Biomedical Signal Processing
* Wearable Healthcare Devices
* Low-Power Medical ASICs

---

# 10. Future Enhancements

Future improvements may include:

* Adaptive filtering techniques.
* Wavelet-based denoising.
* Machine-learning-based classification.
* Multi-channel EEG processing.
* Low-power optimization techniques.
* Real-time FPGA prototyping.

---

# 11. Conclusion

This project presents the RTL-to-GDSII implementation of an EEG denoising system using filtering and energy-based classification techniques. The Bandpass and Notch filters improve EEG signal quality by reducing unwanted frequency components and power-line interference. The Energy Calculator, Threshold Detector, and Noise Classifier enable identification of clean and noisy EEG segments. The complete ASIC design flow demonstrates the practical implementation of biomedical signal-processing hardware from RTL design to final GDSII generation.

