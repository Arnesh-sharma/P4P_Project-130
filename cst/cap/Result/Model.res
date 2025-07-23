MWS Result File Version 20150206
size=i:29

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:field_se_eldens_m3t.tfo

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
files=s:field_se_d_m3t.tfo

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
files=s:field_se_e_m3t.tfo

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
files=s:field_se_phi_m3t.tfo

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

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:persistent
result=s:0
files=s:MCalcAccess.log

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

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Convergence\Solver\Residual
files=s:Residual.sig
xlabel=s:Iteration Step
ylabel=s:log10(Relative Residual)
title=s:Convergence

type=s:POTENTIAL_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\Potential [Es]
files=s:field_se_phi.m3t
files=s:field_se_phi_m3t.rex
ylabel=s:Potential

type=s:EFIELD3D_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\E-Field [Es]
files=s:field_se_e.m3t
files=s:field_se_e_m3t.rex
ylabel=s:E-Field

type=s:DFIELD3D_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\D-Field [Es]
files=s:field_se_d.m3t
files=s:field_se_d_m3t.rex
ylabel=s:D-Field

type=s:EENERGY3D_TET
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:2D/3D Results\El. Energy Dens. [Es]
files=s:field_se_eldens.m3t
files=s:field_se_eldens_m3t.rex
ylabel=s:Electric Energy Density

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Energy\background
files=s:EsSolver_Energy_background.0d
ylabel=s:J

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Energy\Total
files=s:EsSolver_Energy_Total.0d
ylabel=s:J

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
treepath=s:1D Results\Es Solver\Charges\Open boundaries
files=s:EsSolver_Charges_Openboundaries.0d
ylabel=s:C

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\charge1
files=s:EsSolver_Charges_charge1.0d
ylabel=s:C

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\charge2
files=s:EsSolver_Charges_charge2.0d
ylabel=s:C

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\potential3
files=s:EsSolver_Charges_potential3.0d
ylabel=s:C

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Es Solver\Charges\potential4
files=s:EsSolver_Charges_potential4.0d
ylabel=s:C

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
ylabel=s:V/m

