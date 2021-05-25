---
title: Setup
---
## Setting up the tutorial environment

## Getting workshop material

### Method 1: Downloading directly from the repository

On the GitHub repo (this page), click the green button that says "Clone or download", then click **Download ZIP**. Once downloaded, extract the ZIP file.

### Method 2: Using Git

Using this method requires a (very) useful piece of software called <code>git</code>. The process of installing git depends heavily on whether you're using MacOS, Windows or Linux. Follow the instructions in the link below to set up <code>git</code> on your PC:

[Installing Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Once you've installed <code>git</code>, open up your terminal and do the following:

```
git clone https://github.com/carpentries-incubator/SDC-BIDS-sMRI.git
```

This will download the repository directly into your current directory.

### Setting up Python environment
We use python version 3.6.0, but any newer version should also work (Python 2 versions haven't been tested). There are many methods to setting up a python environment but we'd recommend using some sort of virtual environment as to not break your system python install. Two methods (of many) are listed below:

### Method 1: Setting up conda environment (easiest) [Windows, Linux, MacOS]
For easy set-up we recommend [Anaconda](https://www.anaconda.com/download/) to manage python packages for scientific computing. Once installed, setting up the python environment can be done quite easily:

#### Windows
1. Install Anaconda Python version 3.7
2. Open **Anaconda Navigator**
3. Click on **Environments** on the left pane
4. Click **Create** then type in <code>SDC-BIDS-sMRI</code>
5. In the <code>SDC-BIDS-sMRI</code> entry click the play button then click **Open Terminal**
6. In terminal type:

```
conda install -y numpy pandas scipy scikit-learn matplotlib jupyter ipykernel nb_conda
conda install -y -c conda-forge awscli
pip install nilearn nibabel
```
7. Close the terminal, click on the play button again and open **Jupyter Notebook**
8. Navigate to <code>SDC-BIDS-sMRI</code> folder you downloaded earlier.
9. Done!

#### Linux and MacOS

After installing Anaconda, open terminal and type:

```
cd SDC-BIDS-sMRI
conda create -p ./SDC_sMRI_workshop_2021
source activate $(pwd)/SDC_sMRI_workshop_2021
conda install numpy pandas scipy scikit-learn matplotlib jupyter ipykernel nb_conda
conda install -c conda-forge awscli
pip install nilearn nibabel
```

### Method 2: Using pyenv [Linux, MacOS]
An alternative method uses [pyenv](https://github.com/pyenv/pyenv) with [pyenv virtualenv](https://github.com/pyenv/pyenv-virtualenv). This is a favourite because it seamlessly integrates multiple python versions and environments into your system while maintaining use of pip (instead of conda).

```
cd SDC-BIDS-sMRI
pyenv virtualenv 3.6.0 SDC_sMRI_workshop_2021
echo SDC_sMRI_workshop_2021 > .python-version
pip install --requirement requirements.txt
```

## Acquiring the data
Most data (small files) needed for notebook examples are in the ./local_data dir 

Finally open up the jupyter notebook to explore the tutorials:

```
cd SDC-BIDS-sMRI

#Include below line if using anaconda environment
source activate $(pwd)/SDC_sMRI_workshop_2021

jupyter notebook
```

{% include links.md %}

