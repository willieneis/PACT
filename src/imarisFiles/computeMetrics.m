[SFDA,ATA] = computeMetrics()
% This function computes metrics for an example result
% and groundtruth.

    % conversion units
    sizeConvertCoef = 0.439; % umPerPix
    timeConvertCoef = 33.3; % secPerFrame

    % number of frames
    numframes = 56; % framesPerVideo
    
    % load results and groundtruth
    load('~/proj/TIAM/data/benchmarkData/exp1_control/results_tcmat/exp1_control_results.mat','datacell');
    gtcell = gt2gtcell('~/proj/TIAM/data/benchmarkData/exp1_control/gt/control_2o2i_2minOnwards.txt');

    % make datacell_pixelConvert, which is datacell with pixel units (for association with groundtruth)
    datacell_pixelConvert = convertUnitsToPixel(datacell,sizeConvertCoef);

    % adjust gtcell (shift 100 frames, remove extra frames)
    gtcell = shiftGtCell(gtcell,-100);
    gtcell = removeExtraGtFrames(gtcell,[13,38]);

    % convert groundtruth to datacell_gt (convert units, add speed)
    datacell_gt = gtcell2datacell(gtcell);
    datacell_gt = convertPixelToUnits(datacell_gt,sizeConvertCoef);
    datacell_gt = get_speed_new(datacell_gt);
    for t=1:length(datacell_gt)
        datacell_gt{t}(:,9:12) = datacell_gt{t}(:,9:12)*60 / timeConvertCoef;
    end

    % make resultcell from datacell_pixelConvert
    resultcell = datacell2resultcell(datacell_pixelConvert);

    % computer SFDA and ATA
    pm(whichExp,1) = pm_sfda(resultcell, gtcell, 1, numframes) % compute sfda
    pm(whichExp,2) = pm_ata(resultcell, gtcell) % compute ata
    fprintf('finished exp %d\n',whichExp)

    % get per-celltrack-metrics for each experiment
    for whichExp=1:5
        % load resultcell and gtcell
        if whichExp==1
        elseif whichExp==2
            load('~/proj/TIAM/data/benchmarkData/exp2_raromix/results_tcmat/exp2_raromix_results.mat','datacell');
            gtcell = gt2gtcell('~/proj/TIAM/data/benchmarkData/exp2_raromix/gt/well1_RaRoMix_3minOnwards.txt');
        elseif whichExp==3
            load('~/proj/TIAM/data/benchmarkData/exp3_well6/results_tcmat/exp3_well6_results.mat','datacell');
            gtcell = gt2gtcell('~/proj/TIAM/data/benchmarkData/exp3_well6/gt/well6_nve_blastD6_3minOnwards.txt');
        elseif whichExp==4
            load('~/proj/TIAM/data/benchmarkData/exp4_fc12/results_tcmat/exp4_fc12_results.mat','datacell');
            gtcell = gt2gtcell('~/proj/TIAM/data/benchmarkData/exp4_fc12/gt/fc12_ccl21only_3minOnwards.txt');
        elseif whichExp==5
            load('~/proj/TIAM/data/benchmarkData/exp5_fc2/results_tcmat/exp5_fc2_results.mat','datacell');
            gtcell = gt2gtcell('~/proj/TIAM/data/benchmarkData/exp5_fc2/gt/fc2_ccl21_icam1_3minOnwards.txt');
        end

        % make datacell_pixelConvert, which is datacell with pixel units (for association with groundtruth)
        datacell_pixelConvert = convertUnitsToPixel(datacell,sizeConvertCoef);

        % adjust gtcell (shift 100 frames, remove extra frames)
        gtcell = shiftGtCell(gtcell,-100);
        gtcell = removeExtraGtFrames(gtcell,[13,38]);

    end

    disp('Performance metrics (SFDA and ATA) for all experiments:');
    disp(pm);

    % write pm to file
    csvwrite('performanceMetrics_tcmat_new.csv',pm);
