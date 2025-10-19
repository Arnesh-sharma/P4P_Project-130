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

def getResults(prj2, vf1, vf2, vf3, vc1, vc2):
    
    # get the rsults and store in a vector
    q1 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\Vsense1').get_data()[0]
    q2 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\Vsense2').get_data()[0]
    q3 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\Vsense3').get_data()[0]
    q4 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Charges\Vsense4').get_data()[0]
    
    cg12 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C Vsense1, Vsense2').get_data()[0]
    cg21 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C Vsense2, Vsense1').get_data()[0]
    cg34 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C Vsense3, Vsense4').get_data()[0]
    cg43 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (grounded)\C Vsense4, Vsense3').get_data()[0]
    
    cl12 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C Vsense1, Vsense2').get_data()[0]
    cl21 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C Vsense2, Vsense1').get_data()[0]
    cl34 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C Vsense3, Vsense4').get_data()[0]
    cl43 = prj2.get_3d().get_result_item(r'1D Results\Es Solver\Capacitance Matrix (lumped)\C Vsense4, Vsense3').get_data()[0]

    d=pd.DataFrame({
        "vf1":vf1,
        "vf2":vf2,
        "vf3":vf3,
        "vc1":vc1, 
        "vc2":vc2, 
        "q1":q1, 
        "q2":q2,
        "q3":q3, 
        "q4":q4,
        "cg12":cg12,
        "cg21":cg21,
        "cg34":cg34,
        "cg43":cg43,
        "cl12":cl12,
        "cl21":cl21,
        "cl34":cl34,
        "cl43":cl43,
        },
        index=[0])
    return d


cst_file = r"C:\Users\npat025\OneDrive - The University of Auckland\mystuff\cst\esf\esf7_4.cst"

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
vf1 = 0
vf2 = 0 
vf3 = 0

prj.model3d.StoreParameter("vc1", vc1)
prj.model3d.StoreParameter("vc2", vc2)
prj.model3d.StoreParameter("VF1", vf1)
prj.model3d.StoreParameter("VF2", vf2)
prj.model3d.StoreParameter("VF3", vf3)

prj.model3d.Rebuild() # rebuild after all changes
prj.model3d.run_solver()

d = getResults(prj2, vf1, vf2, vf3, vc1, vc2)


# loop through various frame voltages (simulating a bee)
#vflist = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

vflist1 = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
vflist2 = [0]

# vflist1 = [0, 25, 50, 75, 100]
# vflist2 = [0, 25, 50, 75, 100]
#vflist = [0, 25]

for vf1 in vflist1:
    for vf2 in vflist2:
        print('vf1:', vf1, 'vf2:', vf2)
        # set Vframe
        prj.model3d.StoreParameter("VF1",vf1)
        prj.model3d.StoreParameter("VF2",vf2)
        prj.model3d.StoreParameter("VF3",vf3)

        # prj.model3d.Rebuild() # rebuild after all changes
        
    #   Run a simulation
        # prj.model3d.DeleteResults()    
        prj.model3d.run_solver()
    
        d1 =  getResults(prj2, vf1, vf2, vf3, vc1, vc2)
        d=pd.concat([d,d1],ignore_index=True) 


#prj.close()
#de.close()

for i in range(d.index.max()+1):
    print("\nvf1:%4.2f V, vf2:%4.2f V, vf3:%4.2f V,\nq1:%4.2f, q2:%4.2f, q12:%4.2f,\nq3:%4.2f q4:%4.2f, q34:%4.2f" \
          % (d.iloc[i].vf1, d.iloc[i].vf2, d.iloc[i].vf3, \
            d.iloc[i].q1*1e12, d.iloc[i].q2*1e12, (d.iloc[i].q1-d.iloc[i].q2)*1e12, \
            d.iloc[i].q3*1e12, d.iloc[i].q4*1e12, (d.iloc[i].q3-d.iloc[i].q4)*1e12 ))
          
          
for i in range(d.index.max()+1):
    print("\nvf1:%4.2f V, vf2:%4.2f V, vf3:%4.2f V, q1:%4.2f, q2:%4.2f, q12:%4.2f" \
          % (d.iloc[i].vf1, d.iloc[i].vf2, d.iloc[i].vf3, \
            d.iloc[i].q1*1e12, d.iloc[i].q2*1e12, (d.iloc[i].q1-d.iloc[i].q2)*1e12))
        
        
for i in range(d.index.max()+1):
    print("\nvf1:%4.2f V, vf2:%4.2f V, vf3:%4.2f V, q1:%4.2f, q2:%4.2f, q12:%4.2f" \
          % (d.iloc[i].vf1, d.iloc[i].vf2, d.iloc[i].vf3, \
            d.iloc[i].q3*1e12, d.iloc[i].q4*1e12, (d.iloc[i].q3-d.iloc[i].q4)*1e12))