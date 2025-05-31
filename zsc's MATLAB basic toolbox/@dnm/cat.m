function ret=cat(dim,dnms)
	arguments(Input)
		dim{mustBeA(dim,["logical","double","char","string"])}
	end
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Output)
		ret dnm
	end
	if ischar(dim)
		dims=string(dim);
	end
	if islogical(dim)
		dim=find(dim);
	end
	assert(isscalar(dim),"One and only one dimension must be specified.")
	ret=fevalalong(@(varargin)cat(varargin{end},varargin{1:end-1}),dim,dnms{:},keepdims=true,broadcastsizedims="other");
end