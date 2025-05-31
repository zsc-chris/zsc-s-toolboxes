function [ret,dims]=unflatten(self,dim,sz,dims)
%UNFLATTEN	Unflatten certain dimension of dnm into multiple dimension.
%	[ret,dims]=UNFLATTEN(self,dim,sz,dims) returns the unflattened array,
%	the unflattened dimension names dims.
%
%	See also flatten
	arguments(Input)
		self dnm
		dim(1,:){mustBeA(dim,["logical","double","string","char","cell"])}=find(contains(self.dimnames,"×"),1)
		sz(1,:)double=[]
		dims(1,:)string=[]
	end
	arguments(Output)
		ret dnm
		dims(1,:)string
	end
	if islogical(dim)
		dim=find(dim);
	end
	if isnumeric(dim)
		dim=string(arrayfun(@(x)ifinline(x<=ndims(self),@()self.dimnames(x),@()"x"+string(x)),dim));
	end
	if ischar(dim)||iscellstr(dim)||isstring(dim)
		dim=string(dim);
	end
	if isempty(dim)
		ret=self;
		return
	end
	zsc.assert(isscalar(dim),"DNM:unflatten:multipledims","One and only one dimension may be unflattened at a time.")
	if isempty(sz)
		sz=paddata(size(self,dim),count(dim,regexpPattern("(?<!×)×(?!×)"))+1,"fillvalue",1);
	end
	if isempty(dims)
		dims=splitdim(dim,numel(sz));
	end
	other_dims=setdiff(self.dimnames,dim);
	ret=dnm(reshape(permute(self,[other_dims,dim]),paddata([size(self,other_dims),sz],2,"fillvalue",1)),[other_dims,dims]);
end