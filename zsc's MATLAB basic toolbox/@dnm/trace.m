function ret=trace(self,dims)
	arguments
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
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
	self.dimnames(index(self.dimnames,dims))=dims(1);
	ret=sum(self,dims(1));
end