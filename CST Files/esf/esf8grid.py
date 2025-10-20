# -*- coding: utf-8 -*-
"""
Created on Sun Jul 20 12:55:56 2025
Test run 
@author: npat025
"""

import sys
sys.path.append(r"C:\Program Files (x86)\CST Studio Suite 2024\AMD64\python_cst_libraries")

import numpy as np
import pandas as pd

import cst.interface
from cst.interface import DesignEnvironment
import  cst.results

def settingsMesh():
    variable_history_list = f"""    
    With Mesh 
     .MeshType "Tetrahedral" 
     .SetCreator "Low Frequency"
    End With 
    With MeshSettings 
     .SetMeshType "Tet" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "4" 
     .Set "StepsPerWaveFar", "4" 
     .Set "PhaseErrorNear", "0.02" 
     .Set "PhaseErrorFar", "0.02" 
     .Set "CellsPerWavelengthPolicy", "automatic" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "50" 
     .Set "StepsPerBoxFar", "10" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     'MIN CELL 
     .Set "UseRatioLimit", "0" 
     .Set "RatioLimit", "100" 
     .Set "MinStep", "0" 
     'MESHING METHOD 
     .SetMeshType "Unstr" 
     .Set "Method", "0" 
    End With 
    With MeshSettings 
     .SetMeshType "Tet" 
     .Set "CurvatureOrder", "1" 
     .Set "CurvatureOrderPolicy", "automatic" 
     .Set "CurvRefinementControl", "NormalTolerance" 
     .Set "NormalTolerance", "22.5" 
     .Set "SrfMeshGradation", "1.5" 
     .Set "SrfMeshOptimization", "1" 
    End With 
    With MeshSettings 
     .SetMeshType "Unstr" 
     .Set "UseMaterials",  "0" 
     .Set "MoveMesh", "0" 
    End With 
    With MeshSettings 
     .SetMeshType "All" 
     .Set "AutomaticEdgeRefinement",  "0" 
    End With 
    With MeshSettings 
     .SetMeshType "Tet" 
     .Set "UseAnisoCurveRefinement", "1" 
     .Set "UseSameSrfAndVolMeshGradation", "1" 
     .Set "VolMeshGradation", "1.5" 
     .Set "VolMeshOptimization", "1" 
    End With 
    With MeshSettings 
     .SetMeshType "Unstr" 
     .Set "SmallFeatureSize", "0" 
     .Set "CoincidenceTolerance", "1e-06" 
     .Set "SelfIntersectionCheck", "1" 
     .Set "OptimizeForPlanarStructures", "0" 
    End With 
    With Mesh 
     .SetParallelMesherMode "Tet", "maximum" 
     .SetMaxParallelMesherThreads "Tet", "1" 
     .Update
    End With
    """
    return variable_history_list

def getResults(prj2, vf, vc1, vc2):
    
    # get the rsults and store in a vector
    q11_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s11_1').get_data()[0]
    q11_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s11_1').get_data()[0]
    q12_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s11_2').get_data()[0]
    q12_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s12_1').get_data()[0]
    q13_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s12_2').get_data()[0]
    q13_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s13_1').get_data()[0]
    q14_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s13_2').get_data()[0]
    q14_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s14_1').get_data()[0]
    q21_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s14_2').get_data()[0]
    q21_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s21_1').get_data()[0]
    q22_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s21_2').get_data()[0]
    q22_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s22_1').get_data()[0]
    q23_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s22_2').get_data()[0]
    q23_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s23_1').get_data()[0]
    q24_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s23_2').get_data()[0]
    q24_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s24_1').get_data()[0]
    q31_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s24_2').get_data()[0]
    q31_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s31_1').get_data()[0]
    q32_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s31_2').get_data()[0]
    q32_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s32_1').get_data()[0]
    q33_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s32_2').get_data()[0]
    q33_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s33_1').get_data()[0]
    q34_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s33_2').get_data()[0]
    q34_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s34_1').get_data()[0]
    q41_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s34_2').get_data()[0]
    q41_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s41_1').get_data()[0]
    q42_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s41_2').get_data()[0]
    q42_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s42_1').get_data()[0]
    q43_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s42_2').get_data()[0]
    q43_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s43_1').get_data()[0]
    q44_1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s43_2').get_data()[0]
    q44_2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\s44_1').get_data()[0]
    
    d=pd.DataFrame({
        "vf1":vf,
        # "vf2":vf2,
        # "vf3":vf3,
        "vc1":vc1, 
        "vc2":vc2, 
        "q11_1":q11_1,
        "q11_2":q11_2,
        "q12_1":q12_1,
        "q12_2":q12_2,
        "q13_1":q13_1,
        "q13_2":q13_2,
        "q14_1":q14_1,
        "q14_2":q14_2,
        "q21_1":q21_1,
        "q21_2":q21_2,
        "q22_1":q22_1,
        "q22_2":q22_2,
        "q23_1":q23_1,
        "q23_2":q23_2,
        "q24_1":q24_1,
        "q24_2":q24_2,
        "q31_1":q31_1,
        "q31_2":q31_2,
        "q32_1":q32_1,
        "q32_2":q32_2,
        "q33_1":q33_1,
        "q33_2":q33_2,
        "q34_1":q34_1,
        "q34_2":q34_2,
        "q41_1":q41_1,
        "q41_2":q41_2,
        "q42_1":q42_1,
        "q42_2":q42_2,
        "q43_1":q43_1,
        "q43_2":q43_2,
        "q44_1":q44_1,
        "q44_2":q44_2,
        },
        index=[0])
    return d

