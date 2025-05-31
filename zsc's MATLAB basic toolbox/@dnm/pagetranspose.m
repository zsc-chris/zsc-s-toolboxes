function ret=pagetranspose(self,finalize)
%PAGETRANSPOSE	Swap the first two dimensions' name of dnm.
%	ret=PAGETRANSPOSE(self,finalize) is a special case of transpose where
%	the first two dimensions are swapped.
%
%	See also permute, transpose, pagectranspose
	arguments(Input)
		self dnm
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	ret=transpose(self,[1,2],finalize);
end