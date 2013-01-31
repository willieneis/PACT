
function resultcell2 = convertImarisUnitsToPixel2(resultcell)


% the imaris results are given in micrometer units. this function converts the results to pixel units.


% umPerPix is micrometers per pixel (the usual conversion listed in imageJ, I think)
umPerPix = 0.664;

for cp = 1 : length(resultcell)
	mat = resultcell{cp};
	mat(:,3) = mat(:,3) * (1/umPerPix);
	mat(:,4) = mat(:,4) * (1/umPerPix);
	resultcell2{cp} = mat;
end