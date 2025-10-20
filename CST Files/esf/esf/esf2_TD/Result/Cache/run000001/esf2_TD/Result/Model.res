MWS Result File Version 20150206
size=i:23

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:E-Field (Js) (Contour Plot).rd0

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:E-Field (50) (Arrows Plot).rd0

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

type=s:XYSIGNAL
subtype=s:user
problemclass=s::17:1001
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:Excitation Signals\default
files=s:signal_default_lf.sig

type=s:XYSIGNAL
subtype=s:user
problemclass=s::17:1001
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:Excitation Signals\signal1
files=s:signal_signal1_lf.sig

type=s:XYSIGNAL
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
DCMerge=i:1
treepath=s:1D Results\Time Steps
files=s:MQSTDtstep.sig

type=s:XYSIGNAL
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\LT Solver\Convergence\Solver (TD)\Rel. Residual
files=s:MQSTDnlplotdata.sig

type=s:XYSIGNAL
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\LT Solver\Convergence\Solver (TD)\Linear Steps
files=s:MQSTDnlplotdatasteps.sig

type=s:XYSIGNAL
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
DCMerge=i:1
treepath=s:1D Results\LT Solver\Energy\background
files=s:MQSTDenergy_background.sig

type=s:XYSIGNAL
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
DCMerge=i:1
treepath=s:1D Results\LT Solver\Energy\Total
files=s:MQSTDenergy_Total.sig

type=s:XYSIGNAL
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
DCMerge=i:1
treepath=s:1D Results\LT Solver\Losses\Total
files=s:MQSTDlosses_Total.sig

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Solver Time
files=s:LTSolver_Statistics_SolverTime.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Total Time
files=s:LTSolver_Statistics_TotalTime.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Meshing Time
files=s:LTSolver_Statistics_MeshingTime.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Assemble Time
files=s:LTSolver_Statistics_AssembleTime.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Post Processing Time
files=s:LTSolver_Statistics_PostProcessingTime.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Number of DoFs
files=s:LTSolver_Statistics_NumberofDoFs.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Number of Elements
files=s:LTSolver_Statistics_NumberofElements.0d

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Peak Memory usage
files=s:LTSolver_Statistics_PeakMemoryusage.0d

type=s:TABLE
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
treepath=s:Tables\0D Results\E-Field (50) (Arrows Plot)
files=s:E-Field (50) (Arrows Plot).rt0
files=s:E-Field (50) (Arrows Plot).rd0

type=s:TABLE
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
treepath=s:Tables\0D Results\E-Field (Js) (Contour Plot)
files=s:E-Field (Js) (Contour Plot).rt0
files=s:E-Field (Js) (Contour Plot).rd0

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\AutomaticRunInformation
files=s:AutomaticRunInformation

