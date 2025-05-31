function assert(varargin)
%zsc.assert	Improved version of MATLAB assert.
%	Built-in assert is not throwing as caller. zsc.assert, like the one in
%	python, is.
%
%	See also assert

%	Copyright 2023 Chris H. Zhao
	try
		assert(varargin{:})
	catch ME
		throwAsCaller(ME)
	end
end