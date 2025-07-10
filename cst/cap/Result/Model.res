MWS Result File Version 20150206
size=i:19

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

type=s:XYSIGNAL2
subtype=s:user
problemclass=s:Low Frequency TD Solver:17:1001
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:Excitation Signals\default
files=s:signal_default_lf.sig
xlabel=s:Time / s
title=s:Excitation: default

type=s:XYSIGNAL2
subtype=s:user
problemclass=s:Low Frequency TD Solver:17:1001
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:1D Results\Signals\default (potential,potential1)
files=s:signal_default (potential,potential1)_lf_res.sig
xlabel=s:Time / s
title=s:Excitation: default (potential,potential1)

type=s:XYSIGNAL2
subtype=s:user
problemclass=s:Low Frequency TD Solver:17:1001
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:1D Results\Signals\default (potential,potential2)
files=s:signal_default (potential,potential2)_lf_res.sig
xlabel=s:Time / s
title=s:Excitation: default (potential,potential2)

type=s:XYSIGNAL2
subtype=s:user
problemclass=s:Low Frequency TD Solver:17:1001
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:1D Results\Signals\default (potential,potential3)
files=s:signal_default (potential,potential3)_lf_res.sig
xlabel=s:Time / s
title=s:Excitation: default (potential,potential3)

type=s:XYSIGNAL2
subtype=s:user
problemclass=s:Low Frequency TD Solver:17:1001
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:1D Results\Signals\default (potential,potential4)
files=s:signal_default (potential,potential4)_lf_res.sig
xlabel=s:Time / s
title=s:Excitation: default (potential,potential4)

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\AutomaticRunInformation
files=s:AutomaticRunInformation

type=s:XYSIGNAL2
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\Time Steps
files=s:MQSTDtstep.sig

type=s:XYSIGNAL2
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\Convergence\Solver (TD)\Rel. Residual
files=s:MQSTDnlplotdata.sig

type=s:XYSIGNAL2
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\Convergence\Solver (TD)\Linear Steps
files=s:MQSTDnlplotdatasteps.sig

type=s:XYSIGNAL2
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\LT Solver\Energy\background
files=s:MQSTDenergy_background.sig

type=s:XYSIGNAL2
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\LT Solver\Energy\Total
files=s:MQSTDenergy_Total.sig

type=s:XYSIGNAL2
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\LT Solver\Losses\Total
files=s:MQSTDlosses_Total.sig

type=s:XYSIGNAL2
subtype=s:time
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:1
treepath=s:1D Results\LT Solver\Potential\potential (5.5 10.5 0)
files=s:MQSTD0d_pot-field_potential (5.5 10.5 0).sig

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\LT Solver\Statistics\Solver Time
files=s:LTSolver_Statistics_SolverTime.0d
ylabel=s:s

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
treepath=s:1D Results\LT Solver\Statistics\Peak Memory usage
files=s:LTSolver_Statistics_PeakMemoryusage.0d
ylabel=s:MiB

