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
![corticalAtlas_AAL](/fig/episode_5/5_Fig1_corAtlas_AAL.png)

###### Local-Global Parcellation of the Human Cerebral Cortex (Schaefer 2018)
```
dataset = datasets.fetch_atlas_schaefer_2018()
atlas_filename = dataset.maps
plotting.plot_roi(atlas_filename, title="Schaefer 2018")

# By default, the number of ROIs is 400 and  and ROI annotations according neo networks is 7.
# This may be changed by changing the inputs to the function as below.
# nilearn.datasets.fetch_atlas_schaefer_2018(n_rois=400, yeo_networks=7)
```
![corticalAtlas_Schaefer2018](/fig/episode_5/5_Fig2_corAtlas_Schaefer.png)

###### Harvard-Oxford cortical/subcortical atlases (Makris 2006)
```
dataset = datasets.fetch_atlas_harvard_oxford('cort-maxprob-thr25-2mm')
atlas_filename = dataset.maps
plotting.plot_roi(atlas_filename, title="Harvard Oxford atlas")
```
![corticalAtlas_Harvard-Oxford](/fig/episode_5/5_Fig3_corAtlas_Harvard-Oxford.png)



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
![corticalAtlas_Destrieux](/fig/episode_5/5_Fig4_corAtlas_Destrieux.png)


##### Subcortical Parcellations
###### CIT168 Reinforcement Learning Atlas (Pauli 2017)
```
dataset = datasets.fetch_atlas_pauli_2017()
atlas_filename = dataset.maps 
plotting.plot_prob_atlas(atlas_filename, title="Pauli 2017")
```
![subcorticalAtlas_Pauli](/fig/episode_5/5_Fig5_subAtlas_Pauli.png)

#### 5.1.1.2. Regional volumetric differences in case-control cohorts


### 5.1.2. Cortical surface parcellations 


#### 5.1.2.1. Visualizing cortical surfaces parcellations


#### 5.1.2.2. Regional cortical thickness variation in developmental cohorts
