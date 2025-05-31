function ret=transpose(self,dims,finalize)
%TRANSPOSE	Swap two dimensions' name of dnm.
%	ret=TRANSPOSE(self,dims,finalize) is a special case of permute where
%	only two dimensions are swapped.
%	Normally you don't need to do this. This is reserved for forwarding
%	this to next step of calculation.
%
%	See also transpose, dnm/permute, dnm/ctranspose
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=[1,2]
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
	self.dimnames=[self.dimnames,setdiff(dims,self.dimnames)];
	new_dims=self.dimnames;
	new_dims(index(self.dimnames,dims))=new_dims(flip(index(self.dimnames,dims)));
	ret=permute(self,new_dims,finalize);
end