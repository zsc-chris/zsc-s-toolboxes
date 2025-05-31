function varargout=tryinline(try_,catch_,finally_)
%TRYINLINE	Inline try.
%	*varargout=TRYINLINE(try_,catch_,finally_) is the same as
%		try
%			*varargout=try_();
%		catch ME
%			*varargout=catch_(ME);
%		finally
%			finally_();
%		end
%
%	Note that even try_ contains return, finally will
%	still run, like python.
%
%	See also ifinline.

%	Copyright 2025 Chris H. Zhao
	arguments
		try_(1,1)function_handle
		catch_(1,1)function_handle
		finally_(1,1)function_handle=@nop
	end
	finally_=onCleanup(finally_);
	try
		try
			[varargout{1:nargout}]=try_();
		catch ME
			[varargout{1:nargout}]=catch_(ME);
		end
	catch ME_
		rethrowAsCaller(ME_)
	end
end