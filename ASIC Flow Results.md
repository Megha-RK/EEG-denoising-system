# ASIC Implementation Results

## Physical Design Flow

The EEG Denoising System was implemented using the OpenLane RTL-to-GDSII flow targeting the Sky130A Process Design Kit (PDK).

### Flow Stages Completed

| Stage                      | Status    |
| -------------------------- | --------- |
| RTL Design                 | Completed |
| Functional Simulation      | Completed |
| Logic Synthesis            | Completed |
| Floorplanning              | Completed |
| Placement                  | Completed |
| Clock Tree Synthesis (CTS) | Completed |
| Routing                    | Completed |
| Signoff Checks             | Completed |
| GDSII Generation           | Completed |

---

## Technology Information

* Technology Node: Sky130A
* RTL Language: Verilog HDL
* Physical Design Flow: OpenLane
* Layout Viewer: Magic / KLayout
* Top Module: `eeg_denoiser_top`

---

## Design Outputs

### Generated Artifacts

* Synthesized Netlist
* Floorplan DEF
* Placement DEF
* CTS DEF
* Routed DEF
* Final GDSII Layout

### Final Layout

The final GDSII layout was successfully generated using the OpenLane flow and verified using Magic and KLayout.

---

## Static Timing Analysis (STA)

The design successfully completed the physical design flow. Static Timing Analysis reported setup timing violations and fanout violations during signoff analysis.

### Signoff Status

* Hold Violations: None
* Setup Violations: Present
* Fanout Violations: Present
* GDSII Generation: Successful

---

## Project Outcome

The EEG Denoising System was successfully implemented from RTL to GDSII using the Sky130A open-source ASIC flow. The project demonstrates the complete ASIC implementation process, including synthesis, floorplanning, placement, clock tree synthesis, routing, signoff analysis, and final layout generation.

