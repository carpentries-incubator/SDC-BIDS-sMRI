---
title: "Image quantification"
teaching: 20
exercises: 10
questions:
- "How do we delineate brain anatomy and quantify phenotypes?"
- "How to segment pathologies such as white-matter hyper-intensities?"
objectives:
- "Visualize tissue segmentations (voxel spaces)"
- "Visualize cortical surface meshes (vertex spaces)"
- "Visualize and differentiate pathologies in MR images" 
keypoints:
- "Whole-brain quantification of brain anatomy is a first step towards more specific analysis"
- "sMRI pathology measures can have significant impact in diagnosis, treatment planning, and surgery"
---
## You Are Here!
Course flow image edited for this episode to be placed here.

## Tissue and region segmentation
Brain anatomy is different of every individual. Brain tissues are typically divided into grey matter (GM), white matter (WM) and cerebro-spinal fluid (CSF). Each category can inform on a different aspect of the brain studied. Therefore it is often useful to segment the brain in these tissue classes for further processing. GM contains neuron cell bodies, WM includes neuron connection fibers wrapped in a special signal-accelerating substance called myelin, and CSF is a protecting fluid present mostly around the brain but also within brain cavities called ventricles.

In addition of identifying tissue classes, it is of interest to sub-divide these classes in sub-components. As such, GM is commonly split into non-overlapping regions of interests (ROIs) either defined from either a data-driven or an anatomically-driven approach. These approaches are referred to as parcellation or atlasing respectively, although these terms are sometimes used interchangeably. WM can also be split into group of fibers called white matter bundles (for more details please see lesson on dMRI).

Aging and disease can also cause tissue modifications. Common changes include a reduction in GM, as in the  case of ageing and neurodegenerative diseases such as Alzheimer's. A tumor can cause an important localized change of signal in the area most impacted by the tumor. Another example is visible higher WM signal intensities on MRI images, so called WM hyper-intensities, which can be related to vascular pathology (common in aging), or to myelin lesions characteristic of the multiple sclerosis disease.

The analysis of structural images then often consists in first identifying tissue classes -- including pathological tissue -- and their sub-components, and second quantifying morphological differences. The first step is done by segmenting the MRI images, and the second one by measuring differences in signal intensity across subjects (with techniques such as voxel based morphometry (VBM)) or morphological properties such as volume or thickness. GM loss for example can be assessed by:
* measuring GM volume when looking at volumetric data, i.e. voxels
* measuring GM thickness when looking at surface data, i.e. meshes
* comparing the intensity on MRI images with a group of normal control with patients suffering from GM

In this episode we will look at:
* how to segment images into tissue classes, and also also sub-regions in the case of GM
* how to visualize segmentation results both for volumetric and surface data
* how to measure region volumes
* how to extract surface measures pre-computed from a third party software (Freesurfer)

### Segmenting images into tissue classes in normal and pathological tissues, and visualizing the segmentation

#### Normal controls

#### Disease such as Alzheimer's and multiple sclerosis

### Segmenting tissue classes into sub-components (atlasing, parcellation) and visualizing the results

#### Atlasing

#### Parcellation

### Measuring region volumes

#### Revisiting image properties: voxel size and affine transform

#### Measuring volume in standard units

### Extracting surface measurements from pre-computed Freesurfer data

#### Type of information available from Freesurfer

#### Extracting Freesurfer information with Python

{% include links.md %}

