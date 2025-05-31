function ret=isproperty(obj,propertyName,available)
%zsc.isproperty	Improved version of MATLAB ISPROPERTY
%	ret=isproperty(obj,propertyName,available=true) queries whether
%	object/class has (available) property propertyName.
%
%	See also isproperty, zsc.ismethod, zsc.properties.

%	Copyright 2025 Chris H. Zhao
	arguments
		obj
		propertyName string
		available=true
	end
    ret=ismember(propertyName,string(zsc.properties(obj,available)));
end