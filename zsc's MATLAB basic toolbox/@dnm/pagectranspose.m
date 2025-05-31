function ret=pagectranspose(self,finalize)
%PAGECTRANSPOSE	Swap the first two dimensions' name of dnm and conjugate.
%	ret=PAGECTRANSPOSE(self,finalize) is a special case of ctranspose where
%	the first two dimensions are swapped.
%
%	See also permute, ctranspose, pagetranspose
	arguments(Input)
		self dnm
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	ret=ctranspose(self,[1,2],finalize);
end