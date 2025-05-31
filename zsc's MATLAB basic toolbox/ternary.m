function output=ternary(choice,input1,input2)
%TERNARY	Ternary expression (vectorized).
%	output=TERNARY(choice,input1,input2) is vectorized version of ifinline.
%
%	If one does not want the other input to be evaluated (causing error),
%	use ifinline.
%
%	See also ifinline, arrayfun.

%	Copyright 2024–2025 Chris H. Zhao
	arguments
		choice logical
		input1
		input2
	end
	maxdim=max([ndims(choice),ndims(input1),ndims(input2)]);
	input1=repmat(input1,fillmissing(size(choice,1:maxdim)./size(input1,1:maxdim),constant=1));
	input2=repmat(input2,fillmissing(size(choice,1:maxdim)./size(input2,1:maxdim),constant=1));
	output=input2;
	output(choice)=input1(choice);
end