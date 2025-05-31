function ret=mat2cell(self,dimDist)
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		dimDist(1,:)
	end
	dimDist=parsedimargs(self.dimnames,dimDist,false);
	zsc.assert(isempty(dimDist)||all(arrayfun(@(x,y)sum(x{:})==y,dimDist(2,:),size(self,zsc.cell2mat(dimDist(1,:))))),message("MATLAB:mat2cell:VectorSumMismatch",size(dimDist,2),join(paddata(string(size(self,zsc.cell2mat(dimDist(1,:)))),1,fillvalue=""),"  ")))
	if isempty(dimDist)
		ret=dnm({self},self.dimnames);
		return
	end
	self.dimnames(index(self.dimnames,zsc.cell2mat(dimDist(1,:))))=zsc.cell2mat(dimDist(1,:));
	dict=dictionary(zsc.cell2mat(dimDist(1,:)),dimDist(2,:));
	r=arrayfun(@(x,y)lookup(dict,x,"fallbackvalue",{y}),self.dimnames,size(self));
	ret=dnm(cellfun(@(x)dnm(x,self.dimnames),mat2cell(self.value,r{:}),"uniformoutput",false),self.dimnames);
end