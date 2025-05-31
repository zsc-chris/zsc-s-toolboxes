classdef(Abstract,HandleCompatible)dotprivate
%DOTPRIVATE	Reloaded "." subsref for private method.
%	Subclassing this class allows for method defined with an underscore
%	"method_" (preferably in Access=?dotprivate method section) to be
%	called by "obj.method(...)" but to not be able to be called by
%	"method(obj,...)" if the method itself is defined.
%
%	See also matlab.mixin.indexing.OverridesPublicDotMethodCall,
%	matlab.mixin.indexing.ForbidsPublicDotMethodCall

%	Copyright 2025 Chris H. Zhao
	methods
		function varargout=subsref(self,S)
			arguments(Input)
				self dotprivate
				S(1,:)struct
			end
			arguments(Output,Repeating)
				varargout
			end
			if S(1).type=="."&&(isscalar(S)||S(2).type=="()")
				if zsc.ismethod(self,S(1).subs+"_",false)&&zsc.ismethod(self,S(1).subs)
					S(1).subs=S(1).subs+"_";
				elseif ~zsc.isproperty(self,S(1).subs)&&~zsc.ismethod(self,S(1).subs)
					if zsc.isproperty(self,S(1).subs,false)
						throwAsCaller(MException(message("MATLAB:class:GetProhibited",S(1).subs,class(self))))
					elseif zsc.ismethod(self,S(1).subs,false)
						throwAsCaller(MException(message("MATLAB:class:MethodRestricted",S(1).subs,class(self))))
					else
						throwAsCaller(MException(message("MATLAB:noSuchMethodOrField",S(1).subs,class(self))))
					end
				end
			end
			[varargout{1:nargout}]=builtin("subsref",self,S);
		end
	end
end