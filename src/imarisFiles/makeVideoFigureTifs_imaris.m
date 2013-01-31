
function makeVideoFigureTifs_imaris(whichExp)

% overlays gt bbox and result bbox for given exp (whichExp) and saves as tif.
% run from tcmat directory


% load in datacell (tcmat result), videocell (tif imgs), and gtcell for given experiment
if whichExp==1
    resultcell = parseResults_imaris('data/benchmarkData/exp1_control/results_imaris/exp1_control.csv');
    resultcell = convertUnitsToPixel(resultcell,0.439);
	videocell = imgfolder2videocell('data/benchmarkData/exp1_control/img_dic_tif');
	gtcell = gt2gtcell('data/benchmarkData/exp1_control/gt/control_2o2i_2minOnwards.txt');
elseif whichExp==2
    resultcell = parseResults_imaris('data/benchmarkData/exp2_raromix/results_imaris/exp2_raromix.csv');
    resultcell = convertUnitsToPixel(resultcell,0.439);
	videocell = imgfolder2videocell('data/benchmarkData/exp2_raromix/img_dic_tif');
	gtcell = gt2gtcell('data/benchmarkData/exp2_raromix/gt/well1_RaRoMix_3minOnwards.txt');
elseif whichExp==3
    resultcell = parseResults_imaris('data/benchmarkData/exp3_well6/results_imaris/exp3_well6.csv');
    resultcell = convertUnitsToPixel(resultcell,0.439);
	videocell = imgfolder2videocell('data/benchmarkData/exp3_well6/img_dic_tif');
	gtcell = gt2gtcell('data/benchmarkData/exp3_well6/gt/well6_nve_blastD6_3minOnwards.txt');
elseif whichExp==4
    resultcell = parseResults_imaris('data/benchmarkData/exp4_fc12/results_imaris/exp4_fc12.csv');
    resultcell = convertUnitsToPixel(resultcell,0.664);
	videocell = imgfolder2videocell('data/benchmarkData/exp4_fc12/img_dic_tif');
	gtcell = gt2gtcell('data/benchmarkData/exp4_fc12/gt/fc12_ccl21only_3minOnwards.txt');
elseif whichExp==5
    resultcell = parseResults_imaris('data/benchmarkData/exp5_fc2/results_imaris/exp5_fc2.csv');
    resultcell = convertUnitsToPixel(resultcell,0.664);
	videocell = imgfolder2videocell('data/benchmarkData/exp5_fc2/img_dic_tif');
	gtcell = gt2gtcell('data/benchmarkData/exp5_fc2/gt/fc2_ccl21_icam1_3minOnwards.txt');
end

% adjust gtcell (shift 100 frames, remove extra frames)
gtcell = shiftGtCell(gtcell,-100);
gtcell = removeExtraGtFrames(gtcell,[13,38]);

% one keep a quarter of the frame in exp 4 and 5
if whichExp==4
	resultcell = fourframes2oneframe(resultcell,4); %%%% need to finish / fix
	videocell = cropVideoCell(videocell,4);
elseif whichExp==5
	resultcell = fourframes2oneframe(resultcell,2);
	videocell = cropVideoCell(videocell,2);
end

% make figure and save as tif for each frame
for i=1:length(videocell)
	viz_gt_result_frameOverlay(gtcell,resultcell,videocell{i},i)
	xlim([0,512])
	ylim([0,512])
	pause
    mkdir imgOutput
    if i<10
        savestring = ['0',num2str(i)];
    else
        savestring = num2str(i);
    end
    %saveas(gcf,'imgOutput/savestring')
	clf
end
