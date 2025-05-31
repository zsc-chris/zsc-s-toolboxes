classdef function_handle<handle
%zsc.function_handle	Improved version of MATLAB function_handle.
%	self=zsc.function_handle(function_handle,nargin=[],nargout=[]) returns
%	a "subclass" object of function_handle whose nargin and/or nargout are
%	modified.
%
%	Note: Intended to be scalar.
%	Note: Intended to be subclass of function_handle, but chaotic evil
%	MATLAB prevents me from doing that.
%
%	See also function_handle

%	Copyright 2025 Chris H. Zhao
	properties(Hidden)
		function_handle_(1,1)function_handle=@nop
		nargin_(1,1)double{mustBeInteger}=0
		nargout_(1,1)double{mustBeInteger}=0
	end
	methods
		function self=function_handle(function_handle_,nargin_,nargout_)
			arguments
				function_handle_(1,1)function_handle=@nop
				nargin_(:,:)double{mustBeTrue(nargin_,"@(nargin_)isequal(nargin_,[])||isscalar(nargin_)&&succeeds(@()mustBeInteger(nargin_))")}=[]
				nargout_(:,:)double{mustBeTrue(nargout_,"@(nargout_)isequal(nargout_,[])||isscalar(nargout_)&&succeeds(@()mustBeInteger(nargout_))")}=[]
			end
			if isequal(nargin_,[])
				nargin_=nargin(function_handle_);
			end
			if isequal(nargout_,[])
				nargout_=nargout(function_handle_);
			end
			if isa(function_handle_,"zsc.function_handle")
				self.function_handle_=function_handle_.function_handle_;
			else
				self.function_handle_=function_handle_;
			end
			self.nargin_=nargin_;
			self.nargout_=nargout_;
		end
		function ret=edit(self)
			if nargout==0
				edit(self.function_handle_);
			else
				ret=edit(self.function_handle_);
			end
		end
		function ret=func2str(self)
			ret=func2str(self.function_handle_);
		end
		function ret=functions(self)
			ret=functions(self.function_handle_);
		end
		function ret=open(self)
			if nargout==0
				open(self.function_handle_);
			else
				ret=open(self.function_handle_);
			end
		end
		function ret=nargin(self,new)
			if exist("new","var")
				self.nargin_=new;
				ret=self;
			else
				ret=self.nargin_;
			end
		end
		function ret=nargout(self,new)
			if exist("new","var")
				self.nargout_=new;
				ret=self;
			else
				ret=self.nargout_;
			end
		end
		function varargout=feval(self,varargin)
			[varargout{1:ternary(self.nargout_<0,nargout,self.nargout_)}]=feval(self.function_handle_,varargin{:});
		end
		function ret=isa(self,class)
			arguments
				self(1,1)
				class(1,1)string
			end
			ret=ternary(class=="function_handle",true,builtin("isa",self,class));
		end
		function mustBeA(self,class)
			arguments
				self(1,1)zsc.function_handle
				class(1,:)string{mustBeNonempty}
			end
			function msg=genmsg(class)
				class="'"+class+"'";
				switch numel(class)
					case 1
						msg=class+".";
					case 2
						msg=join(class," or ")+".";
					otherwise
						class(end)="or "+class(end);
						msg=join(class,", ")+".";
				end
			end
			zsc.assert(any(arrayfun(@(class)isa(self,class),class)),message("MATLAB:validators:mustBeA",genmsg(class)));
		end
		function ret=superclasses(~)
			if nargout==0
				disp(newline+"Superclasses for class zsc.function_handle:"+newline+newline+"    "+"function_handle"+newline)
			else
				ret={'function_handle'};
			end
		end
		function ret=numArgumentFromSubscript(self,s,indexingContext)
			arguments
				self(1,1)zsc.function_handle
				s(1,:)struct
				indexingContext(1,1)matlab.indexing.IndexingContext
			end
			if s(1).type=="()"
				ret=numArgumentsFromSubscript(self.function_handle_,s,indexingContext);
			else
				ret=builtin("numArgumentsFromSubscript",self,s,indexingContext);
			end
		end
		function varargout=subsref(self,S)
			arguments
				self(1,1)zsc.function_handle
				S(1,:)struct
			end
			if S(1).type=="()"
				if nargin(self)>=0&&numel(S(1).subs)>nargin(self)
					error(message("MATLAB:TooManyInputs"))
				end
				if nargout(self)>=0&&nargout>nargout(self)
					error(message("MATLAB:TooManyOutputs"))
				end
				[varargout{1:nargout}]=subsref(self.function_handle_,S);
			else
				[varargout{1:nargout}]=builtin("subsref",self,S);
			end
		end
		function self=subsasgn(self,S,varargin)
			arguments
				self(1,1)zsc.function_handle
				S(1,:)struct
			end
			arguments(Repeating)
				varargin
			end
			if S(1).type=="."&&zsc.isproperty(self,S(1).subs+"_",false)
				S(1).subs=S(1).subs+"_";
			end
			self=builtin("subsasgn",self,S,varargin{:});
		end
		function varargout=fplot(varargin)
			varargin=cellfun(@(x)ifinline(isa(x,"zsc.function_handle"),@()x.function_handle_,@()x),varargin,"uniformoutput",false);
			[varargout{1:nargout}]=fplot(varargin{:});
		end
		function disp(self)
			disp(self.function_handle_)
			disp("     nargin: "+nargin(self)+newline+"    nargout: "+nargout(self)+newline)
		end
		function display(self,name)
			if nargin==1
				display(self.function_handle_)
			else
				display(self.function_handle_,name)
			end
			disp("     nargin: "+nargin(self)+newline+"    nargout: "+nargout(self)+newline)
		end
	end
end