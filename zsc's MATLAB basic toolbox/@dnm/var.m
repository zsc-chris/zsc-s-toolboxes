function [ret,M]=var(self,w,dims,nanflag)
	arguments(Input)
		self dnm
		w dnm{mustBeNumeric}=0
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret dnm
		M dnm
	end
	if isscalar(w)&&ismember(w,[0,1])
		[ret,M]=self.applyalong(@(x,dims,nanflag)zsc.var(x,gather(w),dims,nanflag),dims,additionalinput={nanflag});
	else
		[ret,M]=fevalalong(@var,dims,self,w,mode="flatten",additionalinput={nanflag},broadcastsizedims="all");
	end
end