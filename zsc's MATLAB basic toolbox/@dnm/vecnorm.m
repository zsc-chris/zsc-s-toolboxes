function ret=vecnorm(self,p,dims)
%VECNORM	Vector norm on dnm.
%	ret=VECNORM(self,p,dims) is an alias of vector mode of dnm/norm.
%
%	See also vecnorm, dnm/norm, dnm/pagenorm

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		p(1,1)double=2
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	ret=norm(self,p,dims);
end