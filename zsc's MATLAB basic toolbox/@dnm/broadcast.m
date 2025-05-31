function ret=broadcast(self,sz)
	arguments(Input)
		self dnm
		sz{mustBeA(sz,["double","dnm","struct","dictionary"])}
	end
	arguments(Output)
		ret dnm
	end
	switch class(sz)
		case "double"
		case "dnm"
			sz=size(sz);
		case "struct"
			sz=arrayfun(@(x)sz.(self.dimnames(x)),1:ndims(self));
		case "dictionary"
			sz=arrayfun(@(x)sz(self.dimnames(x)),1:ndims(self));
	end
	assert(numel(sz)==ndims(self),"Cannot broadcast due to wrong ndims.")
	ret=self;
	ret.value=zsc.repmat(ret.value,fillmissing(sz./size(ret),"constant",1));
end