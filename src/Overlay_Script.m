%Tell matlab where to find the relevant functions
scriptDir = pwd;
addpath(scriptDir);


%Set the paths to all experimental spectra here. Note using absolute paths
%is likely safest
exptSpectraPaths = containers.Map();
exptSpectraPaths('OMIM_Cl') = fullfile('test_files','omim_cl_test','Experimental_1486eV.txt');
exptSpectraPaths('BMIM_NCN2') = fullfile('test_files', 'ncn2_test', 'xmim_ncn2_exp_spectrum.txt');

%This part is to align OMIM_Cl calculated with expt. 
calculatedPath = fullfile('test_files','omim_cl_test','OMIM_Cl_1486pt6eV.txt');
saveFolder = fullfile('test_files','omim_cl_output'); %Currently the folder needs to exist or an error will occur
saveOn = 1; %1 means save plots created, anything else means dont
exptXRange = [-inf,inf];
calcXRange = [-inf,inf];
outObj = align_calc_vs_one_expt_from_paths(calculatedPath, exptSpectraPaths('OMIM_Cl'), exptXRange, calcXRange);
create_plots_for_aligned_spectra(outObj, saveOn, saveFolder);

%This part aligns the BMIM_NCN2 to expt (only anion contribution included)
calculatedPath = fullfile('test_files','ncn2_test','ncn2_anion_calc_contrib.txt');
saveFolder = fullfile('test_files','xmim_ncn2_output');
saveOn = 1; %1 means save plots created, anything else means dont
exptXRange = [-2,5];
calcXRange = [4,8];
outObj = align_calc_vs_one_expt_from_paths(calculatedPath, exptSpectraPaths('BMIM_NCN2'), exptXRange, calcXRange);
create_plots_for_aligned_spectra(outObj, saveOn, saveFolder);

  %cleanup
  rmpath(scriptDir);


