function ret=funcat(fs)
%funcat	Concatenate function output.
%	funcat(*f)(x)=*[i(x) for i in f] where f is a vector of single-output
%	functions.

%	Copyright 2023–2025 Chris H. Zhao
	arguments(Input,Repeating)
		fs(1,1)function_handle;
	end
	function varargout=f(varargin)
		varargout=cell(1,numel(fs));
		for i=1:numel(fs)
			varargout{i}=fs{i}(varargin{:});
		end
	end
	ret=zsc.function_handle(@f,paddata(min(feval(@(x)x(x>=0),cellfun(@nargin,fs))),1,fillvalue=-1),numel(fs));
end