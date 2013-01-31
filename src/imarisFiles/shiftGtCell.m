
function gtcell = shiftGtCell(gtcell, shiftAmount)


% shiftAmount is positive for a positive shift and negative for a negative shift (i.e. we always do startframe/endframe + shiftAmount)


for cp = 1 : length(gtcell)

	gtcell{cp}(:,1) = gtcell{cp}(:,1) + shiftAmount;

	gtcell{cp}(:,2) = gtcell{cp}(:,2) + shiftAmount;

end