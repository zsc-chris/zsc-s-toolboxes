function ret=typecast(self,newclass,options)
	arguments(Input)
		self dnm{mustBeTrue(self,"@(self)self.ndims<=1||self.ndims<=2&&isempty(self)")}
	end
	arguments(Input,Repeating)
		newclass(1,:)string
	end
	arguments(Input)
		options.like
	end
	dstar=dstarclass;
	if nargin<1
		error(message("MATLAB:minrhs"))
	elseif nargin>2
		error(message("MATLAB:maxrhs"))
	end
	if isempty(self)
		ret=cast(self,newclass{:},dstar{options});
		return
	else
	if isfield(options,"like")
		if ~isempty(newclass)
			error(message("MATLAB:maxrhs"))
		end
		if isa(options.like,"dnm")
			dim1=ndims(self);
			ret=feval(@(varargin)flatten(typecast(varargin{:})),self,additionalinput={"like",options.like.value});
			dim2=ndims(ret);
			if dim1<dim2
				ret.dimnames=options.like.dimnames(1);
			end
		else
			ret=typecast(self.value,dstar{options});
		end
	else
		ret=feval(@(varargin)flatten(typecast(varargin{:})),self,additionalinput=newclass);
	end
end