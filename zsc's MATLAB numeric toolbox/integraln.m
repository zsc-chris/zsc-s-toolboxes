function ret=integraln(f,lims,options)
%integraln	n-D Integral
%	ret=integraln(f,*lims,**options) does integration for 'f' in
%	the n-D rectangle specified by 'lims' (can be simutaneously infinite).
%
%	See also integral, integraln_mc

%   Copyright 2025 Chris H. Zhao
    arguments
        f(1,1)function_handle
	end
	arguments(Repeating)
        lims(1,:)double
	end
	arguments
        options.singularities(:,:)=[]
	end
	lims=cell2mat(lims);
	star=starclass;
	lims=star(lims,2);
	n=numel(lims)/2;
	switch n
		case 1
			ret=integral(f,lims{:});
		case 2
			ret=integral2(f,lims{:});
		case 3
			ret=integral3(f,lims{:});
		otherwise
			ret=integral3(@(x,y,z)arrayfun(@(x,y,z)integraln(@(varargin)f(x,y,z,varargin{:}),lims{7:end}),x,y,z),lims{1:6});
	end
end