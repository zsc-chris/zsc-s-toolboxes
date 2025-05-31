function dnms=applyalong(self,f,dims,options)
%APPLYALONG	Eval a function on one DNM along certain dimensions.
%	*dnms=APPLYALONG(self,f,dims,**options) is a method version of
%	fevalalong.
%
%	Example: a=applyalong(dnm([1,2;3,4],["a","b"]),@expm,["a","b"],keepdim=true);
%
%	Note: If you want to select all dimension, leave dims the default
%	value. Avoid using "all", as maybe one dim_name of dnm is "all".
%
%	See also dnm/fevalalong, dnm/apply, dnm/applykernel

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		self dnm
		f(1,1)function_handle
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		options.mode(1,1)string{mustBeMember(options.mode,["direct","flatten","iterate"])}
		options.keepdims(1,:)logical{mustBeNonempty}
		options.unflatten(1,:)logical{mustBeNonempty}
		options.keepotherdims(1,:)logical{mustBeNonempty}
		options.vectorized(1,1)logical
		options.additionalinput(1,:)cell
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	dstar=dstarclass;
	[dnms{1:nargout}]=fevalalong(f,dims,self,dstar{options});
end