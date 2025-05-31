classdef(InferiorClasses={?zsc.function_handle})dnm<dotprivate&matlab.mixin.CustomCompactDisplayProvider&parallel.internal.array.PlottableUsingGather % Will support plot of its own kind in the future.
%DNM Dimension-named matrix (tensor/array)
%	ret=DNM(value=0,dimnames="x"+string(1:mindim(value)) if
%	isa(value,"dnm") else value.dimnames) returns a DNM object. If dimnames
%	is specified, value will be flattened for #numel(dimnames) to
%	#numel(value) dimension.
%
%	The dimension number serve as alias for dimension number (for easier
%	management) and automatically broadcasts, so Einstein summation can be
%	easily done.
%
%	Use ....dimnames(...)=missing or squeeze(...) to remove a dimension.
%
%	Special methods: end, where function call serves for matlab
%	compatibility and dot-method call serves for user use:
%	end(...,...) behaves differently from ....end(...).
%
%	Note that this class behaves like python numpy.ndarray in some ways.
%
%	Example: 
%	>> integral(@(x)gather(sum(DNM(x,"x").^DNM(1:5,"n"),"n"))',0,1)
%
%	ans =
%
%	    1.4500
%
%	>>> integral(@(x)integral(@(y)gather(DNM(x,"x").*DNM(y,"y")),1,5,arrayvalued=true)',1,5)
%
%	ans =
%
%		144
%
%	>>> integral(@(x)integral(@(y)gather(DNM(x,"x").*DNM(y,"y")),1,5,arrayvalued=true),1,5,arrayvalued=true)
%
%	ans =
%
%		144
%
%	See also dnm/subsref, dnm/subsasgn, dnm/end, dnm/feval, dnm/einsum,
%	dnm/apply, dnm/applyalong, dnm/permute.

%	Copyright 2024–2025 Chris H. Zhao
	properties
		value=0
		dimnames(1,:)string=string.empty(1,0)
	end
	methods
		function ret=dnm(value,dimnames)
			arguments(Input)
				value=0
				dimnames(1,:)string=ifinline(isa(value,"dnm"),@()value.dimnames,@()"x"+sort(string(1:mindim(value))))
			end
			arguments(Output)
				ret dnm
			end
			if isa(value,"dnm")
				ret=value;
			else
				ret.value=value;
			end
			ret.dimnames=dimnames;
		end
		function self=set.value(self,value)
			arguments(Input)
				self dnm
				value=[]
			end
			arguments(Output)
				self dnm
			end
			self.value=value;
			if mindim(self.value)>ndims(self)
				self.dimnames=[self.dimnames "x"+sort(string(ndims(self)+1:mindim(self.value)))];
				[self.dimnames,permutation]=sort(self.dimnames);
				self.value=zsc.permute(self.value,permutation);
			end
		end
		function self=set.dimnames(self,dimnames)
			arguments(Input)
				self dnm
				dimnames(1,:)string=["x"+sort(string(1:mindim(value)))]
			end
			arguments(Output)
				self dnm
			end
			missingfiller=string(repmat('_',1,paddata(max(strlength(dimnames(~ismissing(dimnames)))),1)+1));
			dimnames=fillmissing(dimnames,"constant",missingfiller);
			ndimsnew=numel(dimnames);
			self.dimnames=dimnames;
			if ndimsnew<mindim(self.value)
				if ndimsnew==0
					self.value=ifinline(isempty(self.value),@()createArray(1,"like",self.value),@()self.value(1));
				else
					self.value=subsref(self.value,substruct("()",repmat({':'},[1,ndimsnew])));
				end
			end
			[self.dimnames,permutation]=sort(dimnames);
			self.value=zsc.permute(self.value,permutation);
			[B,BG]=groupcounts(self.dimnames');
			if any(B>1)
				dims=[];
				subs={};
				for i=BG(B>1)'
					dims_=self.dimnames==i;
					f=find(dims_);
					dims=[dims f(2:end)];
					tmp=zeros(ternary(dims_,size(self),ones(1,ndims(self))));
					subs=[subs,{i,dnm(1:min(size(self,dims_)),[missing,i])}];
					sub=ternary(dims_,repmat({1:min(size(self,dims_))},[1,ndims(self)]),repmat({ones(1,min(size(self,dims_)))},[1,ndims(self)]));
					tmp(sub2ind(size(tmp),sub{:}))=1;
					self.value=self.value.*tmp;
				end
				self.dimnames=unique(self.dimnames);
				self.value=zsc.squeeze(sum(self.value,sort(dims)),sort(dims));
				self=subsref(self,substruct("()",subs));
			end
			if ismember(missingfiller,self.dimnames)
				if isempty(self.value)
					sz=size(self.value);
					sz(self.dimnames==missingfiller)=1;
					self.value=createArray(sz,"like",self.value);
				else
					self.value=subsref(self.value,substruct("()",ternary(self.dimnames==missingfiller,repmat({1},[1,ndims(self)]),repmat({':'},[1,ndims(self)]))));
				end
				self=squeeze(self,missingfiller);
			end
		end
		varargout=size(self,dims)
		% sz=size(self,dims)
		ret=end(self,k,~)
		ret=colon(j,i,k)
		ret=linspace(x1,x2,n,dim,options)
		ret=logspace(x1,x2,n,dim,options)
		[ret,step]=isuniform(self,dims)
		% B=subsref(self,S)
		varargout=subsref(self,S)
		self=subsasgn(self,S,B)
		ind=subsindex(self)
		ret=numArgumentsFromSubscript(self,s,indexingContext)
		ret=squeeze(self,dims)
		ret=ndims(self)
		ret=numel(self)
		ret=length(self)
		ret=dtype(self)
		disp(self)
		display(self,name)
		function ret=matlab.internal.display.dimensionString(self,addempty)
			arguments(Input)
				self dnm
				addempty(1,1)logical=false
			end
			arguments(Output)
				ret(1,1)string
			end
			switch ndims(self)
				case 0
					ret="scalar";
				case 1
					ret=numel(self);
				case 2
					ret=join(string(size(self)),"×");
				otherwise
					if ndims(self)<=double(string(fileread("maxdispndims.txt")))
						ret=join(string(size(self)),"×");
					else
						ret=ndims(self)+"-D";
					end
			end
			if isempty(self)&&addempty
				ret=ret+" empty";
			end
		end
		ret=compactRepresentationForColumn(self,~,~)
		ret=broadcast(self,sz)
		mustBeInteger(self)
		ret=isempty(self)
		ret=isscalar(self)
		ret=isvector(self)
		ret=isrow(self)
		ret=iscolumn(self)
		ret=ismatrix(self)
		ret=isUnderlyingType(self,classname)
		ret=underlyingType(self)
		validateattribute(self,varargin)
		ret=isfloat(self)
		ret=isinteger(self)
		ret=ischar(self)
		ret=islogical(self)
		ret=isstring(self)
		ret=iscell(self)
		ret=isstruct(self)
		ret=isnumeric(self)
		ret=isreal(self)
		ret=isenum(self)
		ret=ismissing(self)
		ret=isinf(self)
		ret=isnan(self)
		ret=isfinite(self)
		ret=isvalid(self)
		ret=isequal(varargin)
		ret=isequaln(varargin)
		ret=keyHash(self)
		ret=keyMatch(self)
		ret=superiorfloat(varargin)
		varargout=gather(varargin)
		ret=cast(self,newclass,options)
		ret=typecast(self,newclass,options)
		ret=double(self)
		ret=single(self)
		ret=logical(self)
		ret=string(self)
		ret=char(self)
		ret=num2cell(self,dims)
		ret=mat2cell(self,dimDist)
		ret=cell2mat(self,dims,finalize)
		ret=dnm2table(self)
		ret=sparse(self)
		ret=issparse(self)
		ret=full(self)
		ret=tall(self)
		ret=codistributed(self)
		ret=distributed(self)
		ret=gpuArray(self)
		ret=sym(self)
		ret=eps(self,p)
		ret=uplus(self)
		ret=uminus(self)
		ret=sign(self)
		ret=abs(self)
		ret=angle(self)
		ret=real(self)
		ret=imag(self)
		ret=conj(self)
		ret=pow2(self)
		ret=exp(self)
		ret=log2(self)
		ret=log(self)
		ret=log10(self)
		ret=sin(self)
		ret=cos(self)
		ret=tan(self)
		ret=cot(self)
		ret=sec(self)
		ret=csc(self)
		ret=sind(self)
		ret=cosd(self)
		ret=tand(self)
		ret=cotd(self)
		ret=secd(self)
		ret=cscd(self)
		ret=sinpi(self)
		ret=cospi(self)
		ret=asin(self)
		ret=acos(self)
		ret=atan(self)
		ret=acot(self)
		ret=asec(self)
		ret=acsc(self)
		ret=sinh(self)
		ret=cosh(self)
		ret=tanh(self)
		ret=coth(self)
		ret=sech(self)
		ret=csch(self)
		ret=asinh(self)
		ret=acosh(self)
		ret=atanh(self)
		ret=acoth(self)
		ret=asech(self)
		ret=acsch(self)
		ret=del2(self,h)
		ret=not(self)
		ret=plus(self,other)
		ret=minus(self,other)
		ret=times(self,other)
		ret=rdivide(self,other)
		ret=ldivide(self,other)
		ret=power(self,other)
		ret=kron(self,other)
		ret=mtimes(self,other)
		ret=mrdivide(self,other)
		ret=mldivide(self,other)
		ret=mpower(self,other)
		ret=and(self,other)
		ret=or(self,other)
		ret=xor(self,other)
		ret=eq(self,other)
		ret=ne(self,other)
		ret=gt(self,other)
		ret=lt(self,other)
		ret=ge(self,other)
		ret=le(self,other)
		ret=clip(self,lower,upper)
		ret=rescale(self,l,u,options)
		ret=isbetween(self,lower,upper,intervalType)
		ret=convn(self,other,shape,options)
		ret=fftn(self,sz)
		ret=ifftn(self,sz,symflag)
		ret=horzcat(dnms)
		ret=vertcat(dnms)
		ret=cat(dim,dnms)
		ret=sum(self,dims,nanflag)
		ret=cumsum(self,dims,direction,nanflag)
		ret=movsum(self,k,dims,nanflag,options)
		ret=diff(self,n,dims)
		ret=prod(self,dims,nanflag)
		ret=cumprod(self,dims,direction,nanflag)
		ret=movprod(self,k,dims,nanflag,options)
		ret=mean(self,dims,nanflag,options)
		ret=movmean(self,k,dims,nanflag,options)
		ret=median(self,dims,nanflag,options)
		ret=movmedian(self,k,dims,nanflag,options)
		ret=nanmean(self,dims)
		ret=nanmedian(self,dims)
		ret=mad(self,flag,dims)
		ret=movmad(self,k,dims,nanflag,options)
		[ret,M]=std(self,w,dims,missingflag,options)
		ret=movstd(self,k,w,dims,nanflag,options)
		[ret,M]=var(self,w,dims,nanflag,options)
		ret=movvar(self,k,w,dims,nanflag,options)
		ret=cov(self,other,w,dims,nanflag)
		[ret,P,RL,RU]=corrcoef(self,other,dims,options)
		[ret,lags]=xcov(self,other,dims,maxlag,scaleopt)
		[ret,lags]=xcorr(self,other,dims,maxlag,scaleopt)
		ret=prctile(self,p,dims,options)
		[ret,q]=iqr(self,dims)
		ret=cross(self,other,dim)
		ret=dot(self,other,dims)
		ret=norm(self,p,dims)
		ret=vecnorm(self,p,dims)
		ret=pagenorm(self,p)
		ret=trace(self,dims)
		[ret,ia,ic]=unique(self,dims,setOrder)
		[ret,IA,IC]=uniquetol(self,dims,occurence,options)
		[ret,ia,ib]=union(self,other,dims,setOrder)
		[ret,ia,ib]=intersect(self,other,dims,setOrder)
		[ret,ia]=setdiff(self,other,dims,setOrder)
		[ret,ia,ib]=setxor(self,other,dims,setOrder)
		[ret,Locb]=ismember(self,other,dims)
		[ret,Locb]=ismembertol(self,other,tol,dims)
		ret=fft(self,n)
		ret=ifft(self,n)
		ret=fftshift(self,dims)
		ret=ifftshift(self,dims)
		ret=circshift(self,K)
		ret=paddata(self,m,options)
		ret=resize(self,m,options)
		ret=trimdata(self,m,options)
		ret=all(self,dims)
		ret=any(self,dims)
		ret=flip(self,dims)
		ret=conv(self,other,shape,options)
		ret=join(self,delimiter,dims)
		[ret,index]=max(self,other,dims,missingflag,mode)
		[ret,index]=maxk(self,k,dims,options)
		ret=movmax(self,k,dims,nanflag,options)
		ret=cummax(self,dims,direction,nanflag)
		[ret,index]=min(self,other,dims,missingflag,mode)
		[ret,index]=mink(self,k,dims,options)
		ret=movmin(self,k,dims,nanflag,options)
		ret=cummin(self,dims,direction,nanflag)
		[ret1,ret2]=bounds(self,dims,missingflag)
		[index,nonzeros]=find(self,n,dims,options)
		[ret,I]=sort(self,dims,direction,options)
		ret=issorted(self,dims,direction,options)
		[ret,index]=sortrows(self,dims,column,direction,options)
		ret=issortedrows(self,dims,column,direction,options)
		[ret,varargout]=findgroups(dnms,options)
		% [ret,ID]=findgroups(dnms,options)
		dnms=splitapply(f,varargin)
		[dnms,BG,BC]=groupsummary(dnms,groupvars,method,options)
		[dnms,BG]=grouptransform(dnms,groupvars,method)
		[dnms,BG]=groupfilter(dnms,groupvars,method,options)
		[ret,BG,BP]=groupcounts(self,options)
		ret=nnz(self,dims)
		index=nonzeros(self,dims)
		ret=transpose(self,dims,finalize)
		ret=ctranspose(self,dims,finalize)
		ret=pagetranspose(self,finalize)
		ret=pagectranspose(self,finalize)
		ret=permute(self,dims,finalize)
		ret=ipermute(self,dims,finalize)
		[ret,dim,sz]=flatten(self,dims,dim)
		[ret,dims]=unflatten(self,dim,sz,dims)
		ret=reshape(self,sz)
		ret=repmat(self,r)
		ret=repelem(self,r)
		ret=einsum(s,dnms)
		varargout=feval(f,dnms,options)
		% dnms=feval(f,dnms,options)
		varargout=fevalalong(f,dnms,options)
		% dnms=fevalalong(f,dnms,options)
		varargout=fevalkernel(kernel,kernelind,dnms,options,indexingoptions,movfunoptions,fevalalongoptions)
		% dnms=fevalkernel(kernel,kernelind,dnms,options,indexingoptions,movfunoptions,fevalalongoptions)
		varargout=apply(self,f,additionalinput)
		% dnms=apply(self,f,additionalinput)
		varargout=applyalong(self,f,dims,options)
		% dnms=applyalong(self,f,dims,options)
		varargout=applykernel(self,kernel,kernelsize,options)
		% dnms=applykernel(self,kernel,kernelsize,options)
		varargout=arrayfun(f,dnms,options)
		% dnms=arrayfun(f,dnms,options)
		varargout=cellfun(f,dnms,options)
		% dnms=cellfun(f,dnms,options)
		varargout=spfun(f,dnms,options)
		% dnms=spfun(f,dnms,options)
		C=bsxfun(fun,A,B)
		%TODO(MAYBE):
		%knnsearch
		%filloutliers/rmoutliers/isoutlier
		%fillmissing/rmmissing/anymissing/standardizeMissing
		%plot...
	end
	methods(Access=private)
		[self,subs]=parsedimargsindexing(self,subs,mode)
	end
	methods(Access=?dotprivate)
		ret=end_(self,dims,~)
	end
	methods(Hidden)
		displayinternal(self,name,mode)
		ret=zerosLike(self,sz)
		ret=onesLike(self,sz)
		ret=nanLike(self,sz)
		ret=infLike(self,sz)
		ret=trueLike(self,sz)
		ret=falseLike(self,sz)
		ret=eyeLike(self,varargin,options)
		ret=randLike(self,varargin)
		ret=randiLike(self,varargin)
		ret=randnLike(self,varargin)
		ret=createArrayLike(self,varargin,options)
	end
	methods(Static,Hidden)
		ret=empty(varargin,options)
		ret=zeros(varargin)
		ret=ones(varargin)
		ret=nan(varargin)
		ret=inf(varargin)
		ret=true(varargin)
		ret=false(varargin)
		ret=eye(varargin,options)
		ret=rand(varargin)
		ret=randi(varargin)
		ret=randn(varargin)
		ret=createArray(dims,F,dimnames)
	end
end