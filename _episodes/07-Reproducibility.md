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
![course_flow](../fig/episode_7/Course_flow_7.png)

## MR image processing pipeline selection choices
- Compute environment 
    - OS / system math libararies 
    - Programming libraries Python / R versions

- Software (algorithms and their versions)
    - Image clean-up
    - Image normalization 
    - Image quantification

- Quality control
    - Manual protocol specifics
    - Automatic outlier criteria

- Biological priors
    - Templates 
    - Atlases/parcellations: ROI definitions

## Example software analysis

### Task: compare cortical thickness between FreeSurfer and CIVET

<img src="../fig/episode_7/Reproducibility.png" alt="Drawing" align="middle" width="700px"/> 

_Note: See [this]([https://academic.oup.com/cercor/article/30/9/5014/5831485]) for details on brain plots_

## Correlation between thickness measurements:
### Software: FreeSurfer (v5.1, v5.3, v6.0), CIVET (2.1) and ANTs
### Parcellation: DKT
    
<img src="../fig/episode_7/CT_compare_software.png" alt="Drawing" align="middle" width="700px"/> 


## Possible choices for FreeSurfer parcellations
### Different parcellation different results? 
### Inference pertaining to neuroantomical differences and/or prediction models based on individual neuroanatomical feature sets can be sensitive to parcellation choice. 

<img src="../fig/episode_7/FreeSurfer_parcels.jpg" alt="Drawing" align="middle" width="700px"/> 

_Note: Image adopted from [Madan 2021](https://link.springer.com/article/10.1007/s12021-021-09519-6)_

{% include links.md %}

