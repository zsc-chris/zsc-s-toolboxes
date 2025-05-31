function [ret,M]=std(self,w,dims,missingflag)
	arguments(Input)
		self dnm
		w dnm{mustBeNumeric}=0
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		missingflag(1,1)string{mustBeMember(missingflag,["includemissing","includenan","includenat","omitmissing","omitnan","omitnat"])}="includemissing"
	end
	arguments(Output)
		ret dnm
		M dnm
	end
	if isscalar(w)&&ismember(gather(w),[0,1])
		[ret,M]=self.applyalong(@(x,dims,missingflag)zsc.std(x,gather(w),dims,missingflag),dims,additionalinput={missingflag});
	else
		[ret,M]=fevalalong(@std,dims,self,w,mode="flatten",additionalinput={missingflag},broadcastsizedims="all");
	end
end