function ret=ifht(x,dims)
%IFHT	Inverse Discrete Hartley transform.
%	IFHT(f,dims) applies the inverse discrete Hartley transform across list
%	of dimensions dims.
%
%	See also fht, ifft, ifftn.

%	Copyright 2024 Chris H. Zhao
	arguments
		x{mustBeNumericOrLogical}
		dims(1,:){mustBePositive,mustBeInteger}=1:ndims(x)
	end
	fht_plus=x;
	fht_minus=fht_plus;
	for d=dims
		ind1=[repmat({':'},d-1),{2:size(x,d)},repmat({':'},ndims(x)-d)];
		ind2=[repmat({':'},d-1),{size(x,d):-1:2},repmat({':'},ndims(x)-d)];
		fht_minus(ind1{:})=fht_minus(ind2{:});
	end
	ret=(fht_plus*(1-1i)+fht_minus*(1+1i))/2;
	for d=dims
		ret=ifft(ret,[],d);
	end
	if isreal(x)
		ret=real(ret);
	end
end