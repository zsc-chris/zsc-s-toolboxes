function B=permute(A,dimorder)
%zsc.permute	Improved version of MATLAB PERMUTE.
%	B=zsc.permute(A,dimorder=[]) supports numel(dimorder)<2.
%
%	See also permute, zsc.ipermute

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		dimorder(1,:)double=[]
	end
	B=permute(A,[dimorder,numel(dimorder)+1:2]);
end