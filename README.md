# Introduction to sMRI (Pre)processing and Analysis in Python

[![Create a Slack Account with us](https://img.shields.io/badge/Create_Slack_Account-The_Carpentries-071159.svg)](https://swc-slack-invite.herokuapp.com/)
[![Slack Status](https://img.shields.io/badge/Slack_Channel-neuroimaging-E01563.svg)](https://swcarpentry.slack.com/messages/CCJBHKCHZ)

## Background

This is one sub-module within the [Neuroimaging cirriculum][neuro_cirriculum]. Visit the link to view all the modules associated with the Neuroimaging Carpentries program.

**sMRI Analysis in Python** is a programme developed to facilitate reproducibility in structural neuroimaging analyses. Python is emerging as a standard language of data analysis, visualization, and workflow building. More recently, it has rapidly been adopted by the neuroimaging community as a means of developing powerful open-source tools in favour of historically used opaque software such as AFNI, FSL and SPM. In addition, the barrier to entry to Python is low - meaning that you as the user can easily develop your own packages and contribute to the open-source codebase of neuroimaging!

***

The **sMRI Analysis in Python** is a workshop series started up via a collaboration between researchers and staff at the Centre for Addiction and Mental Health (Toronto, ON), the University of Western Ontario (London, Ontario), and McGill University (Montreal, Quebec).

***

## About the lesson

This lesson covers a typrical sMRI imaging pipeline by introducing 1) image modalities, 2) image preprocessing, 3) phoenotype quantification, and 4) statistical analyses.  

The primary goals of this workshop are:
1. Understand the basics of strcutural MR image acquisition
2. Familiarize with structural MR image (pre)processing pipeline
3. Perform and visualize group-level neuroanatomical analyses


### Episodes

| Time | Episode | Question(s) Answered |
| ---  | ---     | ---                  |
||Setup|Download files required for the lesson|
| 00:00 | 1. sMRI Modalities | How is MR image acquired? What anatomical features do different modalities capture?  |
| 00:30 | 2. sMRI Image Clean-up | How do we remove intensity artifacts and extract brains? |
| 01:15 | 3. sMRI Spatial Normalization | What are "coordinate spaces", "templates", "atlases"? What is image registration? |
| 02:00 | 4. sMRI Quantification | How do we delineate brain anatomy and quantify phenotypes? |
| 02:45 | 5. sMRI Quality-control | How do we identify image preprocessing failures? |
| 03:15 | 6. Statistical Analysis | How to compare regional anatomical differences in case-control groups? |
| 04:00 | 7. Reproducibility Considerations | How sensitive are the findings to your MR pipeline parameters? |
| 04:30 | Finish | |
 

## You Are Here!
![course_flow](fig/index/Course_flow_0.png)


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
* [Michael Dayan][Michael_Dayan]
* [Swapna Premasiri][Swapna_Premasiri]

## Authors

A list of contributors to the lesson can be found in [AUTHORS](AUTHORS)

## Citation

To cite this lesson, please consult with [CITATION](CITATION)

[lesson-example]: https://carpentries.github.io/lesson-example
[nikhil_bhagwat]: https://github.com/nikhil153
[erin_dickie]: https://github.com/edickie
[Michael_Dayan]: https://github.com/neurorepro
[Swapna_Premasiri]: https://github.com/devdinie
[neuro_cirriculum]: https://carpentries.org/community-lessons/#neuroimaging
