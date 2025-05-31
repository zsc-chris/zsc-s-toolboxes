function mustBeSameSized(arrays)
	arguments(Input,Repeating)
		arrays
	end
	star=starclass;
    zsc.assert(isequal(star{cellfun(@size,arrays,"uniformoutput",false),2}{:}),"MATLAB:validators:mustBeSameSized","Inputs must have equal size.")
end