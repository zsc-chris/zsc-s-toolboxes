function ret=squeeze(self,dims)
	arguments(Input)
		self dnm
		dims(1,:)=find(size(self)==1)
	end
	arguments(Output)
		ret dnm
	end
	if isempty(dims)
		ret=self;
		return
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=index(self.dimnames,string(dims));
	end
	sz=size(self);
	ind=setdiff(1:ndims(self),dims);
	ret=dnm(reshape(self.value,paddata(sz(ind),2,"fillvalue",1)),self.dimnames(ind));
end