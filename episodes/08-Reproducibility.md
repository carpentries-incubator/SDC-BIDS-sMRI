---
title: "Reproducibility considerations"
teaching: 20
exercises: 10
questions:
- "How sensitive are the findings to your MR pipeline parameters?"
objectives:
- "Understand impact of software and atlas choices"
keypoints:
- "It is crucial to assess biological vs methodological variation in your findings to avoid reproducibility crisis."
---
## You Are Here!
![course_flow](../fig/episode_8/Course_flow_8.png)

## MR image processing pipeline selection choices
- Algorithms 
    - image clean-up
    - image preproc
    - image quantification

- Biological priors
    - templates
    - atlases

- Quality control
    - manual
    - automatic

## Example analysis
- Cortical thickness calculation
    - FreeSurfer vs CIVET
    - Add table for preproc and templates and atlases and QC
        - (FS cortical thickness)[https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferAnalysisPipelineOverview]
            - clean up 
                - affine registration to the MNI305 atlas 
                - Bias field removal 
                - brain extraction (Segonne et al., 2004)

            - preproc
                - segmentation of the subcortical white matter and deep gray matter volumetric structures (Fischl et al., 2002; Fischl et al., 2004a)
                - intensity normalization (Sled et al., 1998)
                - tessellation of the gray matter white matter boundary (Fischl et al., 2001; Segonne et al., 2007)
                - nonlinear registration to the fsaveage surface atlas
            
            - quantification
                - calculation of cortical thickness as the closest distance from the gray/white boundary to the gray/CSF boundary at each vertex on the tessellated surface (Fischl and Dale, 2000). 
                - vertex space: fsaverage=163,842, fsaverage6=40,962, fsaverage5=10,242 vertices per hemisphere
                - aggregation of cortical thickness into regions of interests using DKT or Destrieux Atlas

        - (CIVET cortical thickness)[https://www.bic.mni.mcgill.ca/ServicesSoftware/CIVET-2-1-0-Introduction]
            - clean up
                - affine registration to MNI ICBM152 model
                - intensity normalization (Sled et al., 1998)
                - brain extraction 

            - preproc 
                - tissue classification into white matter (WM), gray matter (GM), and cerebrospinal fluid (CSF)
                - calculation of boundary between cortical GM and subcortical WM: white matter surface
                - calculation of boundary between cortical GM and the extra-cortical CSF: gray matter surface
                - registered to the MNI ICBM152 surface template

            - quantification
                - cortical thickness is computed by evaluating the distance between the original WM and GM surfaces
                - vertex space: 81,920 triangles (polygons) and 40,962 vertices. High resolution at 327,680 polygons and 163,842 vertices.
                - ROI aggregation: major lobes, AAL, or DKT-40


{% include links.md %}

