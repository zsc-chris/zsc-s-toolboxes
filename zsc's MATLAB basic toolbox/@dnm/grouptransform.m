function [dnms,BG]=grouptransform(dnms,groupvars,method)
%GROUPTRANSFORM	Transform each group after grouping
%	[dnms,BG]=GROUPTRANSFORM(dnms,groupvars,method) transforms dnms using
%	method according to groupvars along dimension of the latter.
%
%	Note: Groupbins and options related to it, as well as non-scalar
%	groupvars, are not allowed. Use findgroups and discretize first.
%	Note: Use funcat for multiple outputs. Nargout should be specified
%	using zsc.function_handle.
%	Note: Input to method has a flattened dimension with other dimensions
%	untouched.
%	Note: Do not use string data. Otherwise it may interfere with MATLAB®'s
%	chaotic evil arguments system.
%
%	See also grouptransform, dnm/groupsummary, dnm/groupfilter,
%	dnm/groupcounts, dnm/findgroups, dnm/discretize.

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		dnms(1,:)cell
		groupvars dnm
		method(1,1){mustBeA(method,["string","function_handle"])}
	end
	arguments(Output)
		dnms(1,:)cell
		BG dnm
	end
	if isscalar(groupvars)
		groupvars=dnm(groupvars,"x"+string(numel(unique(zsc.cell2mat(cellfun(@(x)x.dimnames,dnms,"uniformoutput",false))))+1));
	end
	star=starclass;
	[tmp{1:numel(dnms)+1}]=feval(@deal,star{cellfun(@(dnm)subsasgn(dnm,substruct(".","dimnames","()",{~ismember(dnm.dimnames,groupvars.dimnames)}),missing),[dnms,{groupvars}],"uniformoutput",false),2}{:});
	tmp=tmp{1};
	out=outclass;
	[dnms{:},groupvars]=star{cellfun(@(dnm)out{2,1,@(varargin)feval(@deal,varargin{:}),dnm,tmp},[dnms,{groupvars}],"uniformoutput",false),2}{:};
	clear tmp
	dims=groupvars.dimnames;
	dnms=cellfun(@(x)flatten(x,dims),dnms,"uniformoutput",false);
	dim=catdims(dims);
	dnms=cellfun(@(x)flatten(gather(num2cell(x,setdiff(x.dimnames,dim)))),dnms,"uniformoutput",false);
	[groupvars,~,sz]=flatten(groupvars);
	dnms=num2cell([dnms{:}],2);
	function dnms=method_(dnms)
		dnms=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(dnms),1),"uniformoutput",false);
		[tmp{1:nargout(method)}]=method(dnms{:});
		dnms=tmp;
		dnms=cellfun(@(x)flatten(gather(num2cell(x,setdiff(x.dimnames,dim)))),dnms,"uniformoutput",false);
		dnms=num2cell([dnms{:}],2);
	end
	[dnms,BG]=grouptransform(dnms,gather(groupvars),@method_);
	dnms=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(dnms),1),"uniformoutput",false);
	dnms=cellfun(@(x)unflatten(x,dim,sz),dnms,"uniformoutput",false);
	BG=unflatten(dnm(BG,catdims(dims)),dim,sz);
end