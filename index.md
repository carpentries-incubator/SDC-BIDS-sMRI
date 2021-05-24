---
layout: lesson
root: .  # Is the only page that doesn't follow the pattern /:path/index.html
permalink: index.html  # Is the only page that doesn't follow the pattern /:path/index.html
---

Welcome to the **Structural Neuroimaging Analysis in Python** workshop! 

The primary goals of this workshop are:
1. Understand the basics of strcutural MR image acquisition
2. Familiarize with structural MR image (pre)processing pipeline
3. Perform and visualize group-level neuroanatomical analyses

Things to keep in mind:
1. Magnetic resonance (MR) imaging is a medical imaging technique used visualize anatomy and the physiological processes of the body. MR imaging scanners use strong magnetic fields, magnetic field gradients, and radio waves to generate images of the organs in the body.
2. In structural neuroimaging, MR scans can refer to several different image modalities including, T1-weighted, T2-weighted, diffusion weighted images (DWI), proton-densty (PD), Fluid attenuation inversion recovery (FLAIR) etc. 
3. MR (pre)processing pipeline is a set of sequential image processing tasks performed on acquired MR scans prior to the statistical analyese. 

Notes:
1. These days (year 2021), several software packages (e.g. FreeSurfer, FSL, SPM, fMRIprep) provide ready-to-use pipelines which will comprise commonly used pre(processesing) tasks. Thus as a user, you need not know the details of each image processing algorithm. Nevertheless it is useful to understand the key objectives of these tasks, the corresponding computational methods, and their impact on the downstream analyses. This will 1) help developers to improve the underlying algorithms  and 2) help users to customize the neuorimaging pipelines according to specific dataset requirements. 

_All of this may sound complicated, but we'll explain things step-by-step in depth with practical examples as the course goes along. We will begin our computational journey stating from how an MR image is acquired, followed by several pre-processing tasks, with the end goal of conducting a statistical analysis to investigate volumetric hippocampal differences between Alzheimer's patients and healthy controls._
 
![course_flow](fig/index/Overview.png)

<!-- this is an html comment -->

{% comment %} This is a comment in Liquid {% endcomment %}

> ## Prerequisites
> Attendees must have some base familiarity with Python and NIfTI images in order to comfortably progress through the lesson
{: .prereq}

{% include links.md %}
