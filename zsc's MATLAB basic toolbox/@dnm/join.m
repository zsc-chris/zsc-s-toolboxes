function ret=join(self,delimiter,dims)
%	Note: Since delimiter is string, name-value arguments won't work here.
	arguments(Input)
		self dnm
		delimiter(1,:)string
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Output)
		ret dnm
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=string(dims);
	end
	if islogical(dims)
		dims=find(dims);
	end
	if isstring(dims)
		dims=index(self.dimnames,dims);
	end
	if isscalar(delimiter)
		delimiter=repmat(delimiter,[1,numel(dims)]);
	end
	ret=self.applyalong(@(x,dim)join(x,delimiter(dims==dim),dim),dims,mode="iterate");
end