[SFDA,ATA] = main(gtFileString,trackFileString)
% This function returns the SFDA and ATA, for a given set of groundtruth
% and tracking results.
% INPUTS:
%   (1) gtFileString: a string specifying the groundtruth tracks file.
%   (2) trackFileString: a string specifying the tracking results file.
% NOTE:
%   The groundtruth and tracking results files must be in one of the forms
%   specified in the PACT user guide.
% NOTE:
%   Numbered types for  gtFileType and resultFileType:
%   gtFileType: 1 - ViPER; 2 - .csv
%   resultFileType: 1 - TIAM; 2 - .csv

    % Deduce file types
    if length(strfind(trackFileString,'.mat')) > 0 
        resultFileType = 1;
    else
        resultFileType = 2;
    end
    if length(strfind(gtFileString,'.txt')) > 0 
        gtFileType = 1;
    else
        gtFileType = 2;
    end

    % make gtcell
    if gtFileType==1
        gtcell = parseViperFile(gtFileString)
    else
        gtcell = parseCsv(gtFileString);
    end

    % make resultcell
    if resultFileType==1
        load(trackFileString,'datacell');
        resultcell = dc2rc(datacell);
    else
        resultcell = parseCsv(trackFileString);
    end

    % compute SFDA and ATA
    SFDA = pm_sfda(resultcell, gtcell, 1, numframes) % compute sfda
    ATA = pm_ata(resultcell, gtcell) % compute ata

    % Aux functions
    function outcell = parseCsv(csvFileString)
        csvmat = csvread(csvFileString);
        zeroind = find(sum(csvmat(:,2:end),2)==0); zeroind(end+1) = size(csvmat,1)+1;
        outcell = {};
        for i=2:length(zeroind)
            outcell{end+1} = csvmat(zeroind(i-1)+1:zeroind(i)-1,:); 
            startframe = outcell{end}(1,1); endframe = outcell{end}(end,1);
            outcell{end}(:,1) = [];
            outcell{end} = [repmat([startframe,endframe],size(outcell{end},1),1),outcell{end}];
        end
        outcell = fixbbox(outcell); 
    end

    function groundcell = parseViperFile(viperFileString)
        if resultFileType>1
            groundcell = gt2gtcell(viperFileString);
        else
            groundcell = gt2gtcell(viperFileString); 
            groundcell = shiftGtCell(groundcell,-100);
            groundcell = removeExtraGtFrames(groundcell,[13,38]);
            groundcell = fixbbox(groundcell);
        end
    end

    function celly = shiftGtCell(celly, shiftAmount)
        for cp = 1 : length(celly)
            celly{cp}(:,1) = celly{cp}(:,1) + shiftAmount;
            celly{cp}(:,2) = celly{cp}(:,2) + shiftAmount;
        end
    end

    function rc = dc2rc(dc)
        for i = 1 : length(dc)
            socell = cell(1,4); sorcell = {}; sorrcell = {}; bw = 25;
            rc{i} = dc{i}(:,1:4); rc{i}(:,3) = rc{i}(:,3) - (bw/2);
            rc{i}(:,4) = rc{i}(:,4) - (bw/2); rc{i}(:,5:6) = bw;
        end
    end

    function newcell = fixbbox(oldcell)
        fixval = 25;
        for j=1:length(oldcell)
            newcell{j} = oldcell{j};
            newcell{j}(:,5:6) = fixval;
        end
    end
end
