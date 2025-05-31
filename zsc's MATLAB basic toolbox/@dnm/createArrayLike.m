function ret=createArrayLike(L,dims,F,dimnames)
%DNM.CREATEARRAY	Add support for createArray(...,"dnm",...).
%	If one want to create <=2 dim array, call the reloaded
%	DNM.CREATEARRAY(dims,F,dimnames) to create an array with size dims,
%	dimension names dimnames and fill value F. Do not use
%	createArray(...), otherwise it will return wrong output.
%
%	See also dnm/zeros, dnm/eye, dnm/rand, dnm/false, dnm/nan.
	arguments(Input)
		L dnm
		dims(1,:){mustBeInteger,mustBeNonnegative}
		F=0
		dimnames="x"+string(1:numel(dims))
	end
	arguments(Output)
		ret dnm
	end
	ret=dnm(createArray(paddata(dims,2,"fillvalue",1),"fillvalue",F,"like",L.value),dimnames);
end