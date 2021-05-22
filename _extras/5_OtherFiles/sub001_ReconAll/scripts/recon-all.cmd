\n\n#---------------------------------
# New invocation of recon-all Fri May 21 16:39:14 EDT 2021 
\n mri_convert /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/data/sub001/struct.nii.gz /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/orig/001.mgz \n
#--------------------------------------------
#@# MotionCor Fri May 21 16:39:19 EDT 2021
\n cp /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/orig/001.mgz /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/rawavg.mgz \n
\n mri_convert /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/rawavg.mgz /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/orig.mgz --conform \n
\n mri_add_xform_to_header -c /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/transforms/talairach.xfm /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/orig.mgz /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/orig.mgz \n
#--------------------------------------------
#@# Talairach Fri May 21 16:39:26 EDT 2021
\n mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 \n
\n talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm \n
talairach_avi log file is transforms/talairach_avi.log...
\n cp transforms/talairach.auto.xfm transforms/talairach.xfm \n
#--------------------------------------------
#@# Talairach Failure Detection Fri May 21 16:40:34 EDT 2021
\n talairach_afd -T 0.005 -xfm transforms/talairach.xfm \n
\n awk -f /Applications/freesurfer//bin/extract_talairach_avi_QA.awk /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/transforms/talairach_avi.log \n
\n tal_QC_AZS /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/transforms/talairach_avi.log \n
#--------------------------------------------
#@# Nu Intensity Correction Fri May 21 16:40:35 EDT 2021
\n mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 \n
\n mri_add_xform_to_header -c /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/transforms/talairach.xfm nu.mgz nu.mgz \n
#--------------------------------------------
#@# Intensity Normalization Fri May 21 16:41:57 EDT 2021
\n mri_normalize -g 1 -mprage nu.mgz T1.mgz \n
#--------------------------------------------
#@# Skull Stripping Fri May 21 16:44:02 EDT 2021
\n mri_em_register -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mri_em_register.skull.dat -skull nu.mgz /Applications/freesurfer//average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta \n
\n mri_watershed -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mri_watershed.dat -T1 -brain_atlas /Applications/freesurfer//average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta T1.mgz brainmask.auto.mgz \n
\n cp brainmask.auto.mgz brainmask.mgz \n
#-------------------------------------
#@# EM Registration Fri May 21 16:52:35 EDT 2021
\n mri_em_register -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /Applications/freesurfer//average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta \n
#--------------------------------------
#@# CA Normalize Fri May 21 16:58:05 EDT 2021
\n mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /Applications/freesurfer//average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz \n
#--------------------------------------
#@# CA Reg Fri May 21 16:59:14 EDT 2021
\n mri_ca_register -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /Applications/freesurfer//average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z \n
#--------------------------------------
#@# SubCort Seg Fri May 21 18:16:19 EDT 2021
\n mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /Applications/freesurfer//average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz \n
\n mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/mri/transforms/cc_up.lta sub001 \n
#--------------------------------------
#@# Merge ASeg Fri May 21 18:46:46 EDT 2021
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Fri May 21 18:46:46 EDT 2021
\n mri_normalize -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Fri May 21 18:49:59 EDT 2021
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Fri May 21 18:50:00 EDT 2021
\n mri_segment -mprage brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Fri May 21 18:51:33 EDT 2021
\n mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.auto_noCCseg.mgz wm.mgz filled.mgz \n
#--------------------------------------------
#@# Tessellate lh Fri May 21 18:51:59 EDT 2021
\n mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz \n
\n mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix \n
\n rm -f ../mri/filled-pretess255.mgz \n
\n mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix \n
#--------------------------------------------
#@# Tessellate rh Fri May 21 18:52:03 EDT 2021
\n mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz \n
\n mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix \n
\n rm -f ../mri/filled-pretess127.mgz \n
\n mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix \n
#--------------------------------------------
#@# Smooth1 lh Fri May 21 18:52:06 EDT 2021
\n mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix \n
#--------------------------------------------
#@# Smooth1 rh Fri May 21 18:52:12 EDT 2021
\n mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix \n
#--------------------------------------------
#@# Inflation1 lh Fri May 21 18:52:19 EDT 2021
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
#--------------------------------------------
#@# Inflation1 rh Fri May 21 18:52:35 EDT 2021
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
#--------------------------------------------
#@# QSphere lh Fri May 21 18:52:50 EDT 2021
\n mris_sphere -q -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix \n
#--------------------------------------------
#@# QSphere rh Fri May 21 18:54:17 EDT 2021
\n mris_sphere -q -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix \n
#--------------------------------------------
#@# Fix Topology Copy lh Fri May 21 18:55:43 EDT 2021
\n cp ../surf/lh.orig.nofix ../surf/lh.orig \n
\n cp ../surf/lh.inflated.nofix ../surf/lh.inflated \n
#--------------------------------------------
#@# Fix Topology Copy rh Fri May 21 18:55:43 EDT 2021
\n cp ../surf/rh.orig.nofix ../surf/rh.orig \n
\n cp ../surf/rh.inflated.nofix ../surf/rh.inflated \n
#@# Fix Topology lh Fri May 21 18:55:43 EDT 2021
\n mris_fix_topology -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_fix_topology.lh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub001 lh \n
#@# Fix Topology rh Fri May 21 19:10:36 EDT 2021
\n mris_fix_topology -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_fix_topology.rh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub001 rh \n
\n mris_euler_number ../surf/lh.orig \n
\n mris_euler_number ../surf/rh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n rm ../surf/lh.inflated \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm ../surf/rh.inflated \n
#--------------------------------------------
#@# Make White Surf lh Fri May 21 19:21:25 EDT 2021
\n mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub001 lh \n
#--------------------------------------------
#@# Make White Surf rh Fri May 21 19:25:25 EDT 2021
\n mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub001 rh \n
#--------------------------------------------
#@# Smooth2 lh Fri May 21 19:29:19 EDT 2021
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Smooth2 rh Fri May 21 19:29:25 EDT 2021
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Fri May 21 19:29:31 EDT 2021
\n mris_inflate -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_inflate.lh.dat ../surf/lh.smoothwm ../surf/lh.inflated \n
#--------------------------------------------
#@# Inflation2 rh Fri May 21 19:29:46 EDT 2021
\n mris_inflate -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_inflate.rh.dat ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Fri May 21 19:30:01 EDT 2021
\n mris_curvature -w lh.white.preaparc \n
\n mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K rh Fri May 21 19:30:58 EDT 2021
\n mris_curvature -w rh.white.preaparc \n
\n mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
\n#-----------------------------------------
#@# Curvature Stats lh Fri May 21 19:31:53 EDT 2021
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub001 lh curv sulc \n
\n#-----------------------------------------
#@# Curvature Stats rh Fri May 21 19:31:58 EDT 2021
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm sub001 rh curv sulc \n
#--------------------------------------------
#@# Sphere lh Fri May 21 19:32:03 EDT 2021
\n mris_sphere -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_sphere.lh.dat -seed 1234 ../surf/lh.inflated ../surf/lh.sphere \n
#--------------------------------------------
#@# Sphere rh Fri May 21 19:50:14 EDT 2021
\n mris_sphere -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_sphere.rh.dat -seed 1234 ../surf/rh.inflated ../surf/rh.sphere \n
#--------------------------------------------
#@# Surf Reg lh Fri May 21 20:08:20 EDT 2021
\n mris_register -curv -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_register.lh.dat ../surf/lh.sphere /Applications/freesurfer//average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg \n
#--------------------------------------------
#@# Surf Reg rh Fri May 21 20:30:11 EDT 2021
\n mris_register -curv -rusage /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/sub001/touch/rusage.mris_register.rh.dat ../surf/rh.sphere /Applications/freesurfer//average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg \n
#--------------------------------------------
#@# Jacobian white lh Fri May 21 20:51:44 EDT 2021
\n mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white \n
#--------------------------------------------
#@# Jacobian white rh Fri May 21 20:51:46 EDT 2021
\n mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white \n
#--------------------------------------------
#@# AvgCurv lh Fri May 21 20:51:47 EDT 2021
\n mrisp_paint -a 5 /Applications/freesurfer//average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv \n
#--------------------------------------------
#@# AvgCurv rh Fri May 21 20:51:48 EDT 2021
\n mrisp_paint -a 5 /Applications/freesurfer//average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv \n
#-----------------------------------------
#@# Cortical Parc lh Fri May 21 20:51:49 EDT 2021
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub001 lh ../surf/lh.sphere.reg /Applications/freesurfer//average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot \n
#-----------------------------------------
#@# Cortical Parc rh Fri May 21 20:52:00 EDT 2021
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub001 rh ../surf/rh.sphere.reg /Applications/freesurfer//average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot \n
#--------------------------------------------
#@# Make Pial Surf lh Fri May 21 20:52:10 EDT 2021
\n mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub001 lh \n
#--------------------------------------------
#@# Make Pial Surf rh Fri May 21 21:02:08 EDT 2021
\n mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub001 rh \n
#--------------------------------------------
#@# Surf Volume lh Fri May 21 21:11:49 EDT 2021
#--------------------------------------------
#@# Surf Volume rh Fri May 21 21:11:52 EDT 2021
#--------------------------------------------
#@# Cortical ribbon mask Fri May 21 21:11:54 EDT 2021
\n mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon sub001 \n
#-----------------------------------------
#@# Parcellation Stats lh Fri May 21 21:18:59 EDT 2021
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub001 lh white \n
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub001 lh pial \n
#-----------------------------------------
#@# Parcellation Stats rh Fri May 21 21:19:44 EDT 2021
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub001 rh white \n
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub001 rh pial \n
#-----------------------------------------
#@# Cortical Parc 2 lh Fri May 21 21:20:29 EDT 2021
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub001 lh ../surf/lh.sphere.reg /Applications/freesurfer//average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Cortical Parc 2 rh Fri May 21 21:20:43 EDT 2021
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub001 rh ../surf/rh.sphere.reg /Applications/freesurfer//average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Parcellation Stats 2 lh Fri May 21 21:20:56 EDT 2021
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub001 lh white \n
#-----------------------------------------
#@# Parcellation Stats 2 rh Fri May 21 21:21:19 EDT 2021
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub001 rh white \n
#-----------------------------------------
#@# Cortical Parc 3 lh Fri May 21 21:21:42 EDT 2021
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub001 lh ../surf/lh.sphere.reg /Applications/freesurfer//average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# Cortical Parc 3 rh Fri May 21 21:21:53 EDT 2021
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub001 rh ../surf/rh.sphere.reg /Applications/freesurfer//average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# Parcellation Stats 3 lh Fri May 21 21:22:03 EDT 2021
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub001 lh white \n
#-----------------------------------------
#@# Parcellation Stats 3 rh Fri May 21 21:22:26 EDT 2021
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub001 rh white \n
#-----------------------------------------
#@# WM/GM Contrast lh Fri May 21 21:22:48 EDT 2021
\n pctsurfcon --s sub001 --lh-only \n
#-----------------------------------------
#@# WM/GM Contrast rh Fri May 21 21:22:53 EDT 2021
\n pctsurfcon --s sub001 --rh-only \n
#-----------------------------------------
#@# Relabel Hypointensities Fri May 21 21:22:58 EDT 2021
\n mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz \n
#-----------------------------------------
#@# AParc-to-ASeg aparc Fri May 21 21:23:13 EDT 2021
\n mri_aparc2aseg --s sub001 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /Applications/freesurfer//average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt \n
#-----------------------------------------
#@# AParc-to-ASeg a2009s Fri May 21 21:25:41 EDT 2021
\n mri_aparc2aseg --s sub001 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /Applications/freesurfer//average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --a2009s \n
#-----------------------------------------
#@# AParc-to-ASeg DKTatlas Fri May 21 21:28:07 EDT 2021
\n mri_aparc2aseg --s sub001 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /Applications/freesurfer//average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --annot aparc.DKTatlas --o mri/aparc.DKTatlas+aseg.mgz \n
#-----------------------------------------
#@# APas-to-ASeg Fri May 21 21:30:44 EDT 2021
\n apas2aseg --i aparc+aseg.mgz --o aseg.mgz \n
#--------------------------------------------
#@# ASeg Stats Fri May 21 21:30:49 EDT 2021
\n mri_segstats --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /Applications/freesurfer//ASegStatsLUT.txt --subject sub001 \n
#-----------------------------------------
#@# WMParc Fri May 21 21:33:37 EDT 2021
\n mri_aparc2aseg --s sub001 --labelwm --hypo-as-wm --rip-unknown --volmask --o mri/wmparc.mgz --ctxseg aparc+aseg.mgz \n
\n mri_segstats --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject sub001 --surf-wm-vol --ctab /Applications/freesurfer//WMParcStatsLUT.txt --etiv \n
INFO: fsaverage subject does not exist in SUBJECTS_DIR
INFO: Creating symlink to fsaverage subject...
\n cd /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer; ln -s /Applications/freesurfer//subjects/fsaverage; cd - \n
#--------------------------------------------
#@# BA_exvivo Labels lh Fri May 21 21:40:22 EDT 2021
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA1_exvivo.label --trgsubject sub001 --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA2_exvivo.label --trgsubject sub001 --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA3a_exvivo.label --trgsubject sub001 --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA3b_exvivo.label --trgsubject sub001 --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA4a_exvivo.label --trgsubject sub001 --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA4p_exvivo.label --trgsubject sub001 --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA6_exvivo.label --trgsubject sub001 --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA44_exvivo.label --trgsubject sub001 --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA45_exvivo.label --trgsubject sub001 --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.V1_exvivo.label --trgsubject sub001 --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.V2_exvivo.label --trgsubject sub001 --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.MT_exvivo.label --trgsubject sub001 --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject sub001 --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject sub001 --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject sub001 --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mris_label2annot --s sub001 --hemi lh --ctab /Applications/freesurfer//average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.entorhinal_exvivo.label --l lh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s sub001 --hemi lh --ctab /Applications/freesurfer//average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab sub001 lh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub001 lh white \n
#--------------------------------------------
#@# BA_exvivo Labels rh Fri May 21 21:43:01 EDT 2021
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA1_exvivo.label --trgsubject sub001 --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA2_exvivo.label --trgsubject sub001 --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA3a_exvivo.label --trgsubject sub001 --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA3b_exvivo.label --trgsubject sub001 --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA4a_exvivo.label --trgsubject sub001 --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA4p_exvivo.label --trgsubject sub001 --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA6_exvivo.label --trgsubject sub001 --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA44_exvivo.label --trgsubject sub001 --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA45_exvivo.label --trgsubject sub001 --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.V1_exvivo.label --trgsubject sub001 --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.V2_exvivo.label --trgsubject sub001 --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.MT_exvivo.label --trgsubject sub001 --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject sub001 --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject sub001 --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/swapna/DataCarpentry_sMRI/nipype_tutorial/freesurfer/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject sub001 --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mris_label2annot --s sub001 --hemi rh --ctab /Applications/freesurfer//average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.entorhinal_exvivo.label --l rh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s sub001 --hemi rh --ctab /Applications/freesurfer//average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab sub001 rh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub001 rh white \n
