function ret=cast(self,newclass,options)
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		newclass(1,:)string
	end
	arguments(Input)
		options.like
	end
	if nargin<1
		error(message("MATLAB:minrhs"))
	elseif nargin>2
		error(message("MATLAB:maxrhs"))
	end
	if isfield(options,"like")
		if ~isempty(newclass)
			error(message("MATLAB:maxrhs"))
		end
		if isa(options.like,"dnm")
			ret=feval(@cast,self,additionalinput={options.like.value});
		else
			dstar=dstarclass;
			ret=cast(self.value,dstar{options});
		end
	else
		ret=feval(@cast,self,additionalinput=newclass);
	end
end