function ret=pagenorm(self,p)
%PAGENORM	Norm on the first two dimensions of dnm.
%	ret=PAGENORM(self,p) is a special case of norm where the first two
%	dimensions are normed.
%
%	See also pagenorm, dnm/norm, dnm/vecnorm

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
		p(1,1)double=2
	end
	arguments(Output)
		ret dnm
	end
	ret=norm(self,p,1,2);
end