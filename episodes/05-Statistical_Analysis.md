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


#### 5.1.1.2. Regional volumetric analysis
Software such as FSL and FreeSurfer can be used for segmentation of regions of interest. For us to conveniently use such pipelines on this platform, we use [NiPype](https://nipype.readthedocs.io/en/0.12.0/index.html) which is an open-source Python project that provides a uniform interface to existing neuroimaging software.

Several interfaces available through NiPype maybe used for this task. We will be looking at one example for the sake of simplicity.

##### Using FSL to segment a region of interest
We use a single sMRI from the haxby dataset and make a copy of it in our current working directory to make processing easier.
```
haxby_dataset = datasets.fetch_haxby()
anat_file = haxby_dataset.anat[0]
```
```
import shutil
shutil.copyfile(anat_file,os.path.join(os.getcwd(),'structural.nii.gz'))
```
FSL First can be used for segmentation of the required structures. For this example, we focus on the left hippocampus (a subcortical structure). 
```
first = fsl.FIRST()
first.inputs.in_file  = 'structural.nii.gz'
first.inputs.out_file = 'segmented.nii.gz'
first.inputs.list_of_specific_structures=['L_Hipp']
res = first.run()
```
If you need to segment for all the structures provided, simply comment ```first.inputs.list_of_specific_structures=['L_Hipp']```.
Once the process is complete, the segmented output can be viewed as follows:
```
T1w_img   =nib.load('structural.nii.gz')
seg_labels=nib.load('segmented-L_Hipp_first.nii.gz')
from nilearn import plotting
plotting.plot_roi(roi_img=seg_labels, bg_img=T1w_img, alpha=0.9, cmap="cool",dim=-.5);
```
Within your working directory, there will be several output files created by FSL. Here, the _first.nii.gz_ is the original output, while the _corr.nii.gz_ files may have had boundary correction applied to them (depending on the structure).
(Fun fact: the value assigned to _dim_ in _plotting_roi_ controls the visibility of the background image). 

<img src="/fig/episode_5/5_HippL_FSL.png" width="470" height="200" />
The volume of the segemented region can be found using _imagestats_. 

(You will also be able to notice a considerable difference in volume estimations in _first.nii.gz_ and _corr.nii.gz_.) 

```
import nibabel.imagestats as imagestats
imagestats.mask_volume(nib.Nifti1Image(seg_labels.get_fdata(), np.eye(4)))
```

```
OUT[]: 4189.0
```
💡 **Exercise 5.1**: Can you follow the same steps above to segment a different structure of interest? 

##### Using FreeSurfer to segment regions of interest
Similar to FSL, FreeSurfer can be used through the NiPype interface as well. The ```recon-all``` process on freesurfer allows us to obtain all or any part of the cortical reconstruction process. This process is fairly time consuming. The code below, adapted from the [NiPype beginners guide](https://miykael.github.io/nipype-beginner-s-guide/prepareData.html), can be used to achieve this.  

```
# Import modules
import os
from os.path import join as opj
from nipype.interfaces.freesurfer import ReconAll
from nipype.interfaces.utility import IdentityInterface
from nipype.pipeline.engine import Workflow, Node

# Specify important variables
experiment_dir = '~/nipype_tutorial'           # location of experiment folder
data_dir = opj(experiment_dir, 'data')         # location of data folder
fs_folder = opj(experiment_dir, 'freesurfer')  # location of freesurfer folder

subject_list = ['sub001', 'sub002', 'sub003', 'sub004', 'sub005', 'sub006',
                'sub007', 'sub008', 'sub009','sub010']   # subject identifier

T1_identifier = 'struct.nii.gz'                  # Name of T1-weighted image

# Create the output folder - FreeSurfer can only run if this folder exists
os.system('mkdir -p %s'%fs_folder)

# Create the pipeline that runs the recon-all command
reconflow = Workflow(name="reconflow")
reconflow.base_dir = opj(experiment_dir, 'workingdir_reconflow')

# Some magical stuff happens here (not important for now)
infosource = Node(IdentityInterface(fields=['subject_id']),
                  name="infosource")
infosource.iterables = ('subject_id', subject_list)

# This node represents the actual recon-all command
reconall = Node(ReconAll(directive='all', subjects_dir=fs_folder), name="reconall")

# This function returns for each subject the path to struct.nii.gz
def pathfinder(subject, foldername, filename):
    from os.path import join as opj
    struct_path = opj(foldername, subject, filename)
    return struct_path

# This section connects all the nodes of the pipeline to each other
reconflow.connect([(infosource, reconall, [('subject_id', 'subject_id')]),
                   (infosource, reconall, [(('subject_id', pathfinder,
                                             data_dir, T1_identifier),
                                            'T1_files')]),
                   ])

# This command runs the recon-all pipeline in parallel (using 8 cores)
reconflow.run('MultiProc', plugin_args={'n_procs': 8})

```
If you want to use the same dataset made available by nipype, you can download and arrange the data by running [this script](/5_OtherFiles/5_Download_NiPypeTutorial_Data.sh). 
Also, make sure that your ```$FREESURFER_HOME``` (```path/to/freesufer/location```) and ```$SUBJECTS_DIR``` (```/path/to/subjects/outputs``` e.g. ```SUBJECTS_DIR=~/nipype_tutorial/freesurfer```) paths are set properly.

Once the process in complete, your folder structure containing original data and output files will be available in your working directory/SUBJECTS_DIR.
<details> <summary markdown="span">Click here to take a look at the overview of the folder structure.</summary>

```
nipype_tutorial
|_data
    |_sub001
    |_sub002
    ...
    |_sub010
|_freesurfer
    |_sub001
      |_label
      |_mri
      |_scripts 
      |_stats   
      |_surf    
      |_tmp    
      |_touch   
      |_trash
    ...
    |_sub010
```
</details>

Considering a single subject: The required stats could be found within the respective folders. Segmentation statistics of subcortical structures can be found in _aseg.stats_ . When using FreeSurfer, the segmented left hippocampal volume is: ``` 4287 mm^3 ```

##### Volumetric Analysis: ROI differences in Young, Middle Aged, Nondemented and Demented Older Adults
Once a dataset is processed, the volumes of each ROI can be collected and included in a .csv file (or other formats you prefer). 

As processing takes time, for this example we use processed freesurfer outputs for ROI that is available on the OASIS website. The summarized freesurfer outputs from the OASIS1 dataset can be downloaded [here](/5_OtherFiles/OASIS_FS_ASEG.csv).
Older adults who are demented at the time of scanning and those who are progressing have been given a Clinical Dementia Rating (CDR).

We can observe the ROI volumetric differences in adults and how these volumes vary based on their CDR. For this example, we consider 6 regions of interest: Left/Right Amygdala, Hippocampus and Lateral ventricle.

```
import pandas     as pd
import seaborn    as sns
import matplotlib
import matplotlib.pyplot as plt
oasis_aseg = pd.read_csv("/Users/swapna/DataCarpentry_sMRI/OASIS_FS_ASEG.CSV")
fig, axes = plt.subplots(2, 3, figsize=(18, 10))

sns.boxplot(ax=axes[0, 0], data=oasis_aseg, x='CDR', y='Right-Amygdala VOLUME',hue='CDR',palette='pastel')
sns.boxplot(ax=axes[0, 1], data=oasis_aseg, x='CDR', y='Right-Hippocampus VOLUME',hue='CDR',palette='pastel')
sns.boxplot(ax=axes[0, 2], data=oasis_aseg, x='CDR', y='Right-Lateral-Ventricle VOLUME',hue='CDR',palette='pastel')

sns.boxplot(ax=axes[1, 0], data=oasis_aseg, x='CDR', y='Left-Amygdala VOLUME',hue='CDR',palette='pastel')
sns.boxplot(ax=axes[1, 1], data=oasis_aseg, x='CDR', y='Left-Hippocampus VOLUME',hue='CDR',palette='pastel')
sns.boxplot(ax=axes[1, 2], data=oasis_aseg, x='CDR', y='Left-Lateral-Ventricle VOLUME',hue='CDR',palette='pastel')
```
We can observe that the ROI volumes are smaller when subject is likely to have a higher CDR.
<img src="/fig/episode_5/5_SubVolumes.png" width="760" height="390" />

💡 **Exercise 5.2**: Can you find the effect size for the ROIs in adults over 60? (Download the .csv [here](/5_OtherFiles/OASIS_FS_ASEG_OVER60.csv))

<details>
  <summary markdown="span">Hint: You need to look cohen's D effect size between demented and non-demented adults. Click for more help</summary>

```
import numpy as np
def calc_effect_size(group1,group2):
    mean1 = np.mean(group1)
    mean2 = np.mean(group2)
    std1  = np.std(group1)
    std2  = np.std(group2)
    
    numerator   = (mean1-mean2)
    denominator = np.sqrt(np.square(std1)+np.square(std2))/2
    effect_size= numerator/denominator
    return effect_size
```
</details>


The output we got looks like:

<img src="/fig/episode_5/5_EffectSize.png" width="400" height="230" />

Click [here](/5_OtherFiles/5_RelatedStudies_statAnalysis.md) to look at releated analysis from studies! 

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
