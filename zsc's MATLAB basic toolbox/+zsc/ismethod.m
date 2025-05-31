function ret=ismethod(obj,methodName,available)
%zsc.ismethod	Improved version of MATLAB ISMETHOD
%	ret=ismethod(obj,methodName,available=true) queries whether
%	object/class has (available) method methodName.
%
%	See also ismethod, zsc.isproperty, zsc.methods.

%	Copyright 2025 Chris H. Zhao
	arguments
		obj
		methodName string
		available=true
	end
    ret=ismember(methodName,string(zsc.methods(obj,available)));
end