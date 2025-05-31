function ret=permute(self,dims,finalize)
%PERMUTE	Permute dimensions' names of dnm.
%	ret=PERMUTE(self,dims,finalize) returns a permuted dnm where the
%	dimensions are permuted to the new dims. The value will be returned if
%	finalize is true, which allows one to directly feed the output to
%	function that only accepts a certain sequence of dimension in input.
%	Normally you don't need to do this. This is reserved for forwarding
%	this to next step of calculation.
%
%	See also permute, dnm/ipermute

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	if islogical(dims)
		dims=find(dims);
	end
	if isnumeric(dims)
		dims=string(arrayfun(@(x)ifinline(x<=ndims(self),@()self.dimnames(x),@()"x"+string(x)),dims));
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=string(dims);
	end
	dims=dims(~ismissing(dims));
	zsc.assert(all(ismember(self.dimnames,dims)),message("MATLAB:permute:tooFewIndices"))
	zsc.assert(isequaln(sort(dims),unique(dims)),message("MATLAB:permute:repeatedIndex"))
	zsc.assert(isequal(sort(index(self.dimnames,dims)),1:numel(dims)),message("MATLAB:permute:badIndex"));
	out=outclass;
	ret=dnm(zsc.permute(self.value,index(self.dimnames,dims)),dims(out{2,2,@sort,index(self.dimnames,dims)}));
	if finalize
		ret=gather(ret);
	end
end