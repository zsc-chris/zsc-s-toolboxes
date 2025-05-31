function ret=num2cell(self,dims)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["double","string","char","cell"])}=[]
	end
	arguments(Output)
		ret dnm
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=string(dims);
	end
	if isstring(dims)
		dims=index(self.dimnames,dims);
	end
	ret=self;
	dim_in=self.dimnames;
	dim_in(~ismember(1:numel(dim_in),dims))=missing;
	ret.value=cellfun(@(x)dnm(x,dim_in),zsc.num2cell(self.value,dims),"uniformoutput",false);
	ret=squeeze(ret,self.dimnames(dims));
end