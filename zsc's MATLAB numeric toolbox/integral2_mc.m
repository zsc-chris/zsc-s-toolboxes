function ret=integral2_mc(fun,xs,ys,times)
%integral2_mc	2D Monte Carlo Integral
%	ret=integral2_mc(fun,xs,ys,times) uses 2D uniform probability
%	distribution function to do Monte Carlo integration for 'fun' in
%	the polygon specified by 'xs' and 'ys', trying to sample 'times' times.
%
%	See also integral2, integral_mc

%   Copyright 2022 Chris H. Zhao
    arguments
        fun(1,1)function_handle
        xs(1,:)double=[0,1,1,0]
        ys(1,:)double=[0,0,1,1]
        times(1,1)uint64=1e7
	end
	x=rand(1,times)*range(xs)+min(xs);
	y=rand(1,times)*range(ys)+min(ys);
    ret=sum(fun(x(inpolygon(x,y,xs,ys)),y(inpolygon(x,y,xs,ys)))+zeros(size(x)))*polyarea(xs,ys)/sum(inpolygon(x,y,xs,ys));
end