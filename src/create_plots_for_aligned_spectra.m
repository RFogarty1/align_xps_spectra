function create_plots_for_aligned_spectra(alignedObj, saveOn, saveFolder)

    %Step 1 = get smoothed vs unsmoothed expt
    rawSpectrum  = alignedObj.refData;
    smoothedSpectrum = alignedObj.smoothedRef;
    figSmoothedVsNot = make_plot_two_xps_data_series ( rawSpectrum, smoothedSpectrum, "Raw", "Smoothed");
    
    %Step 2 = get unAligned spectra
    rawCalc = alignedObj.unshiftedOthers{1};
    figExptCalcUnAligned = make_plot_two_xps_data_series(rawSpectrum, rawCalc, "Expt", "Calc (UnAligned)");
    
    %Step 3 = get aligned spectra
    alignedCalc = alignedObj.shiftedOthers{1};
    figExptCalcAligned = make_plot_two_xps_data_series(rawSpectrum, alignedCalc, "Expt", "Calc (Aligned)");
    currTitle = sprintf('shift= %f, normFactor =%f',  alignedObj.shiftVals(1), alignedObj.normVals(1) );
    title({         currTitle            });

    %Step 4 = save the files if requested
    if saveOn==1
        %Smoothed vs not
        saveas(figSmoothedVsNot, fullfile(saveFolder,'SmoothedVsUnSmooth.jpeg'), 'jpeg');
        saveas(figSmoothedVsNot, fullfile(saveFolder,'SmoothedVsUnSmooth.fig'), 'fig');
        writeTwoDataSetsToTextFile(  fullfile(saveFolder,'SmoothedVsUnSmooth.csv'), rawSpectrum, smoothedSpectrum,'raw', 'smoothed');

        %Unaligned (But normalised to peak)
          saveas(figExptCalcUnAligned, fullfile(saveFolder,'ExptVsCalcUnAligned.jpeg'), 'jpeg');
          saveas(figExptCalcUnAligned, fullfile(saveFolder, 'ExptVsCalcUnAligned.fig'), 'fig');
           writeTwoDataSetsToTextFile(  fullfile(saveFolder,'ExptVsCalcUnAligned.csv'), rawSpectrum, rawCalc,'raw', 'smoothed');

          %Aligned
          saveas(figExptCalcAligned, fullfile(saveFolder, 'ExptVsCalcAligned.jpeg'), 'jpeg');
          saveas(figExptCalcAligned, fullfile(saveFolder, 'ExptVsCalcAligned.fig'), 'fig');
           writeTwoDataSetsToTextFile(  fullfile(saveFolder,'ExptVsCalcAligned.csv'), rawSpectrum, alignedCalc,'raw', 'smoothed');
          
    end
    
    
end


function [] = writeTwoDataSetsToTextFile(filePath, dSetA, dSetB, nameA, nameB)

    rowsA = size(dSetA,1);
    rowsB = size(dSetB,1);

    headerStr = sprintf("%s,,%s\n",nameA, nameB);
    fid = fopen(filePath,'wt');
    fprintf(fid,headerStr);
    for i=1:max(rowsA,rowsB)
        if i <= min(rowsA,rowsB)
            fprintf(fid, '%f, %f, %f, %f\n',  dSetA(i,1), dSetA(i,2),  dSetB(i,1), dSetB(i,2)   );
        elseif i>rowsA
            fprintf(fid, 'NaN, NaN, %f, %f\n', dSetB(i,1), dSetB(i,2) );
          else
            fprintf(fid, '%f, %f, NaN, NaN\n', dSetA(i,1), dSetA(i,2) );
        end
    end
    fclose(fid);
end


function [figA] = make_plot_two_xps_data_series(dataA,dataB, labelA, labelB)

    figA = figure;
    ax1 = axes('Parent',figA);
    hold all
    
    plot(dataA(:,1),dataA(:,2));
    plot(dataB(:,1),dataB(:,2));
    
    xlabel({'Binding Energy / eV'});
    ylabel({'Intensity'});
    set(ax1, 'xdir', 'reverse');
    legend({labelA,labelB});
    
end
