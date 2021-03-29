---
title: "Image quality control"
teaching: 20
exercises: 10
questions:
- "How do we identify image preprocessing failures?"
objectives:
- "Visualize processing failures"
- "Familiarize with automatic QC tools"
keypoints:
- "Image processing failures happen! It is important to perform systematic quality control to minimize biases"
---
## You Are Here!
![course_flow](../fig/episode_5/Course_flow_5.png)

## Things that can go wrong... 

### Acquistion
#### Due to MR physics (e.g. Field of view (FOV), ghosting, aliasing) 
Incorrect parameters can truncate and/or duplicate brain anatomy. 
![MR_physics_QC](../fig/episode_5/MR_physics_QC.png) 
    
#### Due to participant (e.g. Motion artifacts) 
- Participant specific issues such as motion artifcats in Parkinson's patients can manifest in the scan (e.g. ringing effect showing ripples or curved lines).
![Motion_QC](../fig/episode_5/Motion_QC.png)

### Quantification
Exisiting image processing pipelines (e.g. FreeSurfer, CIVET) will have a few QC tools and examples that can help with failure detection and quality control of volumetric segmentations and surface parcellations.  

![Segment_and_surface_QC](../fig/episode_5/Segment_and_surface_QC.png)

Usage of new method will require your own QC protocols. Especially for highly specific segmentation methods require visual inspection from a neuroanatomy expert. Even for the qualitiative visual inspection, it is important create a QC protocol and share it with the results. 
![HC_and_CB_MAGeT](../fig/episode_5/HC_and_CB_MAGeT.png)

_Note: see [Hippocampal](http://dx.doi.org/10.1016/j.neuroimage.2014.04.054) and [cerebellar](https://www.sciencedirect.com/science/article/pii/S1053811914001840?via%3Dihub) for segmentation method details._ 

## Automatic QC tools
- Using reports from exisiting pipelines: https://fmriprep.org/en/stable/_static/sample_report.html
![sMRIPrep_QC_report](../fig/episode_5/sMRIPrep_QC_report.png)

- Using QC tools 
    - [VisualQC](https://github.com/raamana/visualqc) : assistive tool to improve the quality control workflow of neuroimaging data (Author: Pradeep Reddy Raamana). 

|  T1w acquisition |     Alignment        | Cortical Parcellation | 
| :-------------: | :-----------: |:-----------: |
| ![t1_mri_visual_QC](../fig/episode_5/t1_mri_visual_QC.png) | ![alignment_mismatched_colormix_visualQC](../fig/episode_5/alignment_mismatched_colormix_visualQC.png) | ![cortical_zoomed_in](../fig/episode_5/cortical_zoomed_in.png)| 

{% include links.md %}
