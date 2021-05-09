# 5. Statistical Analysis
Structural resonance images (sMRIs) provide information about various tissues type in the brain (e.g. gray matter, white matter, cerbrospinal fluid). sMRI (like fMRI), help study underlying causes of neuropsychiatric illnesses and their mechanisms by studying regional brain activities or atrophies. Statistical analysis of MRIs in individuals over time or cohorts provide region specific neuroanatomical information related to clinical questions in studies related to neuropsychiatric.

## 5.1. ROI driven analyses with Nilearn
Nilearn is a Python module that provides statistical and machine learning tools for anayses of NeuroImaging. This module supports general linear model (GLM) and leverages the scikit-learn Python toolbox for multivariate statistics with applications such as predictive modelling, classification, decoding, or connectivity analysis.

Regions of interests (ROIs) in sMRI can be defined in terms of structural features, usually defined based on anatomy. Manual labeling done by experts are considered the gold standard, yet recently developed automated anatomical labeling offer the promise of highly reliable labeling. Brain atlases are commonly used for automatic labeling of regions, allowing further analysis specific to the ROIs. Atlas-based methods used to label ROIs will need to take in to account inter-subject variations across the population used to construct the atlas. 

### 5.1.1. Volumetric Atlases
Brain atlases are used for identifying ROIs, often required to obtain statistical inferences in neuroimaging. For example, parcellation of ROIs in the cortex is achieved using cortical atlases and subcortical atlases are used for parcellation of subcortical structures of interest. Commonly used cortical and subcortical atlases are listed below. 

Cortical atlas parcellations
* Automated Anatomical Labeling (Tzourio-Mazoyer 2002)
* Local-Global Parcellation of the Human Cerebral Cortex (Schaefer 2018)
* Harvard-Oxford cortical/subcortical atlases (Makris 2006)
* Destrieux Atlas (Destrieux 2010)
  
Subcortical atlas parcellations
* CIT168 Reinforcement Learning Atlas (Pauli 2017)
* Computational Brain Anatomy Lab Merged Atlas (CoBrALab Atlas) in MNI Space (Pipitone 2014)
* Melbourne Subcortex Atlas (Tian 2020)
* Chakravarty 2006 Atlas
* THOMAS Atlas (Saranathan 2019)

Examples on visualizing a selected few of these atlases are listed in the following section (section 5.1.1.1)

#### 5.1.1.1. Visualizing anatomical atlases
##### Cortical Parcellations
###### Automated Anatomical Labeling (Tzourio-Mazoyer 2002)
```
dataset = datasets.fetch_atlas_aal('SPM12')
atlas_filename = dataset.maps
plotting.plot_roi(atlas_filename, title="AAL")
```
<img src="/fig/episode_5/5_Fig1_corAtlas_AAL.png" width="400" height="170" />

###### Local-Global Parcellation of the Human Cerebral Cortex (Schaefer 2018)
```
dataset = datasets.fetch_atlas_schaefer_2018()
atlas_filename = dataset.maps
plotting.plot_roi(atlas_filename, title="Schaefer 2018")

# By default, the number of ROIs is 400 and  and ROI annotations according neo networks is 7.
# This may be changed by changing the inputs to the function as below.
# nilearn.datasets.fetch_atlas_schaefer_2018(n_rois=400, yeo_networks=7)
```
<img src="/fig/episode_5/5_Fig2_corAtlas_Schaefer.png" width="400" height="170" />

###### Harvard-Oxford cortical/subcortical atlases (Makris 2006)
```
dataset = datasets.fetch_atlas_harvard_oxford('cort-maxprob-thr25-2mm')
atlas_filename = dataset.maps
plotting.plot_roi(atlas_filename, title="Harvard Oxford atlas")
```
<img src="/fig/episode_5/5_Fig3_corAtlas_Harvard-Oxford.png" width="400" height="170" />


