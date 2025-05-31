function [V,M]=var(A,w,dims,nanflag)
%zsc.var	Improved version of MATLAB NAN.
%	[V,M]=var(A,w,dims,nanflag) returns nan when operating on dimension
%	with only one nonmissing element.
	arguments
		A
		w=0
		dims(1,:){mustBeTrue(dims,"@(dims)succeeds(@()mustBeInteger(dims))&&all(dims>0)||succeeds(@()assert(string(dims)==""all""))")}=paddata(find(size(A)~=1),1,fillvalue=1)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	[V,M]=var(A,w,dims,nanflag);
	if isscalar(w)&&ismember(w,[0,1])
		if contains(nanflag,"omit")
			V(sum(~ismissing(A),dims)==1)=nan;
		else
			if prod(size(V,dims))==1
				V=nan(size(V),like=V);
			end
		end
	end
end