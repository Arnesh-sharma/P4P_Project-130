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
This folder contains the code and project files for another PSoC-based capacitive sensing technique using the relaxation oscillator. 

### `LT_SPICE`
This folder consists of LT Spice files used to simulate some of the sensors, such as the relaxation oscillator, for this project. 

### `Matlab_Diode`
This folder contains the files to plot the readings received from Putty for the diode + Capacitive sensor configuration. 

### `Old_Sensor/analogReadSerial`
The code to read from the BeeSpy Sensors.

### `PCBs`
This folder contains the PCB projects for the sensors used for this project. It included: 
- Crystal oscillator circuit
- Electrostatic induction sensor circuit
- Instrumentation Amplifier PCB
- A PCB with multiple circuits that connect to the capacitive sensor

### `Photos`
This folder includes the photos of the test rig and the Faraday cage. 

### `Raw_Data`
This folder holds the data obtained from the observation hive testing. 

### `Testing Data`
This folder contains the files of the data collected from laboratory testing, with a few images on how the tests were set up. 

### `cst`
This folder contains CST Studio files used to simulate and test the capacitive sensors. 

### `laser_cutting_files`
This folder contains the laser-cut files for the acrylic test rig. 

### `old_sesnors`
Another folder that is used for reading the data readings of the old BeeSpy sensors. 

### `photos of sensors`
This folder consists of the photos of the sensors developed throughout this project. 

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

