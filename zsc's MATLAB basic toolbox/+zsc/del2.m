function L=del2(U,h)
%zsc.del2	Improved version of MATLAB del2.
%	zsc.del2(U,*h)=del2(U,*h)*2*ndims(U).
%
%	See also del2

%	Copyright 2025 Chris H. Zhao
	arguments
		U
	end
	arguments(Repeating)
		h
	end
	L=del2(U,h{:})*2*ndims(U);
end