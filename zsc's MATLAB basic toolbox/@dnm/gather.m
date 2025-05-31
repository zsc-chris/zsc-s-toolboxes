function varargout=gather(varargin)
%GATHER	getting the value of dnm (i.e. stripping the dnm adapter layer).
%	*arrays=GATHER(*dnms) is equivalent to arrays=[i.value for i in dnms].
%	If one wants to gather the tall/codistributed/distributed/gpuArray array inside the dnm, use feval(@GATHER,...).
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output,Repeating)
		varargout
	end
	varargout=cellfun(@(x)ifinline(isa(x,"dnm"),@()x.value,@()gather(x)),varargin,"uniformoutput",false);
end