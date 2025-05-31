function ret=integral_mc(fun,xs,pdf,cdfi,times)
%integral_mc	1D Monte Carlo Integral
%	Use arbitrary probability distribution function to do Monte Carlo
%	integration.
%
%	See also int, integral, integral2_mc

%   Copyright 2022 Chris H. Zhao
    arguments
        fun(1,1)function_handle
        xs(1,2)double=[0,1]
        pdf(1,1)function_handle=@(x)(sign(x-xs(1))+sign(xs(2)-x))./range(xs)./2
        cdfi(1,1)function_handle=@(x)x.*range(xs)+xs(1)
        times(1,1)uint64=1e8
	end
    if xs(1)==-inf
        aa=0;
    else
        aa=integral(pdf,-inf,xs(1));%fzero(@(x)cdfi(x)-xs(1),[realmin,1-eps]);
    end
    bb=integral(pdf,-inf,xs(2));%fzero(@(x)cdfi(x)-xs(2),[realmin,1-eps]);
    pdfnew=@(x)pdf(x)./(bb-aa);
    %cdfinew=@(x)cdfi(x.*(bb-aa)+aa)
    tmpfun=@(x)(fun(x)+zeros(size(x)))./pdfnew(x);
    ret=sum(tmpfun(cdfi(rand(1,times))))./double(times);
end