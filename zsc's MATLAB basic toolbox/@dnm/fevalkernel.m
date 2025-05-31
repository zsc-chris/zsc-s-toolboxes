function dnms=fevalkernel(kernel,kernelind,dnms,options,indexingoptions,movfunoptions,fevalalongoptions)
%FEVALKERNEL	Eval a kernel function on DNMs.
%	*dnms=FEVALKERNEL(kernel,kernelind,*dnms,**options)
%	The signature for kernel should be: f(*dnms,dim,*additionalinput) if
%	vectorized=true else f(*dnms,*additionalinput).
%	kernelind is index if mode=="ind", and size if mode=="dist"
%
%	Example: fevalkernel(@(a,dims)max(a,[],dims),{"a",-1:1,"b",-1:1},dnm([1,2;3,4],["a","b"]),"fillvalue",nan)
%
%	Note: For a qualified kernel, mode="direct" and keepdims=false.
%	Note: Only supports square grid. If wanting other shape, use mask in f.
%
%	See also dnm/applykernel, dnm/feval, dnm/fevalalong

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		kernel(1,1)function_handle
		kernelind(1,:){mustBeTrue(kernelind,"@(kernelind)isa(kernelind,""cell"")||isscalar(kernelind)&&isa(kernelind,""strel"")||isnumeric(kernelind)||islogical(kernelind)")}
	end
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Input)
		options.mode(1,1)string{mustBeMember(options.mode,["ind","dist"])}="ind"
		indexingoptions.fillvalue(1,1)=missing
		indexingoptions.pattern(1,1)string{mustBeMember(indexingoptions.pattern,["constant","edge","circular","flip","reflect"])}="constant"
		movfunoptions.Endpoints(1,:){mustBeTrue(movfunoptions.Endpoints,"@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))")}="shrink"
		movfunoptions.SamplePoints(1,:){mustBeA(movfunoptions.SamplePoints,["numeric","cell"])}
		fevalalongoptions.vectorized(1,1)=true
		fevalalongoptions.additionalinput(1,:)cell={}
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	dstar=dstarclass;
	[dnms{:}]=feval(@deal,dnms{:});
	switch options.mode
		case "ind"
			zsc.assert(~isfield(options,"SamplePoints"))
			if isa(kernelind,"strel")||islogical(kernelind)
				flatten=true;
				if isa(kernelind,"strel")
					kernelind=kernelind.Neighborhood;
				end
				kernelind=dnm(kernelind);
				kernelind=out(ndims(kernelind),1:ndims(kernelind),@ind2sub,size(kernelind),ker);
			else
				if ~iscell(kernelind)
					kernelind={kernelind};
				end
				flatten=false;
			end
			kernelind=parsedimargs(dnms{1}.dimnames,kernelind,false);
			dims=paddata(string(zsc.cell2mat(kernelind(1,:))),[1,0]);
			kernelind=kernelind(2,:);
			kernelind=arrayfun(@(x,y)dnm(x{:},y),kernelind,dims);
			newdims=setdiff(dims,dnms{1}.dimnames);
			for i=1:numel(dnms)
				dnms{i}.dimnames=[dnms{i}.dimnames,newdims];
			end
			otherdims=setdiff(dnms{1}.dimnames,dims);
			dims_=dnms{1}.dimnames;
			kernelind=lookup(dictionary(dims_,kernelind),dims_,fallbackvalue={ones(size(kernelind{1}))});
			[ind1{1:ndims(dnms{1})}]=zsc.ind2sub(size(dnms{1}),zsc.reshape(1:numel(dnms{1}),size(dnms{1})));
			if flatten
				ind2=kernelind;
				ind2=cellfun(@(x)dnm(x,"("+catdims(dims)+")'"),ind2,"uniformoutput",false);
			else
				[ind2{1:ndims(dnms{1})}]=ndgrid(kernelind{:});
				ind2=cellfun(@(x)dnm(x,dims_+"'"),ind2,"uniformoutput",false);
			end
			ind=cellfun(@plus,ind1,ind2,"uniformoutput",false);
			dims__=ind{1}.dimnames;
			ind=cellfun(@gather,ind,"uniformoutput",false);
			dnms=cellfun(@(x)dnm(zsc.indexing(gather(x),substruct("()",ind),dstar{indexingoptions}),dims__),dnms,"uniformoutput",false);
			if flatten
				[varargout{1:nargout}]=fevalalong(kernel,"("+catdims(dims)+")'",dnms{:},dstar{fevalalongoptions});
			else
				dnms=cellfun(@(x)squeeze(x,otherdims+"'"),dnms,"uniformoutput",false);
				[varargout{1:nargout}]=fevalalong(kernel,dims_+"'",dnms{:},dstar{fevalalongoptions});
			end
			dnms=varargout;
		case "dist"
			if ~iscell(kernelind)
				kernelind={kernelind};
			end
			if ~isnumeric(movfunoptions.Endpoints)
				movfunoptions.Endpoints=string(movfunoptions.Endpoints);
			end
			kernelind=parsedimargs(dnms{1}.dimnames,kernelind,false);
			kernelind(2,:)=cellfun(@(x)ifinline(isscalar(x),@()[x/2,prevreal(x/2)],@()x),kernelind(2,:),"uniformoutput",false);
			dims=paddata(string(zsc.cell2mat(kernelind(1,:))),[1,0]);
			kernelind=kernelind(2,:);
			if ~isfield(movfunoptions,"SamplePoints")
				movfunoptions.SamplePoints=arrayfun(@(x)1:x,size(dnms{1},dims),"uniformoutput",false);
			else
				if ~iscell(movfunoptions.SamplePoints)
					movfunoptions.SamplePoints={movfunoptions.SamplePoints};
				end
				movfunoptions.SamplePoints=parsedimargs(dnms{1}.dimnames,movfunoptions.SamplePoints,false);
				zsc.assert(isequal(zsc.cell2mat(movfunoptions.SamplePoints(1,:)),dims),"DNM:fevalkernel:Dimensionnotmatched","The dimension of SamplePoints must match with that of kernelind.")
				movfunoptions.SamplePoints=movfunoptions.SamplePoints(2,:);
				zsc.assert(succeeds(@()assert(all(cellfun(@isuniform,movfunoptions.SamplePoints))))||succeeds(@()assert(string(movfunoptions.Endpoints)=="shrink")),message("MATLAB:movfun:endpointChoiceInvalid"))
			end
			newdims=setdiff(dims,dnms{1}.dimnames);
			for i=1:numel(dnms)
				dnms{i}.dimnames=[dnms{i}.dimnames,newdims];
			end
			otherdims=setdiff(dnms{1}.dimnames,dims);
			dims_=dnms{1}.dimnames;
			kernelind=lookup(dictionary(dims,kernelind),dims_,fallbackvalue={[0 0]});
			movfunoptions.SamplePoints=arrayfun(@(dim)lookup(dictionary(dims,movfunoptions.SamplePoints),dim,fallbackvalue={1:end_(dnms{1},dim)}),dims_);
			[ind1{1:ndims(dnms{1})}]=zsc.ind2sub(size(dnms{1}),zsc.reshape(1:numel(dnms{1}),size(dnms{1})));
			if isnumeric(movfunoptions.Endpoints)||movfunoptions.Endpoints=="fill"
				ind2=cellfun(@(x,r)movfunind(x,r,"fill"),movfunoptions.SamplePoints,kernelind,"uniformoutput",false);
			else
				ind2=cellfun(@(x,r)movfunind(x,r,movfunoptions.Endpoints),movfunoptions.SamplePoints,kernelind,"uniformoutput",false);
			end
			[ind2{:}]=ndgrid(ind2{:});
			[ind2{:}]=cellfun(@ndgrid,ind2{:},"uniformoutput",false);
			ind=cellfun(@(x,y)arrayfun(@(x,y)x+y{:},x,y,"uniformoutput",false),ind1,ind2,"uniformoutput",false);
			ind=cellfun(@(x)gather(x),ind,"uniformoutput",false);
			if isnumeric(movfunoptions.Endpoints)
				dnms=cellfun(@(x)cellfun(@(varargin)dnm(zsc.indexing(gather(x),substruct("()",varargin),"fillvalue",movfunoptions.Endpoints),dims_),ind{:},"uniformoutput",false),dnms,"uniformoutput",false);
			else
				dnms=cellfun(@(x)cellfun(@(varargin)dnm(zsc.indexing(gather(x),substruct("()",varargin)),dims_),ind{:},"uniformoutput",false),dnms,"uniformoutput",false);
			end
			dnms=cellfun(@(x)cellfun(@(x)squeeze(x,otherdims),x,"uniformoutput",false),dnms,"uniformoutput",false);
			out=outclass;
			[varargout{1:nargout}]=cellfun(@(varargin)gather(fevalalong(kernel,dims,varargin{:},dstar{fevalalongoptions})),dnms{:});
	end
	dnms=varargout;
end