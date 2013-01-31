
function getBenchmarkResults_imaris()


% for each imaris file: load imaris file, convert to datacell, crop datacell, load corresponding groundtruth, convert to resultcell, get sfda and ata

% intended to be run on the cluster


% add func to path
addpath(genpath('/hpc/stats/users/wdn2101/tcell/func'));

% experiment 1
resultcell = parseImarisResults('csvFiles/control_2o2i_2minOnwards.csv');
resultcell = cropResultcell(resultcell, 1, 58);
resultcell = addBboxToResultCell(resultcell, 25);
resultcell = convertImarisUnitsToPixel(resultcell);
gtcell = gt2gtcell('../data/benchmark/control_2o_2i_071711/gt/control_2o2i_2minOnwards-mpeg.txt'); % path to gt .txt file on cluster
gtcell = shiftGtCell(gtcell, -100);
disp('finished set up for exp 1');
pm(1,1) = pm_sfda(resultcell, gtcell, 1, 58, ''); % compute sfda
disp('finished sfda for exp 1');
pm(1,2) = pm_ata(resultcell, gtcell, ''); % compute ata
disp('finished ata for exp 1');
save('pm_imaris_ws');

% experiment 2
resultcell = parseImarisResults('csvFiles/well1_RaRoMix_3minOnwards.csv');
resultcell = cropResultcell(resultcell, 1, 20);
resultcell = addBboxToResultCell(resultcell, 25);
resultcell = convertImarisUnitsToPixel(resultcell);
gtcell = gt2gtcell('../data/benchmark/well1_raromix_041611/gt/well1_RaRoMix_3minOnwards-mpeg.txt'); % path to gt .txt file on cluster
gtcell = shiftGtCell(gtcell, -100);
disp('finished set up for exp 2');
pm(2,1) = pm_sfda(resultcell, gtcell, 1, 20, ''); % compute sfda
disp('finished sfda for exp 2');
pm(2,2) = pm_ata(resultcell, gtcell, ''); % compute ata
disp('finished ata for exp 2');
save('pm_imaris_ws');

% experiment 3
resultcell = parseImarisResults('csvFiles/well6_nve_blastD6_3minOnwards.csv');
resultcell = cropResultcell(resultcell, 1, 20);
resultcell = addBboxToResultCell(resultcell, 25);
resultcell = convertImarisUnitsToPixel(resultcell);
gtcell = gt2gtcell('../data/benchmark/well6_082511/gt/well6_nve_blastD6_3minOnwards-mpeg.txt'); % path to gt .txt file on cluster
gtcell = shiftGtCell(gtcell, -100);
disp('finished set up for exp 3');
pm(3,1) = pm_sfda(resultcell, gtcell, 1, 20, ''); % compute sfda
disp('finished sfda for exp 3');
pm(3,2) = pm_ata(resultcell, gtcell, ''); % compute ata
disp('finished ata for exp 3');
save('pm_imaris_ws');

% experiment 4
% resultcell = parseImarisResults('csvFiles/fc12_ccl21only_3minOnwardsBottomRight.csv');
% resultcell = cropResultcell(resultcell, 1, 58);
% resultcell = addBboxToResultCell(resultcell, 25);
% resultcell = convertImarisUnitsToPixel(resultcell);
% gtcell = gt2gtcell('../data/benchmark/fc12_101411/gt/fc12_ccl21only_3minOnwards-mpeg.txt'); % path to gt .txt file on cluster
% gtcell = shiftGtCell(gtcell, -100);
% disp('finished set up for exp 4');
% pm(1,1) = pm_sfda(resultcell, gtcell, 1, 58, ''); % compute sfda
% disp('finished sfda for exp 4');
% pm(1,2) = pm_ata(resultcell, gtcell, ''); % compute ata
% disp('finished ata for exp 4');
% save('pm_imaris_ws');
% pm(4,1) = 0.062; % placeholder
% pm(4,2) = 0.015; % placeholder

% experiment 5
resultcell = parseImarisResults('csvFiles/fc2_ccl21_icam1_3minOnwardsLeftTop.csv');
resultcell = cropResultcell(resultcell, 1, 20);
resultcell = addBboxToResultCell(resultcell, 25);
resultcell = convertImarisUnitsToPixel(resultcell);
gtcell = gt2gtcell('../data/benchmark/fc2_091611/gt/fc2_ccl21_icam1_3minOnwards-mpeg.txt'); % path to gt .txt file on cluster
gtcell = shiftGtCell(gtcell, -100);
disp('finished set up for exp 5');
pm(5,1) = pm_sfda(resultcell, gtcell, 1, 20, ''); % compute sfda
disp('finished sfda for exp 5');
pm(5,2) = pm_ata(resultcell, gtcell, ''); % compute ata
disp('finished ata for exp 5');
save('pm_imaris_ws');

% save workspace
save('pm_imaris_ws');