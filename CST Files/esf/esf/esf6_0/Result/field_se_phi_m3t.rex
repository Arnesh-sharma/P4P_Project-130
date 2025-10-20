<?xml version="1.0" encoding="UTF-8"?>
<MetaResultFile version="20211011" creator="Solver_SE_TET">
  <MetaGeometryFile filename="model.gex" lod="1"/>
  <SimulationProperties fieldname="Potential" frequency="0" encoded_unit="&amp;U:V^1" fieldtype="Electric Potential" fieldscaling="UNDEFINED" dB_Amplitude="0"/>
  <ResultDataType vector="0" complex="0" timedomain="0" frequencymap="0"/>
  <SimulationDomain min="0 0 0" max="0 0 0"/>
  <PlotSettings Plot="4" ignore_symmetry="0" deformation="0" enforce_culling="0" integer_values="0" combine="CombineNone" default_arrow_type="ARROWS" default_scaling="NONE"/>
  <Source type="SOLVER"/>
  <SpecialMaterials>
    <Background type="NORMAL"/>
    <Material name="PEC" type="UNMESHED_SURFACEVALUE"/>
  </SpecialMaterials>
  <AuxGeometryFile/>
  <AuxResultFile/>
  <FieldFreeNodes/>
  <SurfaceFieldCoefficients/>
  <UnitCell/>
  <SubVolume/>
  <Units/>
  <ProjectUnits/>
  <TimeSampling/>
  <LocalAxes/>
  <MeshViewSettings/>
  <ResultGroups num_steps="1" transformation="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1" process_mesh_group="0">
    <SharedDataWith/>
    <Frame index="0" characteristic="0">
      <PortModeInfoFile/>
      <FieldResultFile filename="field_se_phi.m3t" type="m3t"/>
    </Frame>
  </ResultGroups>
  <AutoScale>
    <SmartScaling log_strength="1" log_anchor="0" log_anchor_type="0" db_range="40" phase="0"/>
  </AutoScale>
</MetaResultFile>
