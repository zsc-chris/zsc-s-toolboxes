function ret=integraln_mc(f,lims,options)
%integraln_mc	n-D Monte Carlo Integral
%	ret=integraln_mc(f,lims,times=times) uses automatic probability
%	distribution function to do Monte Carlo integration for 'f' in
%	the n-D rectangle specified by 'lims' (can be simutaneously infinite),
%	sampling 'times' times.
%
%	See also integraln, integral_mc, integral2_mc

%   Copyright 2024 Chris H. Zhao
	arguments
		f(1,1)function_handle
	end
	arguments(Repeating)
        lims(1,:)double
	end
	arguments
		options.times(1,1)uint64=1e7
	end
	lims=num2cell(reshape(cell2mat(lims),2,[])',2)';
	pdfs=ternary(cellfun(@(x)isequal(x,[-inf,inf]),lims),{@(x)1/pi./(x.^2+1)},arrayfun(@(i)@(x)((lims{i}(1)<x)&(x<lims{i}(2)))/range(lims{i}),1:numel(lims),uniformoutput=false));
	cdfis=ternary(cellfun(@(x)isequal(x,[-inf,inf]),lims),{@(x)tan(pi*(x-.5))},arrayfun(@(i)@(x)lims{i}(1)+x*range(lims{i}),1:numel(lims),uniformoutput=false));
	samples=rand(numel(lims),options.times);
	star=starclass;
	samples=cellfun(@(cdfi,sample)cdfi(sample),cdfis,star(samples)',uniformoutput=false);
	ret=mean((f(samples{:})+zeros(size(samples{1})))./prod(cell2mat(cellfun(@(pdf,sample)pdf(sample),pdfs,samples,uniformoutput=false)),2));
end