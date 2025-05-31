function ret=einsum(s,dnms)
	%EINSUM	use Einstein summation notation to reduce-time dnms.
	%	EINSUM(s,*dnms) inputs a summation instruction like
	%	"ij,kl->il" as matrix multiplication and times the subsequent
	%	dnms using the index before -> and reduce each index not
	%	presented after ->. Only length-1 dimension name is supported.
	%	This is an implementation of numpy.einsum in matlab with
	%	support for trace, i.e., "ii->i" or "ii->".
	%
	%	See also pagemtimes
	arguments(Input)
		s(1,1)string="->"
	end
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Output)
		ret dnm
	end
	dims=s.split([",","->"])';
	inputs=dims(1:end-1);
	outputs=dims(end);
	assert(numel(inputs)==numel(dnms),'Input number not matched.')
	assert(numel(sort(char(outputs)))==numel(unique(char(outputs))),'Repeated dimension in output.')
	for i=1:numel(dnms)
		dnms{i}.dimnames=string(num2cell(char(inputs(i))));
	end
	ret=dnms{1};
	for i=2:numel(dnms)
		ret=ret.*dnms{i};
	end
	ret=sum(ret,setdiff(ret.dimnames,string(num2cell(char(outputs)))));
	ret.dimnames=sort(string(num2cell(char(outputs))));
end