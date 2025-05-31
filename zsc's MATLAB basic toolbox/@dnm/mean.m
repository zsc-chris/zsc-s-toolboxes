function ret=mean(self,dims,nanflag,options)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
		options.Weights dnm
	end
	arguments(Output)
		ret dnm
	end
	if isfield(options,"Weights")
		ret=fevalalong(@(x,w,dims)mean(x,dims,nanflag,Weights=w),dims,self,options.Weights,mode="flatten",broadcastsizedims="all");
	else
		ret=self.applyalong(@mean,dims,additionalinput={nanflag});
	end
end