function dnms=feval(f,dnms,options)
%FEVAL	Eval a function on DNMs with automatic broadcasting.
%	*dnms=FEVAL(f,*dnms,additionalinput=additionalinput) returns
%	dnm(f(*[dnm.value for dnm in dnms],additionalinput{:})) after
%	broadcasting.
%
%	To auto-broadcast dnms, use *dnms=feval(@deal,*dnms).
%
%	See also feval, dnm/apply, dnm/fevalalong, dnm/fevalkernel

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Input)
		options.additionalinput(:,1)cell={}
		options.broadcastsize(1,1)logical=true
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	indices=string(zeros(1,0));
	for i=1:numel(dnms)
		indices=union(indices,dnms{i}.dimnames);
	end
	if numel(dnms)>1
		for i=1:numel(dnms)
			dnms{i}.dimnames=[dnms{i}.dimnames,setdiff(indices,dnms{i}.dimnames)];
		end
		if options.broadcastsize
			dim=cell2mat(cellfun(@(x)size(x),dnms(:),"uniformoutput",false));
			dim(dim==1)=nan;
			maxdim=max(dim,[],1,"omitmissing");
			dnms=cellfun(@(x)broadcast(x,maxdim),dnms,"uniformoutput",false);
		end
	end
	dnms=cellfun(@gather,dnms,"uniformoutput",false);
	out=outclass;
	[dnms{1:nargout}]=f(dnms{:},options.additionalinput{:});
	dnms=cellfun(@(x)dnm(x,indices),dnms,"uniformoutput",false);
end