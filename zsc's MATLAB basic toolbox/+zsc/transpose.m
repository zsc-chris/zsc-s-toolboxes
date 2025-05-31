function B=transpose(A,dim)
%zsc.transpose Improved version of MATLAB TRANSPOSE.
%	B=zsc.transpose(A,dim) transposes two dimensions of a matrix.
%
%	See also transpose.
%
%	This function can safely replace the builtin one.

%	Copyright 2024 Chris H. Zhao
	arguments
		A
		dim(1,2)double{mustBePositive,mustBeInteger}=1:2
	end
	dims=1:max(ndims(A),max(dim));
	tmp=dims(dim(1));
	dims(dim(1))=dims(dim(2));
	dims(dim(2))=tmp;
	B=zsc.permute(A,dims);
end