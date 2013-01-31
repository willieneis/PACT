
function resultcell = addBboxToResultCell(resultcell, bboxWidth)


for cp = 1 : length(resultcell)
	resultcell{cp}(:,3) = resultcell{cp}(:,3) - bboxWidth/2;
	resultcell{cp}(:,4) = resultcell{cp}(:,4) - bboxWidth/2;
	resultcell{cp}(:,5) = bboxWidth;
	resultcell{cp}(:,6) = bboxWidth;
end