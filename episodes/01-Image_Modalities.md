---
title: "Introduction to structural MR image modalities"
teaching: 20
exercises: 10
questions:
- "How is structural MR image acquired?"
- "What anatomical features do different modalities capture?"
objectives:
- "Visualize and understand differnces in T1,T2,PD/FLAIR weighted images."
keypoints:
- "Different acquisition techniques will offer better quantification of specific brain tissues"
---

## Image acquisition
1. The acquition starts with applying strong magnetic field (e.g. 1.5 or 3.0 Tesla > 10000x earth's magnetic field) which forces the hydrogen nuclei from abundant water molecules in soft tissue in the body to align with the field. You can think of hydrogen nuclei as tiny magnets of their own. 
2. Then the scanner applies a RF pulse which tilts these nuclei from their alighment and then _precess_ back to the alignment. The _precession_ emits an a signal, which is recored by the receiver coils in the scanner. 
3. This signal has two components: 1) _Longitudinal_ (z-axis along the scanner's magnetic field) 2) _Transverse_ (xy-plane orthogonal to the scanner's magnetic field). 
4. Initially the longitudinal signal is weak as most nuclei are tilted away from the z-axis. However this signal grows as nuclei realign. The time constant that dectects the speed of re-alignment is denoted by T1. 
5. Initially the transverse signal is strong as most nuclei are in phase _coherence_. The signal decays as the nuclei dephase as they realign. This decay is denoted by T2 time constant. 

|                | T1 (ms)      | T2 (ms)     |
| :------------- | :----------: | -----------: |
|  Bones | 500   | 50    |
|  CSF | 4000   | 500    |
|  Grey Matter | 1300   | 110    |
|  White Matter   | 800 | 80 \| |

7. Bones and lungs have a short T2 (0.1ms - 2ms) whereas soft tissues such as white-matter and grey-matter have a long T2 (90ms - 100ms) 
8. The tissue specific differences in T1 and T2 relaxation times is what enables us to _see_ anatomy from image contrast. The final image contrast depends on when you _listen_ to the signal (design parameter: echo time (TE)) and how fast you repeat the _tilt-relax_ process i.e. RF pulse freuqency (design parameter: repeatation time (TR)). 
9. Short TE and TR ~ T1 of tissue of interest --> t1 weighted image
10. Long TR (>>T1 of tissue of interest) and TE ~ T2 of tissue of interest --> T2 weighted image
11. Long TR (>>T1 of tissue of interest) and TE ~ 0 --> proton density (PD) image
12. This is referred to as *T2 Weighted Image*. <img width="919" alt="T2w_image_acq" src="https://user-images.githubusercontent.com/7978607/112245357-19d5fe80-8c27-11eb-9977-fc359253e7de.png">

Note: Here we have only talked about image contrast which is most relevent to sMRI image pipelines. The details of signal-source localization and k-space transforms are out of the scope. 


{% include links.md %}

