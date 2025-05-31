function ret=ctranspose(self,dims,finalize)
%CTRANSPOSE	Swap two dimensions' name of dnm and conjugate.
%	ret=CTRANSPOSE(self,dims,finalize) takes the conjugate of transpose
%	output if conj is available.
%	Normally you don't need to do this. This is reserved for forwarding
%	this to next step of calculation.
%
%	See also ctranspose, dnm/permute, dnm/transpose
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=[1,2]
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	if ismethod(underlyingType(self),"conj")
		self=conj(self);
	end
	ret=transpose(self,dims,finalize);
end