function dnms=applykernel(self,kernel,kernelind,options)
%APPLYKERNEL	Eval a kernel function on one DNM.
%	dnms=APPLYKERNEL(self,f,dims,**options) is a method version of
%	fevalkernel.
%
%	See also dnm/fevalalong, dnm/apply, dnm/applykernel

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
		kernel(1,1)function_handle
		kernelind(1,:)cell
		options.mode(1,1)string{mustBeMember(options.mode,["ind","dist"])}="ind"
		options.fillvalue(1,1)=missing
		options.pattern(1,1)string{mustBeMember(options.pattern,["constant","edge","circular","flip","reflect"])}="constant"
		options.Endpoints(1,:){mustBeTrue(options.Endpoints,"@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))")}="shrink"
		options.SamplePoints(1,:){mustBeA(options.SamplePoints,["numeric","cell"])}
		options.vectorized(1,1)=true
		options.additionalinput(1,:)cell={}
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	dstar=dstarclass;
	[dnms{1:nargout}]=fevalkernel(kernel,kernelind,self,dstar{options});
end