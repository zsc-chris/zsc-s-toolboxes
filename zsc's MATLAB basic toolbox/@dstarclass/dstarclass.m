classdef(HandleCompatible)dstarclass
%DSTARCLASS	Mapping unpacking (python style)
%	"dstar=DSTARCLASS;dstar{x,numpairs}" converts mapping x to
%	comma-separated list **x, which is name-value pair. numpairs only
%	matters in {} assignment.
%	
%	dstar{x} syntax support:
%	Statement: [...]=dstar{x};
%	Expression: [...]=fun(dstar{x});
%	Assignment: [dstar{"x",...}]=deal(...);
%
%	dstar(...) is equivalent to structured {dstar{...}}, i.e.
%	dstar{...}=="dstar(...){:}". Using this syntax eliminates the need to
%	specify numpairs.
%
%	The output can be further subsrefed/subsasgned without the need to use
%	cellfun. Be careful that the last subscript cannot be (), otherwise
%	evil MATLAB will force the numArgumentsFromSubscript to be 1. This is a
%	type of syntactic sugar for zsc's "xxxclass"es.
%
%	See also deal, starclass

%	Copyright 2024 Chris H. Zhao
	methods
		ret=numArgumentsFromSubscript(self,s,indexingContext)
		% B=subsref(self,S)
		varargout=subsref(self,S)
		self=subsasgn(self,S,B)
	end
end