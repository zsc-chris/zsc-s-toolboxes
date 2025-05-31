function validateattributes(self,varargin)
	try
		try
			builtin("validateattributes",self,varargin{:})
		catch
			builtin("validateattributes",self.value,varargin{:})
		end
	catch ME
		rethrowAsCaller(ME)
	end
end