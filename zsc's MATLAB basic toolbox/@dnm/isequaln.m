function ret=isequaln(varargin)
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret logical
	end
	varargin=cellfun(@(x)ifinline(isa(x,"dnm"),@()gather(x),@()x),varargin,"UniformOutput",false);
	ret=isequaln(varargin{:});
end