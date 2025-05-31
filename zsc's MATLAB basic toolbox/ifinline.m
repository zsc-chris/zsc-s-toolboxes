function varargout=ifinline(cond,if_,else_,varargin)
%IFINLINE	Inline if (C-style).
%	*varargout=IFINLINE(cond,if_=@()true,else_=@()false,*varargin) is the
%	same as
%		if cond
%			*varargout=if_(*varargin);
%		else
%			*varargout=else_(*varargin);
%		end
%	IFINLINE(cond) converts anything to logical.
%
%	See also ternary, tryinline.

%	Copyright 2025 Chris H. Zhao
	arguments
		cond
		if_(1,1)function_handle=@()true
		else_(1,1)function_handle=@()false
	end
	arguments(Repeating)
		varargin
	end
	if cond
		[varargout{1:max(nargout,nargout(if_))}]=if_(varargin{:});
	else
		[varargout{1:max(nargout,nargout(else_))}]=else_(varargin{:});
	end
end