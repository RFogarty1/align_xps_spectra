# Introduction
This code was originally written to aid comparison between calculated and experimental valence XPS spectra. There are two issues here: firstly, reference levels can vary between calculations and experiment (i.e. the meaning of 0 eV binding energy can differ); secondly, experimental intensities will invariably depend on factors not present in the calculations (e.g. the intensity of the light source). The code therefore takes a calculated spectrum and applies a uniform shift to x-values and a uniform scaling to y-values in order to match the energy/intensity of a peak in the experimental spectrum. 

# Getting Started
1) In matlab, go into the src/ folder and type "runtests", which should give the following output:
Totals:
   6 Passed, 0 Failed, 0 Incomplete.
If any tests fail let me know.
2) Open Overlay\_Script.m and press run. This should run the alignment for two cases (corresponding to 2 ionic liquids). Six graphs should be produced in total, 3 per test case.\
In each test case one graph shows the experimental vs a smoothed experimental; one graph shows experimental and other without an alignment shift and one shows the sepctra aligned (with the shift and 
normalisation values shown as an axis title).


# Running on your own data

## Input Format ##
The easiest input format to use is delimited text files with the first-column showing x-values and the second showing y-values. There can be at most one line at the top of the file 
which is not numeric data; in this case the rest of the data needs to be tab-delimited.

## Aliging from plain text files ##
In this case Overlay\_Script.m is essentially a template script for aligning spectra. Hopefully it should be obvious how to adapt this to your own data. 
Regardless, The steps to get this to work on your own data (once the input files are ready) are:

1) Set the scriptDir variable to the \*/src folder. This allows matlab to find the backend-functions that the script uses. Once this is done the script itself can be moved anywhere.
2) Change the line "exptSpectraPaths('OMIM\_Cl') = fullfile" such that OMIM\_Cl is replaced with a label for your expt data (any string is fine) and the right hand side contains
the full file path to your reference data.
3) Delete the exptSpectraPaths('BMIM\_NCN2') line
4) Delete everything (except rmpath(scriptDir)) below the comment "This part aligns the BMIM\_NCN2 to expt (only anion contribution included)"
5) Set the calculatedPath variable to a txt file containing your calcualted spectrum (or anything else you want to align with the reference spectrum)
6) Set saveFolder variable to a folder where you want to save all the output. The folder must already exist (i.e. the code wont create it for you)
7) On first run-through leave exptXRange and calcXRange at [-inf,inf]. This tells the code to look for the most intense peaks over both spectra and align based on that.
8) Press Run
9) If the aligned spectrum is what you wanted then your finished. The aligned spectrum will have used the most intense peaks for alignment; which may not be what you wanted. To align 
to a different peak set exptXRange to a region in the experimental/reference spectrum you want to align to and do the same for the calcXRange. Looking at the unaligned spectrum
should make it easy to find the correct windows.

