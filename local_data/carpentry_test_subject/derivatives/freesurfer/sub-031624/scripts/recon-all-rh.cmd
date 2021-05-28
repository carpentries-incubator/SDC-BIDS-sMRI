

#---------------------------------
# New invocation of recon-all Fri May 28 11:36:27 UTC 2021 
#--------------------------------------------
#@# Tessellate rh Fri May 28 11:36:28 UTC 2021

 mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz 


 mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix 


 rm -f ../mri/filled-pretess127.mgz 


 mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix 

#--------------------------------------------
#@# Smooth1 rh Fri May 28 11:36:32 UTC 2021

 mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix 

#--------------------------------------------
#@# Inflation1 rh Fri May 28 11:36:37 UTC 2021

 mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix 

#--------------------------------------------
#@# QSphere rh Fri May 28 11:36:51 UTC 2021

 mris_sphere -q -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix 

#--------------------------------------------
#@# Fix Topology Copy rh Fri May 28 11:38:16 UTC 2021

 cp ../surf/rh.orig.nofix ../surf/rh.orig 


 cp ../surf/rh.inflated.nofix ../surf/rh.inflated 

#@# Fix Topology rh Fri May 28 11:38:16 UTC 2021

 mris_fix_topology -rusage /out/freesurfer/sub-031624/touch/rusage.mris_fix_topology.rh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub-031624 rh 


 mris_euler_number ../surf/rh.orig 


 mris_remove_intersection ../surf/rh.orig ../surf/rh.orig 


 rm ../surf/rh.inflated 

#--------------------------------------------
#@# Make White Surf rh Fri May 28 12:06:56 UTC 2021

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub-031624 rh 

#--------------------------------------------
#@# Smooth2 rh Fri May 28 12:10:44 UTC 2021

 mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm 

#--------------------------------------------
#@# Inflation2 rh Fri May 28 12:10:48 UTC 2021

 mris_inflate -rusage /out/freesurfer/sub-031624/touch/rusage.mris_inflate.rh.dat ../surf/rh.smoothwm ../surf/rh.inflated 

#--------------------------------------------
#@# Curv .H and .K rh Fri May 28 12:11:02 UTC 2021

 mris_curvature -w rh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated 


#-----------------------------------------
#@# Curvature Stats rh Fri May 28 12:12:05 UTC 2021

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm sub-031624 rh curv sulc 

#--------------------------------------------
#@# Sphere rh Fri May 28 12:12:09 UTC 2021

 mris_sphere -rusage /out/freesurfer/sub-031624/touch/rusage.mris_sphere.rh.dat -seed 1234 ../surf/rh.inflated ../surf/rh.sphere 

#--------------------------------------------
#@# Surf Reg rh Fri May 28 12:21:04 UTC 2021

 mris_register -curv -rusage /out/freesurfer/sub-031624/touch/rusage.mris_register.rh.dat ../surf/rh.sphere /opt/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg 

#--------------------------------------------
#@# Jacobian white rh Fri May 28 12:39:42 UTC 2021

 mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white 

#--------------------------------------------
#@# AvgCurv rh Fri May 28 12:39:44 UTC 2021

 mrisp_paint -a 5 /opt/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv 

#-----------------------------------------
#@# Cortical Parc rh Fri May 28 12:39:45 UTC 2021

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-031624 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot 

#--------------------------------------------
#@# Make Pial Surf rh Fri May 28 12:39:56 UTC 2021

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub-031624 rh 

#--------------------------------------------
#@# Surf Volume rh Fri May 28 12:52:16 UTC 2021
#-----------------------------------------
#@# Cortical Parc 2 rh Fri May 28 12:52:19 UTC 2021

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-031624 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot 

#-----------------------------------------
#@# Cortical Parc 3 rh Fri May 28 12:52:33 UTC 2021

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-031624 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot 

#-----------------------------------------
#@# WM/GM Contrast rh Fri May 28 12:52:45 UTC 2021

 pctsurfcon --s sub-031624 --rh-only 



#---------------------------------
# New invocation of recon-all Fri May 28 13:04:13 UTC 2021 
#-----------------------------------------
#@# Parcellation Stats rh Fri May 28 13:04:14 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-031624 rh white 


 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-031624 rh pial 

#-----------------------------------------
#@# Parcellation Stats 2 rh Fri May 28 13:05:11 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-031624 rh white 

#-----------------------------------------
#@# Parcellation Stats 3 rh Fri May 28 13:05:42 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-031624 rh white 

#--------------------------------------------
#@# BA_exvivo Labels rh Fri May 28 13:06:10 UTC 2021

 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA1_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA2_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA3a_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA3b_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA4a_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA4p_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA6_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA44_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA45_exvivo.label --trgsubject sub-031624 --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.V1_exvivo.label --trgsubject sub-031624 --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.V2_exvivo.label --trgsubject sub-031624 --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.MT_exvivo.label --trgsubject sub-031624 --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject sub-031624 --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject sub-031624 --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/freesurfer/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject sub-031624 --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mris_label2annot --s sub-031624 --hemi rh --ctab /opt/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.entorhinal_exvivo.label --l rh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s sub-031624 --hemi rh --ctab /opt/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-031624 rh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-031624 rh white 

