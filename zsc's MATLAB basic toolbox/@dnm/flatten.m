function [ret,dim,sz]=flatten(self,dims,dim)
%FLATTEN	Flatten certain dimensions of dnm into one dimension.
%	[ret,dim,sz]=FLATTEN(self,dims,dim) returns the flattened array, the
%	flattened dimension name dim, the size of the original dimension for
%	later recovery of the flattened dimensions using unflatten.
%
%	See also unflatten
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["double","string","char","cell"])}=1:ndims(self)
		dim(1,:)string=missing
	end
	arguments(Output)
		ret dnm
		dim(1,:)string
		sz(1,:)double{mustBeInteger,mustBeNonnegative}
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
	if ismissing(dim)
		dim=catdims(dims);
	end
	zsc.assert(isscalar(dim),"DNM:flatten:multipledims","Can only flatten into one dimension.")
	other_dims=setdiff(self.dimnames,dims);
	sz=size(self,dims);
	ret=dnm(flatten(gather(self),index(self.dimnames,dims)),[dim,other_dims]);
end