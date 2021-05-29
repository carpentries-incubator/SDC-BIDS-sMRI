

#---------------------------------
# New invocation of recon-all Fri May 28 08:30:02 UTC 2021 

 mri_convert /scratch/smriprep_wf/single_subject_031624_wf/anat_preproc_wf/anat_validate/sub-031624_T1w_valid.nii.gz /out/freesurfer/sub-031624/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Fri May 28 08:30:08 UTC 2021

 cp /out/freesurfer/sub-031624/mri/orig/001.mgz /out/freesurfer/sub-031624/mri/rawavg.mgz 


 mri_convert /out/freesurfer/sub-031624/mri/rawavg.mgz /out/freesurfer/sub-031624/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /out/freesurfer/sub-031624/mri/transforms/talairach.xfm /out/freesurfer/sub-031624/mri/orig.mgz /out/freesurfer/sub-031624/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Fri May 28 08:30:18 UTC 2021

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Fri May 28 08:32:00 UTC 2021

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /opt/freesurfer/bin/extract_talairach_avi_QA.awk /out/freesurfer/sub-031624/mri/transforms/talairach_avi.log 


 tal_QC_AZS /out/freesurfer/sub-031624/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Fri May 28 08:32:00 UTC 2021

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 


 mri_add_xform_to_header -c /out/freesurfer/sub-031624/mri/transforms/talairach.xfm nu.mgz nu.mgz 

#--------------------------------------------
#@# Intensity Normalization Fri May 28 08:34:09 UTC 2021

 mri_normalize -g 1 -mprage nu.mgz T1.mgz 



#---------------------------------
# New invocation of recon-all Fri May 28 08:46:27 UTC 2021 
#-------------------------------------
#@# EM Registration Fri May 28 08:46:28 UTC 2021

 mri_em_register -rusage /out/freesurfer/sub-031624/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta 

#--------------------------------------
#@# CA Normalize Fri May 28 08:50:08 UTC 2021

 mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz 

#--------------------------------------
#@# CA Reg Fri May 28 08:51:31 UTC 2021

 mri_ca_register -rusage /out/freesurfer/sub-031624/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z 

#--------------------------------------
#@# SubCort Seg Fri May 28 10:39:13 UTC 2021

 mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz 


 mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /out/freesurfer/sub-031624/mri/transforms/cc_up.lta sub-031624 

#--------------------------------------
#@# Merge ASeg Fri May 28 11:31:19 UTC 2021

 cp aseg.auto.mgz aseg.presurf.mgz 

#--------------------------------------------
#@# Intensity Normalization2 Fri May 28 11:31:19 UTC 2021

 mri_normalize -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz 

#--------------------------------------------
#@# Mask BFS Fri May 28 11:33:49 UTC 2021

 mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz 

#--------------------------------------------
#@# WM Segmentation Fri May 28 11:33:50 UTC 2021

 mri_segment -mprage brain.mgz wm.seg.mgz 


 mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz 


 mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz 

#--------------------------------------------
#@# Fill Fri May 28 11:35:52 UTC 2021

 mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.auto_noCCseg.mgz wm.mgz filled.mgz 



#---------------------------------
# New invocation of recon-all Fri May 28 12:57:19 UTC 2021 
#--------------------------------------------
#@# Cortical ribbon mask Fri May 28 12:57:19 UTC 2021

 mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon sub-031624 



#---------------------------------
# New invocation of recon-all Fri May 28 13:10:19 UTC 2021 
#-----------------------------------------
#@# Relabel Hypointensities Fri May 28 13:10:20 UTC 2021

 mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz 

#-----------------------------------------
#@# AParc-to-ASeg aparc Fri May 28 13:10:41 UTC 2021

 mri_aparc2aseg --s sub-031624 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt 

#-----------------------------------------
#@# AParc-to-ASeg a2009s Fri May 28 13:14:54 UTC 2021

 mri_aparc2aseg --s sub-031624 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --a2009s 

#-----------------------------------------
#@# AParc-to-ASeg DKTatlas Fri May 28 13:19:09 UTC 2021

 mri_aparc2aseg --s sub-031624 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --annot aparc.DKTatlas --o mri/aparc.DKTatlas+aseg.mgz 

#-----------------------------------------
#@# APas-to-ASeg Fri May 28 13:23:26 UTC 2021

 apas2aseg --i aparc+aseg.mgz --o aseg.mgz 

#--------------------------------------------
#@# ASeg Stats Fri May 28 13:23:31 UTC 2021

 mri_segstats --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /opt/freesurfer/ASegStatsLUT.txt --subject sub-031624 

#-----------------------------------------
#@# WMParc Fri May 28 13:24:13 UTC 2021

 mri_aparc2aseg --s sub-031624 --labelwm --hypo-as-wm --rip-unknown --volmask --o mri/wmparc.mgz --ctxseg aparc+aseg.mgz 


 mri_segstats --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject sub-031624 --surf-wm-vol --ctab /opt/freesurfer/WMParcStatsLUT.txt --etiv 

