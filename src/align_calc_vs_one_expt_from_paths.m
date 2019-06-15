function  [outObj] = align_calc_vs_one_expt_from_paths(calcPath, expPath, exptXRange, calcXRange)

    try
        exptData = dlmread( expPath );
    catch ME
        exptData = readExptFromIgorFormat(expPath);
    end
        
        
   calcData = { dlmread( calcPath ) };
   outObj = overlay_and_align_spectra(exptData, calcData, 'rangeXRef', exptXRange, 'rangeXOther', calcXRange);

end


function [outData] = readExptFromIgorFormat(inpPath)
    outData = dlmread(inpPath,"\t",1,0);
end
