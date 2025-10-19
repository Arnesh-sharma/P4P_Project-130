MWS Result File Version 20150206
size=i:75

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:surviveparchange
result=s:1
files=s:simulation_overview.json

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:field_se_eldens_m3t.rex

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:field_se_d_m3t.rex

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:field_se_e_m3t.rex

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:field_se_phi_m3t.rex

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:estatic.svd

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:estatic.slv

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:0
files=s:Model.hmi

type=s:FOLDER
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\AutomaticRunInformation
files=s:AutomaticRunInformation

type=s:XYSIGNAL
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Convergence\Solver\Residual
files=s:Residual.sig

type=s:POTENTIAL_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\Potential [Es]
files=s:field_se_phi.m3t
files=s:field_se_phi_m3t.rex

type=s:EFIELD3D_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\E-Field [Es]
files=s:field_se_e.m3t
files=s:field_se_e_m3t.rex

type=s:DFIELD3D_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\D-Field [Es]
files=s:field_se_d.m3t
files=s:field_se_d_m3t.rex

type=s:EENERGY3D_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\El. Energy Dens. [Es]
files=s:field_se_eldens.m3t
files=s:field_se_eldens_m3t.rex

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Energy\background
files=s:EsSolver_Energy_background.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Energy\Total
files=s:EsSolver_Energy_Total.0d

type=s:SOLVERTEXTFILE
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:Electric Field Energy
files=s:Electric Field Energy.stx

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\potential1
files=s:EsSolver_Charges_potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\potential2
files=s:EsSolver_Charges_potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\potential3
files=s:EsSolver_Charges_potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\potential4
files=s:EsSolver_Charges_potential4.0d

type=s:SOLVERTEXTFILE
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:Charge Values
files=s:Charge Values.stx

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Field Values\E-Field [Es]\Max Value
files=s:FieldValues_E-Field[Es]_MaxValue.0d

type=s:SOLVERTEXTFILE
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:Capacitance Matrix (grounded)
files=s:Capacitance Matrix (grounded).stx

type=s:SOLVERTEXTFILE
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:Capacitance Matrix (lumped)
files=s:Capacitance Matrix (lumped).stx

type=s:XYSIGNAL
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\_Result\C_Matrix
files=s:C_Matrix

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential1, potential1
files=s:EsSolver_CapacitanceMatrix_Cpotential1,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential1, potential2
files=s:EsSolver_CapacitanceMatrix_Cpotential1,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential1, potential3
files=s:EsSolver_CapacitanceMatrix_Cpotential1,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential1, potential4
files=s:EsSolver_CapacitanceMatrix_Cpotential1,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential2, potential1
files=s:EsSolver_CapacitanceMatrix_Cpotential2,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential2, potential2
files=s:EsSolver_CapacitanceMatrix_Cpotential2,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential2, potential3
files=s:EsSolver_CapacitanceMatrix_Cpotential2,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential2, potential4
files=s:EsSolver_CapacitanceMatrix_Cpotential2,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential3, potential1
files=s:EsSolver_CapacitanceMatrix_Cpotential3,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential3, potential2
files=s:EsSolver_CapacitanceMatrix_Cpotential3,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential3, potential3
files=s:EsSolver_CapacitanceMatrix_Cpotential3,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential3, potential4
files=s:EsSolver_CapacitanceMatrix_Cpotential3,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential4, potential1
files=s:EsSolver_CapacitanceMatrix_Cpotential4,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential4, potential2
files=s:EsSolver_CapacitanceMatrix_Cpotential4,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential4, potential3
files=s:EsSolver_CapacitanceMatrix_Cpotential4,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix\C potential4, potential4
files=s:EsSolver_CapacitanceMatrix_Cpotential4,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential1, potential1
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential1,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential1, potential2
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential1,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential1, potential3
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential1,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential1, potential4
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential1,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential2, potential1
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential2,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential2, potential2
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential2,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential2, potential3
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential2,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential2, potential4
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential2,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential3, potential1
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential3,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential3, potential2
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential3,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential3, potential3
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential3,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential3, potential4
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential3,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential4, potential1
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential4,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential4, potential2
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential4,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential4, potential3
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential4,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (grounded)\C potential4, potential4
files=s:EsSolver_CapacitanceMatrix(grounded)_Cpotential4,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential1, potential1
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential1,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential1, potential2
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential1,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential1, potential3
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential1,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential1, potential4
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential1,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential2, potential1
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential2,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential2, potential2
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential2,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential2, potential3
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential2,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential2, potential4
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential2,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential3, potential1
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential3,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential3, potential2
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential3,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential3, potential3
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential3,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential3, potential4
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential3,potential4.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential4, potential1
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential4,potential1.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential4, potential2
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential4,potential2.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential4, potential3
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential4,potential3.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Capacitance Matrix (lumped)\C potential4, potential4
files=s:EsSolver_CapacitanceMatrix(lumped)_Cpotential4,potential4.0d

