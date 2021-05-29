

#---------------------------------
# New invocation of recon-all Fri May 28 11:36:30 UTC 2021 
#--------------------------------------------
#@# Tessellate lh Fri May 28 11:36:31 UTC 2021

 mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz 


 mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix 


 rm -f ../mri/filled-pretess255.mgz 


 mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix 

#--------------------------------------------
#@# Smooth1 lh Fri May 28 11:36:35 UTC 2021

 mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix 

#--------------------------------------------
#@# Inflation1 lh Fri May 28 11:36:40 UTC 2021

 mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix 

#--------------------------------------------
#@# QSphere lh Fri May 28 11:36:55 UTC 2021

 mris_sphere -q -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix 

#--------------------------------------------
#@# Fix Topology Copy lh Fri May 28 11:38:17 UTC 2021

 cp ../surf/lh.orig.nofix ../surf/lh.orig 


 cp ../surf/lh.inflated.nofix ../surf/lh.inflated 

#@# Fix Topology lh Fri May 28 11:38:17 UTC 2021

 mris_fix_topology -rusage /out/freesurfer/sub-031624/touch/rusage.mris_fix_topology.lh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub-031624 lh 


 mris_euler_number ../surf/lh.orig 


 mris_remove_intersection ../surf/lh.orig ../surf/lh.orig 


 rm ../surf/lh.inflated 

#--------------------------------------------
#@# Make White Surf lh Fri May 28 12:09:45 UTC 2021

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub-031624 lh 

#--------------------------------------------
#@# Smooth2 lh Fri May 28 12:13:38 UTC 2021

 mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm 

#--------------------------------------------
#@# Inflation2 lh Fri May 28 12:13:43 UTC 2021

 mris_inflate -rusage /out/freesurfer/sub-031624/touch/rusage.mris_inflate.lh.dat ../surf/lh.smoothwm ../surf/lh.inflated 

#--------------------------------------------
#@# Curv .H and .K lh Fri May 28 12:13:56 UTC 2021

 mris_curvature -w lh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated 


#-----------------------------------------
#@# Curvature Stats lh Fri May 28 12:15:01 UTC 2021

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub-031624 lh curv sulc 

#--------------------------------------------
#@# Sphere lh Fri May 28 12:15:05 UTC 2021

 mris_sphere -rusage /out/freesurfer/sub-031624/touch/rusage.mris_sphere.lh.dat -seed 1234 ../surf/lh.inflated ../surf/lh.sphere 

#--------------------------------------------
#@# Surf Reg lh Fri May 28 12:24:41 UTC 2021

 mris_register -curv -rusage /out/freesurfer/sub-031624/touch/rusage.mris_register.lh.dat ../surf/lh.sphere /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg 

#--------------------------------------------
#@# Jacobian white lh Fri May 28 12:45:03 UTC 2021

 mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white 

#--------------------------------------------
#@# AvgCurv lh Fri May 28 12:45:05 UTC 2021

 mrisp_paint -a 5 /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv 

#-----------------------------------------
#@# Cortical Parc lh Fri May 28 12:45:06 UTC 2021

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-031624 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot 

#--------------------------------------------
#@# Make Pial Surf lh Fri May 28 12:45:17 UTC 2021

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub-031624 lh 

#--------------------------------------------
#@# Surf Volume lh Fri May 28 12:56:40 UTC 2021
#-----------------------------------------
#@# Cortical Parc 2 lh Fri May 28 12:56:43 UTC 2021

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-031624 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot 

#-----------------------------------------
#@# Cortical Parc 3 lh Fri May 28 12:56:57 UTC 2021

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-031624 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot 

#-----------------------------------------
#@# WM/GM Contrast lh Fri May 28 12:57:09 UTC 2021

 pctsurfcon --s sub-031624 --lh-only 



#---------------------------------
# New invocation of recon-all Fri May 28 13:04:13 UTC 2021 
#-----------------------------------------
#@# Parcellation Stats lh Fri May 28 13:04:14 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-031624 lh white 


 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-031624 lh pial 

#-----------------------------------------
#@# Parcellation Stats 2 lh Fri May 28 13:05:09 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-031624 lh white 

#-----------------------------------------
#@# Parcellation Stats 3 lh Fri May 28 13:05:39 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-031624 lh white 

#--------------------------------------------
#@# BA_exvivo Labels lh Fri May 28 13:06:06 UTC 2021

 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA1_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA2_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA3a_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA3b_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA4a_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA4p_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA6_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA44_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA45_exvivo.label --trgsubject sub-031624 --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.V1_exvivo.label --trgsubject sub-031624 --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.V2_exvivo.label --trgsubject sub-031624 --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.MT_exvivo.label --trgsubject sub-031624 --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject sub-031624 --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject sub-031624 --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mris_label2annot --s sub-031624 --hemi lh --ctab /opt/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.entorhinal_exvivo.label --l lh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s sub-031624 --hemi lh --ctab /opt/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-031624 lh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-031624 lh white 

