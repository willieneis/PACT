
function resultcell2 = cropResultcell(resultcell, startframe, endframe)


% crop resultcell as if the video started at frame <startframe> and ended at frame <endframe>
% this means: resultcell{cp}(:,1:2)  (the start and end frames) will change to somewhere in between startframe and endframe (is this what i want?)



% resultcell2 is the new resultcell we will construct
resultcell2 = {};

% loop through each path in the original resultcell
for cp = 1 : length(resultcell)
	mat = [];
	% only consider cellpaths within the desired frame range
	if resultcell{cp}(1,1) <= endframe  &&  resultcell{cp}(1,2) >= startframe

		% temp contains indices of cellpath to access that are within desired time range
		temp0 = resultcell{cp}(:,1) + [0:length(resultcell{cp}(:,1))-1]';  % each entry in temp0 now contains the frame that the row corresponds to.
		temp1 = find(temp0 >= startframe);
		temp2 = find(temp0 <= endframe);
		temp = intersect(temp1, temp2);

		mat = resultcell{cp}(temp,:);
		% the following adjusts the startframe and endframe as if video started and ended at these two positions
		mat(:,1) = temp0(temp(1)) - startframe + 1;	% adjust startframe (temp0(temp(1)) is first kept frame)
		mat(:,2) = mat(1,1) + length(temp) - 1;	% adjust endframe

		% place mat as next entry in resultcell2
		resultcell2{end+1} = mat;
	end
end