function ret=cell2mat(self,dims,finalize)
%cell2mat	Concatenate cell to array in certain dimensions.
%	A=zsc.cell2mat(C,dims,finalize) converts and concatenates cell C to A.
%
%	See also zsc.cell2mat

%	Copyright Chris H. Zhao 2025
	arguments(Input)
		self dnm{mustBeUnderlyingType(self,"cell")}
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
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
	self=cellfun(@dnm,self,"uniformoutput",false);
	ret=self.applyalong(@cell2mat_,dims,additionalinput={dims});
	if isequal(sort(dims),self.dimnames)&&finalize
		ret=ret.value{:};
	end
end
function self=cell2mat_(self,dims,dimnames)
	for i=1:numel(dimnames)
		self=num2cell(self,dims(i));
		self=cellfun(@(x)cat(dimnames(i),x{:}),self,"uniformoutput",false);
	end
end