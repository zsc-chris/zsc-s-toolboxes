function B=subsref(A,S)
%zsc.subsref	Improved version of MATLAB SUBSREF.
%	*B=zsc.subsref(A,S) can tolerate when S is empty.
	arguments(Input)
		A
		S(1,:)struct
	end
	arguments(Output,Repeating)
		B
	end
	nargout_=max(nargout,1);
	if isempty(S)
		B={A};
	else
		[B{1:nargout_}]=subsref(A,S);
	end
end