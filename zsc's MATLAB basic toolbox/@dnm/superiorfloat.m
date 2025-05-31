function ret=superiorfloat(varargin)
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret(1,:)char
	end
	classes=cellfun(@(x)string(class(x)),varargin);
	if ~all(ismember(classes,["double","single","float","char","logical","dnm"]))
		throw(MException(message('MATLAB:datatypes:superiorfloat')))
	end
	if ismember("single",classes)
		ret='single';
	else
		ret='double';
	end
end