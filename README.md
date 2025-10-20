# Project 130: Motion Detection of Bees Using Electrostatic Sensors
#### Researchers: Jayti Pattni & Arnesh Sharma
---

## Project Details

This project involved designing and implementing a novel electrostatic sensor to detect the motion of bees within a hive. This Compendium holds all the 
relevant files, schematics, data, and code used in the prototyping and testing of the various sensors.

---

## Folder Structure

### `Capsense_stuff/Cap_Sense.cydsn`
This folder holds the code and the project files for using the Capacitive Sensing module in the PSoC 5.  

### `CoreXY`
This folder contains code and CAD files for the custom CoreXY used for the demo and calibration for this project. 

### `Experimental_cap_sense`
This folder contains the code and project files for another PSoC-based capacitive sensing technique using the relaxation oscillator. It also includes the LT_Spice folder, this folder consists of LT Spice files used to simulate some of the sensors, such as the relaxation oscillator, for this project. 

### `Notes_&_Deliverables`
Contains notes from meetings and experimental ideas

### `Matlab Code`
This folder contains the files to plot the readings received from Putty, scope data, and psoc plotters for the diode, Capacitive sensor configuration, FFT analysis.

This also inclu demonstration matlab code for the capacitive sensor with instrumentation amplifier that shows a heat map of intensity and gives a live fft.

### `BeeSpy Arduino Code`
This folder contains arduino code to read from the BeeSpy Sensors.

### `PCBs`
This folder contains the PCB projects for the sensors used for this project. It included: 
- Crystal oscillator circuit
- Electrostatic induction sensor circuit
- Instrumentation Amplifier PCB
- A PCB with multiple circuits that connect to the capacitive sensor

### `Photos`
This folder includes the photos of the test rig and the Faraday cage. Also contains are folder 'photos of sensors' which consists of the photos of the sensors developed throughout this project. 

### `Testing Data`
This folder contains the files of the data collected from laboratory testing, with a few images on how the tests were set up. 

### `CST Files`
This folder contains CST Studio files used to simulate and test the capacitive sensors. 

### `laser_cutting_files`
This folder contains the laser-cut files for the acrylic test rig. 

---

## Future Work

This compendium can be used to build on the research done throughout this project. Some further work should be done on the sensing of the motion of bees.
Including: 
- Working on revisions of the capacitive sensors, such as size and shape/geometry
- Working on improving the existing sensors that were developed during this project
- Implementing more PCBs to accommodate the finer capacitive sensor matrix
- Research into ITO-based sensors
- Also development of Hemispherical sensors
---