def getCapacitances(prj2):
    cg11 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s11_1, s11_2').get_data()[0]
    cg12 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s12_1, s12_2').get_data()[0]
    cg13 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s13_1, s13_2').get_data()[0]
    cg14 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s14_1, s14_2').get_data()[0]
    cg21 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s21_1, s21_2').get_data()[0]
    cg22 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s22_1, s22_2').get_data()[0]
    cg23 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s23_1, s23_2').get_data()[0]
    cg24 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s24_1, s24_2').get_data()[0]
    cg31 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s31_1, s31_2').get_data()[0]
    cg32 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s32_1, s32_2').get_data()[0]
    cg33 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s33_1, s33_2').get_data()[0]
    cg34 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s34_1, s34_2').get_data()[0]
    cg41 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s41_1, s41_2').get_data()[0]
    cg42 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s42_1, s42_2').get_data()[0]
    cg43 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s43_1, s43_2').get_data()[0]
    cg44 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C s44_1, s44_2').get_data()[0]
    cl11 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s11_1, s11_2').get_data()[0]
    cl12 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s12_1, s12_2').get_data()[0]
    cl13 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s13_1, s13_2').get_data()[0]
    cl14 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s14_1, s14_2').get_data()[0]
    cl21 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s21_1, s21_2').get_data()[0]
    cl22 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s22_1, s22_2').get_data()[0]
    cl23 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s23_1, s23_2').get_data()[0]
    cl24 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s24_1, s24_2').get_data()[0]
    cl31 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s31_1, s31_2').get_data()[0]
    cl32 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s32_1, s32_2').get_data()[0]
    cl33 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s33_1, s33_2').get_data()[0]
    cl34 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s34_1, s34_2').get_data()[0]
    cl41 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s41_1, s41_2').get_data()[0]
    cl42 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s42_1, s42_2').get_data()[0]
    cl43 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s43_1, s43_2').get_data()[0]
    cl44 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C s44_1, s44_2').get_data()[0]

    caps=pd.DataFrame({
        "cg11":cg11,
        "cl11":cl11,
        "cg12":cg12,
        "cl12":cl12,
        "cg13":cg13,
        "cl13":cl13,
        "cg14":cg14,
        "cl14":cl14,
        "cg21":cg21,
        "cl21":cl21,
        "cg22":cg22,
        "cl22":cl22,
        "cg23":cg23,
        "cl23":cl23,
        "cg24":cg24,
        "cl24":cl24,
        "cg31":cg31,
        "cl31":cl31,
        "cg32":cg32,
        "cl32":cl32,
        "cg33":cg33,
        "cl33":cl33,
        "cg34":cg34,
        "cl34":cl34,
        "cg41":cg41,
        "cl41":cl41,
        "cg42":cg42,
        "cl42":cl42,
        "cg43":cg43,
        "cl43":cl43,
        "cg44":cg44,
        "cl44":cl44,
        },
        index=[0])
    return caps

def setesolver(capmode):
    if capmode == 1:
        variable_history_list = f"""  
        With EStaticSolver
         .Method "Tetrahedral Mesh"
         .Accuracy "1e-6"
         .CalcCapacitanceMatrix "True"
         .StoreResultsInCache "False"
         .MeshAdaption "False"
         .TetAdaption "False"
         .UseMaxNumberOfThreads "True"
         .MaxNumberOfThreads "2048"
         .MaximumNumberOfCPUDevices "4"
         .UseDistributedComputing "False"
         End With
        UseDistributedComputingForParameters "False"
        MaxNumberOfDistributedComputingParameters "2"
        UseDistributedComputingMemorySetting "False"
        MinDistributedComputingMemoryLimit "0"
        UseDistributedComputingSharedDirectory "False"
        OnlyConsider0D1DResultsForDC "False"
        """
    else:
        variable_history_list = f"""  
        With EStaticSolver
         .Method "Tetrahedral Mesh"
         .Accuracy "1e-6"
         .CalcCapacitanceMatrix "False"
         .StoreResultsInCache "False"
         .MeshAdaption "False"
         .TetAdaption "False"
         .UseMaxNumberOfThreads "True"
         .MaxNumberOfThreads "2048"
         .MaximumNumberOfCPUDevices "4"
         .UseDistributedComputing "False"
         End With
        UseDistributedComputingForParameters "False"
        MaxNumberOfDistributedComputingParameters "2"
        UseDistributedComputingMemorySetting "False"
        MinDistributedComputingMemoryLimit "0"
        UseDistributedComputingSharedDirectory "False"
        OnlyConsider0D1DResultsForDC "False"
        """    
    return variable_history_list


