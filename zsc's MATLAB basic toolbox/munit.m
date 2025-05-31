function ret=munit(sz,ind,dtypes)
%MUNIT	Matrix unit/one-hot matrix
%	MUNIT(sz,ind)=(E_ind)_sz:=(δ_sz_ind)_sz
%
%	See also eye, zeros, ones

%	Copyright 2023 Chris H. Zhao
	arguments(Input)
		sz(1,:)
		ind(1,:)
	end
	arguments(Input,Repeating)
		dtypes
	end
	arguments(Output)
		ret{mustBeTrue(ret,"@(ret)nnz(ret)==1")}
	end
	ret=zeros(sz,dtypes{:});
	star=starclass;
	ret(star{ind,2})=1;
end