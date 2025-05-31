function B=ipermute(A,dimorder)
%zsc.ipermute	Improved version of MATLAB IPERMUTE.
%	B=zsc.ipermute(A,dimorder=[]) supports numel(dimorder)<2.
%
%	See also ipermute, zsc.permute

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		dimorder(1,:)double=[]
	end
	B=ipermute(A,[dimorder,numel(dimorder)+1:2]);
end