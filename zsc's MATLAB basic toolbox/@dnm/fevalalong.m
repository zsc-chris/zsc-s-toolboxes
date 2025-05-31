function dnms=fevalalong(f,dims,dnms,options)
%FEVALALONG	Eval a function on DNMs along certain dimensions.
%	*dnms=FEVALALONG(f,dims,*dnms,**options) allows one to specify
%	dimension for a function and provides different ways to process mutiple
%	dimensions: direct(function operates on whole array),
%	flatten(function operates on 1-D vector, flatten the dimensions),
%	iterate(function operates on each dimension one by one),
%	flattenall(function operates on 2-D table-like matrix, flatten the
%	dimensions as well as other dimensions, the latter unflattened after
%	operation if keepotherdims=true).
%	The signature for f should be: f(*dnms,dims,*additionalinput) if
%	vectorized=true and mode~="flattenall" else f(*dnms,*additionalinput)
%
%	To auto-broadcast dnms along dimensions dims, use
%	...=fevalalong(@deal,dims,...,vectorized=false)
%
%	Note: Python behavior is keepdims=false, whilst that of MATLAB is true.
%	Note: The function does not need to be vectorized on other dimensions.
%	Note: If you want to select all dimension, leave dims the default
%		value. Avoid using "all", as maybe one dim_name of dnm is "all".
%	Note: In flatten and flattenall mode, at least one dimension must be
%		specified. Otherwise a new dimension will be created, as maybe the
%		function turn scalar into vector for every position. If the
%		function is guaranteed to return scalar for every flattened vector
%		input, set keepdims=false to avoid this.
%	Note: The last element of options.(keepdims/keepotherdims/unflatten)
%		will be broadcast in view of outputs with varargout.
%
%	See also dnm/applyalong, dnm/feval, dnm/fevalkernel

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		f(1,1)function_handle
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}
	end
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Input)
		options.mode(1,1)string{mustBeMember(options.mode,["direct","flatten","iterate","flattenall"])}="direct"
		options.keepdims(1,:)logical{mustBeNonempty}=false
		options.unflatten(1,:)logical{mustBeNonempty}=false
		options.keepotherdims(1,:)logical{mustBeNonempty}=false
		options.broadcastsizedims(1,1)string{mustBeMember(options.broadcastsizedims,["all","","other","none"])}="other"
		options.vectorized(1,1)logical=true
		options.additionalinput(:,1)cell={}
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	star=starclass;
	if nargin==1||isequal(dims,"all")&&all(~cellfun(@(x)ismember(dims,x.dimnames),dnms))
		dims=flatten(unique([star{dnms,2}{:}.dimnames]))';
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=string(dims);
		missingfiller=string(repmat('_',1,paddata(max(strlength(dims(~ismissing(dims)))),1)+1));
		dims=fillmissing(dims,"constant",missingfiller);
	end
	if islogical(dims)
		dims=find(dims);
	end
	if isnumeric(dims)
		newdimnames=[dnms{1}.dimnames,"x"+string(max(cellfun(@ndims,dnms))+1:max(dims))]; % Really 1? not all?
		dims=newdimnames(dims);
		dnms{1}.dimnames=newdimnames;
	end
	if numel(dnms)>1
		switch options.broadcastsizedims
			case "all"
				[dnms{:}]=feval(@deal,dnms{:},broadcastsize=true);
			case {"","other"}
				if options.broadcastsizedims==""
					[tmp{1:numel(dnms)}]=feval(@deal,star{cellfun(@(dnm)subsasgn(dnm,substruct(".","dimnames","()",{~ismember(dnm.dimnames,dims)}),missing),dnms,"uniformoutput",false),2}{:});
				else
					[tmp{1:numel(dnms)}]=feval(@deal,star{cellfun(@(dnm)subsasgn(dnm,substruct(".","dimnames","()",{ismember(dnm.dimnames,dims)}),missing),dnms,"uniformoutput",false),2}{:});
				end
				tmp=tmp{1};
				out=outclass;
				dnms=cellfun(@(dnm)out{2,1,@(varargin)feval(@deal,varargin{:}),dnm,tmp},dnms,"uniformoutput",false);
				clear tmp
				[dnms{:}]=feval(@deal,dnms{:},broadcastsize=false);
			case "none"
				[dnms{:}]=feval(@deal,dnms{:},broadcastsize=false);
		end
	end
	for i=1:numel(dnms)
		dnms{i}.dimnames(index(dnms{i}.dimnames,dims))=dims;
	end
	dims=index(dnms{1}.dimnames,dims);
	switch options.mode
		case "direct"
			if options.vectorized
				[tmp{1:nargout}]=f(star{dnms,2}{:}.value,dims,options.additionalinput{:});
			else
				permutation=[dims,setdiff(1:ndims(dnms{1}),dims)];
				tmp_=cellfun(@(x)zsc.permute(x.value,permutation),dnms,"uniformoutput",false);
				tmp_=cellfun(@(x)num2cell(x,1:numel(dims)),tmp_,"uniformoutput",false);
				[tmp{1:nargout}]=cellfun(@(varargin)f(varargin{:},options.additionalinput{:}),tmp_{:},"uniformoutput",false);
				tmp=cellfun(@zsc.cell2mat,tmp,"uniformoutput",false);
				tmp=cellfun(@(x)zsc.ipermute(x,permutation),tmp,"uniformoutput",false);
			end
			varargout=repmat(dnms(1),[1,numel(tmp)]);
			for i=1:numel(tmp)
				varargout{i}.value=tmp{i};
			end
		case "flatten"
			if isempty(dims)
				dims=ndims(dnms{1})+1;
				dnms=cellfun(@(x)subsasgn(x,substruct(".","dimnames"),[x.dimnames,"x"+string(dims)]),dnms,"uniformoutput",false);
			end
			for i=1:numel(dnms)
				[dnms{i},dim,sz]=flatten(dnms{i},dims);
			end
			if options.vectorized
				[tmp{1:nargout}]=f(star{dnms,2}{:}.value,index(dnms{1}.dimnames,dim),options.additionalinput{:});
			else
				tmp_=cellfun(@(x)zsc.transpose(x.value,[index(dnms{1}.dimnames,dim),1]),dnms,"uniformoutput",false);
				tmp_=cellfun(@(x)num2cell(x,1),tmp_,"uniformoutput",false);
				[tmp{1:nargout}]=cellfun(@(varargin)f(varargin{:},options.additionalinput{:}),tmp_{:},"uniformoutput",false);
				tmp=cellfun(@(x)cellfun(@(y)paddata(y(:),[max(cellfun(@(x)numel(x),x),[],"all"),1],"fillvalue",tryinline(@()cast(missing,"like",y),@(~)[])),x,"uniformoutput",false),tmp,"uniformoutput",false);
				tmp=cellfun(@zsc.cell2mat,tmp,"uniformoutput",false);
				tmp=cellfun(@(x)zsc.transpose(x,[index(dnms{1}.dimnames,dim),1]),tmp,"uniformoutput",false);
			end
			varargout=repmat(dnms(1),[1,numel(tmp)]);
			for i=1:numel(tmp)
				varargout{i}.value=tmp{i};
			end
		case "iterate"
			varargout=dnms;
			for dim=dims
				if options.vectorized
					[tmp{1:numel(dnms)}]=f(star{varargout}{:}.value,dim,options.additionalinput{:});
				else
					tmp_=cellfun(@(x)zsc.transpose(x.value,[dim,1]),varargout,"uniformoutput",false);
					tmp_=cellfun(@(x)num2cell(x,1),tmp_,"uniformoutput",false);
					[tmp{1:numel(dnms)}]=cellfun(@(varargin)f(varargin{:},options.additionalinput{:}),tmp_{:},"uniformoutput",false);
					tmp=cellfun(@(x)cellfun(@(y)paddata(y(:),[max(cellfun(@(x)numel(x),x),[],"all"),1],"fillvalue",tryinline(@()cast(missing,"like",y),@(~)[])),x,"uniformoutput",false),tmp,"uniformoutput",false);
					tmp=cellfun(@zsc.cell2mat,tmp,"uniformoutput",false);
					tmp=cellfun(@(x)zsc.transpose(x,[dim,1]),tmp,"uniformoutput",false);
				end
				for i=1:numel(dnms)
					varargout{i}.value=tmp{i};
				end
			end
		case "flattenall" % for situation where "rows" are treated as a whole and function operates on "columns", like unique.
			if isempty(dims)
				dims=ndims(dnms{1})+1;
				dnms=cellfun(@(x)subsasgn(x,substruct(".","dimnames"),[x.dimnames,"x"+string(dims)]),dnms,"uniformoutput",false);
			end
			for i=1:numel(dnms)
				[dnms{i},otherdim,szother]=flatten(dnms{i},setdiff(1:ndims(dnms{i}),dims));
				[dnms{i},dim,sz]=flatten(dnms{i},dims);
				dnms{i}=permute(dnms{i},[dim,otherdim]);
			end
			zsc.assert(options.vectorized,"DNM:fevalalong:collision","There is no point to set vectorized=false when mode=flattenall. Use mode=flatten instead.")
			[varargout{1:nargout}]=f(dnms{:},options.additionalinput{:});
			options.keepotherdims=resize(options.keepotherdims,numel(varargout),fillvalue=options.keepotherdims(end));
			varargout=arrayfun(@(x,y)ifinline(y,@()unflatten(dnm(x{:},[dim,otherdim]),otherdim,szother),@()dnm(x{:},dim)),varargout,options.keepotherdims,"uniformoutput",false);
	end
	options.keepdims=resize(options.keepdims,numel(varargout),fillvalue=options.keepdims(end));
	if contains(options.mode,"flatten")
		options.unflatten=resize(options.unflatten,numel(varargout),fillvalue=options.unflatten(end));
		zsc.assert(all(~options.unflatten|options.keepdims),"DNM:Fevalalong:attempttounflattenwhennotkeepdims","Can only unflatten if keepdims.")
		varargout=arrayfun(@(x,y)ifinline(y,@()unflatten(x{:},dim,sz),@()x{:}),varargout,options.unflatten,"uniformoutput",false);
		varargout=arrayfun(@(x,y)ifinline(y,@()x{:},@()squeeze(x{:},dim)),varargout,options.keepdims,"uniformoutput",false);
	else
		varargout=arrayfun(@(x,y)ifinline(y,@()x{:},@()squeeze(x{:},dims)),varargout,options.keepdims,"uniformoutput",false);
	end
	if exist("missingfiller","var")
		for i=1:numel(varargout)
			varargout{i}.dimnames(varargout{i}.dimnames==missingfiller)=missing;
		end
	end
	dnms=varargout;
end