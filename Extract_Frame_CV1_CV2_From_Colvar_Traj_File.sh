#!/bin/bash

cat > run1.inp <<ini
frame_cv1_cv2_wt_tm.dat
System_NPT_MetaD.colvars.metadynamics1.hills.traj
25000
ini

cat > run2.inp <<ini
frame_cv1_cv2_wt_myo.dat
System_NPT_MetaD.colvars.metadynamics2.hills.traj
25000
ini

f95 Extract_Frame_CV1_CV2_From_Colvar_Traj_File.F90
./a.out <run1.inp

f95 Extract_Frame_CV1_CV2_From_Colvar_Traj_File.F90
./a.out<run2.inp

rm -rf run1.inp run2.inp
cp *wt_tm.dat* *wt_myo.dat* ../../analysis/metadynamics/Most_probable_structure/WT
cp *wt_tm.dat* *wt_myo.dat* ../../analysis/metadynamics/cluster_analysis/WT
