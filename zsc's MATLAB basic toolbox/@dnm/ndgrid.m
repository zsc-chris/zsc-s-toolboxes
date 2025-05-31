function dnms=ndgrid(dnms)
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	if nargin==1
		dnms=repmat(dnms,[1,nargout]);
		for i=2:nargout
			dnms{i}.dimnames=dnms{i}.dimnames+string(i);
		end
	end
	[dnms{:}]=feval(@deal,dnms{:});
end