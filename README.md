**GoAT — Goldmann Analysis Tool**
GoAT is a MATLAB toolset for quantifying changes in Goldmann kinetic visual field perimetry over time. It provides a simple GUI for aligning pre- and post-intervention visual field printouts to a common reference, generating isopter/scotoma/blind‑spot masks, and calculating gain and loss in visual field area — supporting per-eye, combined-eye, and hemifield-level analyses. It was developed by the Huxlin Lab for research on visual field recovery and rehabilitation (e.g., following cortical vision loss).

**Overview**
Align a scanned/photographed "pre" and "post" visual field chart to a standardized reference grid.
Extract binary masks for each isopter, scotoma, and the blind spot from both charts.
Overlay pre and post masks to identify pixels that were gained (improved) or lost (worsened).
Convert pixel counts to visual angle (degrees) and compiling results into a summary table.
Optionally combine data across eyes or collapsing results by visual hemifield.

Repository Structure
GoAT_2_1.m	          Main MATLAB GUI application. Handles image upload, rotation, and launches alignment/analysis steps.
GOATalign.m	          Aligns the uploaded pre- and post-field images to the reference chart.
GOAT2masks.m	        Generates binary masks for isopters, scotomas, and the blind spot from the aligned images.
GOAT2calculate.m	    Computes pre/post areas and gain/loss in pixels, converts to degrees of visual angle, and appends results to a running results table (ChangeTable.mat).
GOAT2combineEyes.m	  Combines masks/results from the left (OS) and right (OD) eyes into a single binocular field.
Goat2hemifield.m	    Splits and summarizes results by visual hemifield (e.g., superior/inferior or left/right).
README.md	            This file.

Note: the reference chart (reference.tif) referenced in the code are expected to sit alongside these scripts but may need to be sourced to match your specific Goldmann sheets.

**Requirements**
MATLAB (developed with a GUIDE-based GUI, last modified under MATLAB 2019)
Image Processing Toolbox (uses functions such as imread, imfuse, imrotate, rgb2gray/im2gray)

**Getting Started**
Clone the repository:
bash
   git clone https://github.com/huxlinlab/GoAT.git
Make sure GoAT_2_1.fig, GoATLogo.jpg, and reference.tif are present in the same folder as the scripts (the GUI loads these on startup).
Open MATLAB, add the folder to your path, and launch the tool:
matlab
   GoAT_2_1
   
**Typical Workflow**
Launch the GUI — GoAT_2_1 opens with the reference chart displayed in both panels.
Upload fields — Use the upload buttons to load the "pre" and "post" Goldmann field images for a subject/eye. Images can be rotated to correct orientation before proceeding.
Align — Click Align to register both images to the reference chart (GOATalign.m).
Analyze — Click Analyze to generate isopter/scotoma/blind-spot masks for both time points (GOAT2masks.m).
Calculate — Run GOAT2calculate.m (update the subject variable at the top of the script) to compute pixel-wise gain/loss for each isopter, scotoma, and blind spot, and to convert results to degrees of visual angle. Results are appended to ChangeTable.mat.
Combine / hemifield analysis (optional) — Use GOAT2combineEyes.m to merge OD/OS data into a binocular estimate, or Goat2hemifield.m to summarize gains/losses by hemifield.

**Output**
GOAT2calculate.m produces a results table (Changesave, saved in ChangeTable.mat) with per-subject columns including:

Pre/post isopter areas (OD/OS Deficit 1–3)
Gain/loss pixel counts per isopter
Blind spot pre/post/gain/loss
Scotoma pre/post/gain/loss

Pixel measures are converted to degrees of visual angle using a scale factor (default 9.45 px/deg — adjust this in GOAT2calculate.m to match your imaging setup/calibration).

**Notes**
The pixel-to-degree scale factor and the reference chart filename are hard-coded in the scripts and should be adjusted to match your lab's Goldmann perimeter scans and screen calibration.
This tool is intended for research use in quantifying visual field change and has not been validated as a clinical diagnostic device.

