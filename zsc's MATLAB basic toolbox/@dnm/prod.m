function ret=prod(self,dims,nanflag)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret dnm
	end
	ret=self.applyalong(@prod,dims,mode="flatten",additionalinput={nanflag});
end