function ret=repelem(self,r)
%REPELEM Replicate elements of an array.
%	ret=repelem(self,[*r|**r])
%
%	Note: Original repelem does not support 2 argument syntax for matrix
%	input, but this repelem will assign the second argument to the first
%	dimension in case of 2 argument syntax. To specify argument for each
%	dimension, use name-value syntax.
%
%	See also repelem, dnm/repmat
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		r(1,:)
	end
	r=parsedimargs(self.dimnames,r,false);
	zsc.assert(isempty(r)||isequal(sort(zsc.cell2mat(r(1,:))),unique(zsc.cell2mat(r(1,:)))),"DNM:RepeatedDimension","Repeated dimension not allowed.")
	if isempty(r)
		ret=self;
		return
	end
	self.dimnames(index(self.dimnames,zsc.cell2mat(r(1,:))))=zsc.cell2mat(r(1,:));
	dict=dictionary(zsc.cell2mat(r(1,:)),r(2,:));
	r=paddata(lookup(dict,self.dimnames,"fallbackvalue",{1}),2,"fillvalue",{1});
	ret=dnm(repelem(self.value,r{:}),self.dimnames);
end