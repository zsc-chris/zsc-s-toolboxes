function ret=norm(self,p,dims)
%NORM	Vector/Matrix norm of dnm.
%	ret=NORM(self,p,*dims) operates vector norm (numel(dims)<=1) or matrix
%	norm (numel(dims)==2) on self.
%
%	Note: Row vector like [1,2,3] can be treated either as a matrix or as a
%	vector here depending on nargin=3/4. Its norm of p=1/inf will be
%	swapped.
%	Note: "fro" is unnecessary. The default nargin=1 mode is "fro".
%
%	See also norm, dnm/vecnorm, dnm/pagenorm

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		p(1,1)double=2
	end
	arguments(Repeating)
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}
	end
	dims=paddata(dims,1,fillvalue={1:ndims(self)});
	if isscalar(dims)
		ret=fevalalong(@(self,dim,varargin)norm(self,varargin{:}),dims{:},self,mode="flatten",additionalinput={p},vectorized=false);
	else
		zsc.assert(numel(dims)==2,message("MATLAB:maxrhs"))
		for i=1:2
			if ischar(dims)||iscellstr(dims)||isstring(dims)
				dims=index(self,string(dims));
			end
			if islogical(dims)
				dims=find(dims);
			end
		end
		zsc.assert(isscalar(dims{1})&&isscalar(dims{2}),"DNM:norm:dimensionsmustbescalar","In matrix mode, norm should be specified two dimensions.")
		dims=cell2mat(dims);
		ret=fevalalong(@(self,p)norm([self;zeros([1,size(self,2)],"like",self)],p),dims,self,additionalinput={p},vectorized=false);
	end
end