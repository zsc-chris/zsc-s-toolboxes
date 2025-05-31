function dnms=splitapply(f,varargin)
%SPLITAPPLY	Alias for groupsummary.
%	*dnms=SPLITAPPLY(f,*dnms,G) is equivalent to
%	dnms=groupsummary(dnms,G,f)
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		varargin dnm
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	dnms=varargin(1:end-1);
	G=varargin{end};
	f=zsc.function_handle(f,[],nargout);
	dnms=groupsummary(dnms,G,f);
end