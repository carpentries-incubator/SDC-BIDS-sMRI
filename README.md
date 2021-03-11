# Introduction to sMRI Analysis in Python

[![Create a Slack Account with us](https://img.shields.io/badge/Create_Slack_Account-The_Carpentries-071159.svg)](https://swc-slack-invite.herokuapp.com/)
[![Slack Status](https://img.shields.io/badge/Slack_Channel-neuroimaging-E01563.svg)](https://swcarpentry.slack.com/messages/CCJBHKCHZ)

## Background

This is one sub-module within the [Neuroimaging cirriculum][neuro_cirriculum]. Visit the link to view all the modules associated with the Neuroimaging Carpentries program.

**sMRI Analysis in Python** is a programme developed to facilitate reproducibility in structural neuroimaging analyses. Python is emerging as a standard language of data analysis, visualization, and workflow building. More recently, it has rapidly been adopted by the neuroimaging community as a means of developing powerful open-source tools in favour of historically used opaque software such as AFNI, FSL and SPM. In addition, the barrier to entry to Python is low - meaning that you as the user can easily develop your own packages and contribute to the open-source codebase of neuroimaging!


***

The **sMRI Analysis in Python** is a workshop series started up via a collaboration between researchers and staff at the Centre for Addiction and Mental Health (Toronto, ON), the University of Western Ontario (London, Ontario), and McGill University (Montreal, Quebec).

***

## About the lesson

This lesson covers sMRI imaging pipeline by introducing 1) image modalities, 2) image preprocessing, 3) phoenotype quantification, and 4) statistical analyses.  

### Episodes

| Time | Episode | Question(s) Answered |
| ---  | ---     | ---                  |
||Setup|Download files required for the lesson|
| 00:00 | 1. Course Overview and Prereqs | What steps do I need to take before beginning to work with sMRI data? |
| 00:30 | 2. Introduction to structural MR image modalities | How is MR image acquired? What anatomical features do different modalities capture?  |
| 01:00 | 3. Image preprocessing with smriprep (Part 1) | How do we clean-up MR images and extract brains? |
| 01:30 | 4. Image preprocessing with smriprep (Part 2) | What are "templates", "spaces", "atlases"? What is spatial normalization? |
| 02:00 | 6. Image quantification | How do we delineate brain anatomy and quantify phenotypes? |
| 02:30 | 7. Statistical analysis with ROIs (Part 1) | How to perform case-control analysis of volumetric or cortical features? |
| 03:00 | 8. Statistical analysis with voxels (Part 2) | How to perform voxel-based-morphometry? |
| 03:30 | 9. Statistical analysis with signal abnormality (Part 3) | How to segment pathologies such as white-matter hyper-intensities? |
| 04:00 | 10. Reproducibility considerations | How sensitive are your findings to your MR pipeline parameters? |
| 04:30 | Finish | |
 

## Contributing

We welcome all contributions to improve the lesson! Maintainers will do their best to help you if you have any
questions, concerns, or experience any difficulties along the way.

We'd like to ask you to familiarize yourself with our [Contribution Guide](CONTRIBUTING.md) and have a look at
the [more detailed guidelines][lesson-example] on proper formatting, ways to render the lesson locally, and even
how to write new episodes.

Please see the current list of [issues](https://github.com/carpentries-incubator/SDC-BIDS-sMRI/issues) for ideas for contributing to this
repository. For making your contribution, we use the GitHub flow, which is
nicely explained in the chapter [Contributing to a Project](http://git-scm.com/book/en/v2/GitHub-Contributing-to-a-Project) in Pro Git
by Scott Chacon.
Look for the tag ![good_first_issue](https://img.shields.io/badge/-good%20first%20issue-gold.svg). This indicates that the mantainers will welcome a pull request fixing this issue.


## Maintainer(s)

* [Nikhil Bhagwat][nikhil_bhagwat]
* [Erin Dickie][erin_dickie]

## Authors

A list of contributors to the lesson can be found in [AUTHORS](AUTHORS)

## Citation

To cite this lesson, please consult with [CITATION](CITATION)

[lesson-example]: https://carpentries.github.io/lesson-example
[Nikhil Bhagwat][https://github.com/nikhil153]
[erin_dickie]: https://github.com/edickie
[neuro_cirriculum]: https://carpentries.org/community-lessons/#neuroimaging
