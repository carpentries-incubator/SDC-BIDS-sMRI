
### Volumetric Analysis - Related work

#### Regional volumetric differences in case-control cohorts - Examples

In this section, we will discuss two cases.
1) Volumetric alterations in the whole hippocampus 
3) Volumetric alterations in hippocampal subfields 


Segmentations in the examples discussed in this section was performed using MAGeTBrain, another commonly used segmentation software.

The github repository for MAGeTbrain can be found [here](https://github.com/CobraLab/MAGeTbrain).

Note: volume is measured in voxels.

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