cst_file = r"C:\Users\npat025\OneDrive - The University of Auckland\mystuff\cst\esf\esf8grid.cst"

# de = DesignEnvironment.new()
de = DesignEnvironment.connect_to_any_or_new()
prj = de.open_project(cst_file)
prj.model3d.DeleteResults() 

# create the mesh
str = settingsMesh()
prj.model3d.add_to_history(f"Set and Create Mesh", str) # update the mesh

prj2 = cst.results.ProjectFile(cst_file,allow_interactive=True)

vc1 = 1
vc2 = -1
vf = 0
# vf2 = 0 
# vf3 = 0

prj.model3d.StoreParameter("vc1", vc1)
prj.model3d.StoreParameter("vc2", vc2)
prj.model3d.StoreParameter("vf", vf)
# prj.model3d.StoreParameter("VF2", vf2)
#prj.model3d.StoreParameter("VF3", vf3)

str = setesolver(1)  # with capacitance
prj.model3d.add_to_history(f"Set esolver cap mode ON", str)


prj.model3d.Rebuild() # rebuild after all changes
prj.model3d.run_solver()



# d = getResults(prj2, vf1, vf2, vf3, vc1, vc2)
d = getResults(prj2, vf, vc1, vc2)
# caps = getCapacitances(prj2)

# str = setesolver(0) # no capacitance
# prj.model3d.add_to_history(f"Set esolver cap mode OFF", str)


# loop through various frame voltages (simulating a bee)
vflist1 = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
#vflist1 = [10, 50, 100]
# vflist1 = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
# vflist1 = [100]

# vflist1 = [0, 25, 50, 75, 100]
# vflist2 = [0, 25, 50, 75, 100]
#vflist = [0, 25]

for vf in vflist1:
    # for vf2 in vflist2:
        # print('vf1:', vf1, 'vf2:', vf2)
        print('vf:', vf)
        # set Vframe
        prj.model3d.StoreParameter("vf",vf)
        # prj.model3d.StoreParameter("VF2",vf2)
        # prj.model3d.StoreParameter("VF3",vf3)

        # prj.model3d.Rebuild() # rebuild after all changes
        
    #   Run a simulation
        # prj.model3d.DeleteResults()    
        prj.model3d.run_solver()
    
        # d1 =  getResults(prj2, vf1, vf2, vf3, vc1, vc2)
        d1 =  getResults(prj2, vf, vc1, vc2)
        d=pd.concat([d, d1],ignore_index=True) 


#prj.close()
#de.close()

# for i in range(d.index.max()+1):
#     print("\nvf1:%4.2f V, vf2:%4.2f V,\nq1:%4.2f, q2:%4.2f, q12:%4.2f,\nq3:%4.2f q4:%4.2f, q34:%4.2f" \
#           % (d.iloc[i].vf1, d.iloc[i].vf2, \
#             d.iloc[i].q1*1e12, d.iloc[i].q2*1e12, (d.iloc[i].q1-d.iloc[i].q2)*1e12, \
#             d.iloc[i].q3*1e12, d.iloc[i].q4*1e12, (d.iloc[i].q3-d.iloc[i].q4)*1e12 ))
          
# print('Sensor 1')          
# for i in range(d.index.max()+1):
#     print("\nvf1:%4.2f V, vf2:%4.2f V, q1:%4.2f, q2:%4.2f, q12:%4.2f" \
#           % (d.iloc[i].vf1, d.iloc[i].vf2, \
#             d.iloc[i].q1*1e12, d.iloc[i].q2*1e12, (d.iloc[i].q1-d.iloc[i].q2)*1e12))
        
# print('Sensor 2')        
# for i in range(d.index.max()+1):
#     print("\nvf1:%4.2f V, vf2:%4.2f V, q3:%4.2f, q4:%4.2f, q34:%4.2f" \
#           % (d.iloc[i].vf1, d.iloc[i].vf2, \
#             d.iloc[i].q3*1e12, d.iloc[i].q4*1e12, (d.iloc[i].q3-d.iloc[i].q4)*1e12))
        
# print('Capacitances grounded ')        
# for i in range(d.index.max()+1):
#     print("\nvf1:%4.2f V, vf2:%4.2f V, cg12:%4.2f, cg21:%4.2f, cg34:%4.2f, cg43:%4.2f, " \
#           % (d.iloc[i].vf1, d.iloc[i].vf2, \
#             d.iloc[i].cg12*1e12, d.iloc[i].cg21*1e12, d.iloc[i].cg34*1e12, d.iloc[i].cg43*1e12))
        
# print('Capacitances lumped ')        
# for i in range(d.index.max()+1):
#     print("\nvf1:%4.2f V, vf2:%4.2f V, cl12:%4.2f, cl21:%4.2f, cl34:%4.2f, cl43:%4.2f, " \
#           % (d.iloc[i].vf1, d.iloc[i].vf2, \
#             d.iloc[i].cl12*1e12, d.iloc[i].cl21*1e12, d.iloc[i].cl34*1e12, d.iloc[i].cl43*1e12))        