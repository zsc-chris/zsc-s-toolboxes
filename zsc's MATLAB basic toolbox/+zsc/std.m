function [S,M]=std(A,w,dims,missingflag)
%zsc.std	Improved version of MATLAB STD.
%	[S,M]=std(A,w,dims,missingflag) returns nan when operating on dimension
%	with only one nonmissing element.
	arguments
		A
		w=0
		dims(1,:){mustBeTrue(dims,"@(dims)succeeds(@()mustBeInteger(dims))&&all(dims>0)||succeeds(@()assert(string(dims)==""all""))")}=paddata(find(size(A)~=1),1,fillvalue=1)
		missingflag(1,1)string{mustBeMember(missingflag,["includemissing","includenan","includenat","omitmissing","omitnan","omitnat"])}="includemissing"
	end
	[S,M]=std(A,w,dims,missingflag);
	if isscalar(w)&&ismember(w,[0,1])
		if contains(missingflag,"omit")
			S(sum(~ismissing(A),dims)==1)=nan;
		else
			if prod(size(S,dims))==1
				S=nan(size(S),like=S);
			end
		end
	end
end