##### Subcortical Parcellations
###### CIT168 Reinforcement Learning Atlas (Pauli 2017)
```
dataset = datasets.fetch_atlas_pauli_2017()
atlas_filename = dataset.maps 
plotting.plot_prob_atlas(atlas_filename, title="Pauli 2017")
```
<img src="/fig/episode_5/5_Fig5_subAtlas_Pauli.png" width="400" height="170" />


#### 5.1.1.2. Regional volumetric differences in case-control cohorts

In this section, we will discuss two cases.
1) Volumetric alterations in the whole hippocampus 
3) Volumetric alterations in hippocampal subfields 

This two examples are focused on the hippocampus and its subfields, as it is studied with respect to many neuropsychiatric and neurodegenerative disorders due to its central role in memory, emotion and learning, that have been linked to many noticeable symptoms. 
Demarcation of subfield boundries may vary amongst researchers. However, in these examples we refer to subfields as in the [Winterburn Atlas](https://www.sciencedirect.com/science/article/pii/S1053811913001237?via%3Dihub). A figure of the hippocampal formation with labelled subfields are included below for reference.
<img src="/fig/episode_5/5_HippocampalSubfields.png" width="230" height="170" />

Segmentations in the examples discussed in this section was performed using MAGeTBrain, another commonly used segmentation software.

#### **MAGeTbrain**
Multiple Automatically Generated Templates Brain Segmentation Algorithm (MAGeTBrain), is a software developed by [CoBrA Lab](http://cobralab.ca/). 
Given a set of labelled MR images (atlases) and unlabelled images (subjects), MAGeT produces a segmentation for each subject using a multi-atlas voting procedure based on a template library made up of images from the subject set. An overview of this method is shown in the figure below.

<img src="/fig/episode_5/5_MAGeTOverview.png" width="480" height="400" />

In MAGeT brain, segmentations from each atlas (typically manually delineated) are propogated via image registration to a subset of the subject images (known as the ‘template library’) before being propogated to each subject image and fused. By propogating labels to a template library, we are able to make use of the neuroanatomical variability of the subjects in order to ‘fine tune’ each individual subject’s segmentation. The github repository for MAGeTbrain can be found [here](https://github.com/CobraLab/MAGeTbrain).

Note: volume is measured in voxels.

Related citations:

_M Mallar Chakravarty, Patrick Steadman, Matthijs C van Eede, Rebecca D Calcott, Victoria Gu, Philip Shaw, Armin Raznahan, D Louis Collins, and Jason P Lerch. Performing label-fusion-based segmentation using multiple automatically generated templates. Hum Brain Mapp, 34(10):2635–54, October 2013. [(doi:10.1002/hbm.22092)](https://onlinelibrary.wiley.com/doi/epdf/10.1002/hbm.22092)_

_Jon Pipitone, Min Tae M Park, Julie Winterburn, Tristram A Lett, Jason P Lerch, Jens C Pruessner, Martin Lepage, Aristotle N Voineskos, and M Mallar Chakravarty. Multi-atlas segmentation of the whole hippocampus and subfields using multiple automatically generated templates. Neuroimage, 101:494–512, November 2014.
[(doi:10.1016/j.neuroimage.2014.04.054)](https://www.sciencedirect.com/science/article/pii/S1053811914003346?via%3Dihub)_

##### 1) Volumetric alterations in the whole hippocampus 

##### Example 1.1: Comparison of hippocampal volumes across groups with normal cognition, mild cognitive impairment and Alzheimer's disease 

Sixty 1.5T images baseline scans were selected arbitrarily from the ADNI1: Complete 1Yr 1.5T standardized dataset. Twenty subjects were chosen from each disease category: cognitively normal (CN),mild cognitive impairment (MCI) and Alzheimer's disease (AD).

MAGeT-Brain was applied to this dataset and the resulting segmentations werecompared to segmentations produced by FreeSurfer, FSLFIRST, MAPER, as well as semi-automated whole hippocampal segmentations (SNT) provided by ADNI. Examples for hippocampal segmentations and hippocampal volume measures obtained by different are shown in the Figures below.

<img src="/fig/episode_5/5_VolAnalysis_Eg1.png" width="600" height="560" />

The boxplot showed that the total bilateral hippocampal volume between commonly used methods are well correlated. Within disease categories (i.e. CN, LMCI and AD), MAGeTbrain is consistently well correlated to SNT volumes, but appears to slightly over-estimate the volume of the AD hippocampus compared to the SNT segmentations.

Related citations:
_Jon Pipitone, Min Tae M Park, Julie Winterburn, Tristram A Lett, Jason P Lerch, Jens C Pruessner, Martin Lepage, Aristotle N Voineskos, and M Mallar Chakravarty. Multi-atlas segmentation of the whole hippocampus and subfields using multiple automatically generated templates. Neuroimage, 101:494–512, November 2014.
[(doi:10.1016/j.neuroimage.2014.04.054)](https://www.sciencedirect.com/science/article/pii/S1053811914003346?via%3Dihub)_

##### 2) Volumetric alterations in hippocampal sufields

##### Example 2.1: Whole hippocampal segmentation comparison across cohorts _[(Voineskos et al, 2015)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6869683/pdf/HBM-36-3020.pdf)_)

A total of 137 healthy volunteers (18–86 years, µ:45.4|SD:19) recruited by CAMH-Toronto, were used in this study. 

A general linear model (GLM) was used to assess all relationships, and all tests were corrected for multiple comparisons using FDR [Benjamini and Hochberg, 1995]. Comparisons surviving 5% FDR were deemed to be significant. The relationship between hippocampal volumes and age was assessed, with sex, years of education, APOEe4 carrier status, and TBV included in the model. The results obtained were as shown in the figure below.

<img src="/fig/episode_5/5_VolAnalysis_Eg2.png" width="760" height="360" />

It was observed that all right and left whole hippocampal and subfield volumes were inversely related to age after correction for multiple comparisons except for the right and left CA1 (R²=0.018,_q_=0.069 for both).

Related citations:
_Hippocampal (subfield) volume and shape in relation to cognitive performance across the adult lifespan. Aristotle N. Voineskos, Julie L. Winterburn, Daniel Felsky, Jon Pipitone, Tarek K. Rajji, Benoit H. Mulsant, M. Mallar Chakravarty. Hum Brain Mapp. 2015 Aug; 36(8): 3020–3037. May 2015 [(doi: 10.1002/hbm.22825)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6869683/pdf/HBM-36-3020.pdf)_

### 5.1.2. Cortical surface parcellations 
Cortical surfaces can be parcellated into anatomically and functionally meaningful regions. This fascilitates identification and characterization of morphometric and connectivity alterations in the brain that may occur as a result of a disease or aging. 
For example utilities in the FreeSurfer software includes a technique for automatically assigning a neuroanatomical label to each location on a cortical surface model based on probabilistic information estimated from a manually labeled training set. As this procedure incorporates both geometric information derived from the cortical model, and neuroanatomical convention, the result is a complete labeling of cortical sulci and gyri.
Some commonly used cortical surface parcellations are shown below. 

#### 5.1.2.1. Visualizing cortical surface parcellations
###### Destrieux Atlas (Destrieux 2010)
```
destrieux_atlas = datasets.fetch_atlas_surf_destrieux()
parcellation = destrieux_atlas['map_left']

# Retrieve fsaverage5 surface dataset for the plotting background. It contains
# the surface template as pial and inflated version and a sulcal depth maps which is used for shading
fsaverage = datasets.fetch_surf_fsaverage()

# Lateral view is observed in this example.
# Other views (e.g. posterior, ventral may also be used)
plotting.plot_surf_roi(fsaverage['pial_left'], roi_map=parcellation,hemi='left', 
                       view='lateral',bg_map=fsaverage['sulc_left'], bg_on_data=True,darkness=.5)
```
<img src="/fig/episode_5/5_Fig4_corAtlas_Destrieux.png" width="230" height="170" />


#### 5.1.2.2. Regional cortical thickness variation in developmental cohorts
