classdef outclass
%OUTCLASS	Captures designated output of function
%	"out=OUTCLASS;out{n,i,f,varargin}" outputs the *ith output of
%	f(varargin) out of n requested as a comma-separated list.
%	"out=OUTCLASS;out(n,i,f,varargin)" outputs the *ith output of
%	f(varargin) out of n requested as a cell.
%
%	flatten(out(...))'=={out{...}} is always satisfied.
%
%	The output can be further subsrefed without the need to use cellfun.
%	Note this is a type of syntactic sugar only for zsc's "xxxclass"es.
%
%	Tips: out(4,[1,2;3,4],@deal,1,2,3,4) returns {1,2;3,4}.
%
%	See also deal, dealclass.

%	Copyright 2024 Chris H. Zhao
	methods
		function ret=numArgumentsFromSubscript(self,s,indexingContext)
			arguments
				self outclass
				s(:,1)struct
				indexingContext(1,1)matlab.indexing.IndexingContext
			end
			switch s(1).type
				case "."
					ret=builtin("numArgumentsFromSubscript",self,s,indexingContext);
				case "{}"
					ret=numel(s(1).subs{2});
				case "()"
					if isscalar(s)
						ret=1;
					else
						ret=numArgumentsFromSubscript(subsref(self,s(1)),s(2:end),indexingContext);
					end
			end
		end
		function varargout=subsref(self,S)
			arguments
				self outclass
				S(:,1)struct
			end
			if S(1).type=="."
				varargout={builtin("subsref",self,S)};
			else
				varargout=cell(1,S(1).subs{1});
				[varargout{:}]=S(1).subs{3}(S(1).subs{4:end});
				varargout=varargout(S(1).subs{2});
				if ~isscalar(S)
					varargout=cellfun(@(x)subsref(x,S(2:end)),varargout,"uniformoutput",false);
				end
				if S(1).type=="()"
					varargout={varargout};
				end
			end
		end
	end
end