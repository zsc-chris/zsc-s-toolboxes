function ret=fht(x,dims)
%FHT	Discrete Hartley transform.
%	FHT(f,dims) applies the discrete Hartley transform (DHT) across list
%	of dimensions dims.
%
%	See also fft, fftn, ifht.

%	Copyright 2024 Chris H. Zhao
	arguments
		x{mustBeNumericOrLogical}
		dims(1,:){mustBePositive,mustBeInteger}=1:ndims(x)
	end
	fft_plus=x;
	for d=dims
		fft_plus=fft(fft_plus,[],d);
	end
	fft_minus=fft_plus;
	for d=dims
		ind1=[repmat({':'},d-1),{2:size(x,d)},repmat({':'},ndims(x)-d)];
		ind2=[repmat({':'},d-1),{size(x,d):-1:2},repmat({':'},ndims(x)-d)];
		fft_minus(ind1{:})=fft_minus(ind2{:});
	end
	ret=(fft_plus*(1+1i)+fft_minus*(1-1i))/2;
	if isreal(x)
		ret=real(ret);
	end
end