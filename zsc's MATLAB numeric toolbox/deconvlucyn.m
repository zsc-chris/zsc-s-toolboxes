function f=deconvlucyn(h,g,tol)
%deconvlucyn	nD Richardson-Lucy Deconvolution
%	Iteratively find f such that convn(f,g,"same")==h under the tolerance
%	tol with Richardson-Lucy algorithm.
%
%	See also deconvlucy

%   Copyright 2024 Chris H. Zhao
	arguments
		h double
		g double
		tol(1,1)=1e-4
	end
	f=ones(size(h))/2;
	while true
		fnext=f.*convn(h./convn(f,g,"same"),reshape(flip(g(:)),size(g)),"same");
		if max(abs(f-fnext))<tol
			break
		end
		f=fnext;
	end
	f=f/sum(g,"all");
end