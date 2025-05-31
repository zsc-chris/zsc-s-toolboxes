function dnms=cellfun(f,dnms,options)
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Input)
		options.UniformOutput(1,1)logical=true
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	dstar=dstarclass;
	[tmp{1:nargout}]=feval(@(varargin)cellfun(f,varargin{:}),dnms{:},additionalinput={dstar{options}});
	dnms=tmp;
end