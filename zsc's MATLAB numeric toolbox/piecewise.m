function ret=piecewise(varargin)
%PIECEWISE	Piecewise function
%	PIECEWISE(condition1, val1, condition2, val2, ..., <otherwiseval>)(x):=
%	(vals(find(conditions(x)))(x) if any(conditions(x)) else otherwiseval).
%
%	See also switch, case, sym/piecewise

%	Copyright 2024 Chris H. Zhao
	if mod(length(varargin),2)==0
		varargin=[varargin,nan];
	end
	function y=f(x)
		for i=1:2:numel(varargin)-1
			if varargin{i}(x)
				if ismember(class(varargin{i+1}),["function_handle","symfun"])
					y=varargin{i+1}(x);
				else
					y=varargin{i+1};
				end
				return
			end
		end
		if ismember(class(varargin{end}),["function_handle","symfun"])
			y=varargin{end}(x);
		else
			y=varargin{end};
		end
	end
	ret=@(x)arrayfun(@f,x);
end