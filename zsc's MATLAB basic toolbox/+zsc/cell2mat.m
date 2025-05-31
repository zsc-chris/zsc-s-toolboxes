function A=cell2mat(C,dims,finalize)
%zsc.cell2mat	Improved version of MATLAB function cell2mat
%	A=zsc.cell2mat(C,dims,finalize) converts and concatenates cell C to A.
%	Unlike builtin cell2mat, this one supports objects like string, and
%	automatically broadcasts.

%	Copyright Chris H. Zhao 2025
	arguments(Input)
		C{mustBeUnderlyingType(C,"cell")}
		dims(:,:)double{mustBeTrue(dims,"@(dims)isequal(dims,[])||isrow(dims)&&all(dims>0)&&succeeds(@()mustBePositive(dims))")}=[]
		finalize(1,1)logical=true
	end
	arguments(Output)
		A
	end
	if isempty(dims)
		dims=1:ndims(C);
	end
	A=C;
	for dim=dims
		A=num2cell(A,dim);
		A=cellfun(@(x)zsc.cat(dim,x{:}),A,"uniformoutput",false);
	end
	if isequal(dims,1:ndims(C))&&finalize
		A=A{1};
	end
end