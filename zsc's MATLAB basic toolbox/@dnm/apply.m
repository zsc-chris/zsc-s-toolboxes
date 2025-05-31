function dnms=apply(self,f,options)
%APPLY	Eval a function on one DNM.
%	dnms=APPLY(self,f,**options) is a method version of feval.
%
%	See also dnm/feval, dnm/applyalong, dnm/applykernel

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		self dnm
		f(1,1)function_handle
		options.additionalinput(1,:)cell
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	dstar=dstarclass;
	[dnms{1:nargout}]=feval(f,self,dstar{options});
end