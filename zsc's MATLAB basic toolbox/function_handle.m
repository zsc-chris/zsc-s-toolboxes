function ret=function_handle(varargin)
%function_handle	Convert zsc.function_handle to function_handle
%	ret=function_handle(x)
%	This function is for the conversion of zsc.function_handle to
%	function_handle. It is harmless.
%
%	<a href="matlab:help datatypes\function_handle.m -displayBanner">Builtin help for function_handle</a>.
%	<a href="matlab:doc function_handle">Documentation for function_handle</a>.

%	Copyright 2025 Chris H. Zhao
	if isscalar(varargin)&&isa(varargin{1},"zsc.function_handle")
		ret=varargin{1}.function_handle_;
	else
		error(message("MATLAB:function_handle:NotAConstructor"))
	end
end