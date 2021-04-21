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
- Compute environment 
    - OS
    - math-libs

- Software (algorithms and their versions)
    - image clean-up
    - image preproc
    - image quantification

- Quality control
    - manual
    - automatic

- Biological priors
    - templates
    - atlases

## Example software analysis

- Task: compare cortical thickness between two FreeSurfer and CIVET
![reproducibility](../fig/episode_8/Reproducibility.png)

_Note: See [this]([https://academic.oup.com/cercor/article/30/9/5014/5831485]) for details on brain plots]_

- Correlation between thickness measurements from FreeSurfer and CIVET pipelines aggregated with DKT parcellation 
![software_compare](../fig/episode_8/CT_compare_software.png)

{% include links.md %}

