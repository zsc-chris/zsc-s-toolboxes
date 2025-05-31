function ret=cumprod(self,dims,direction,nanflag)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		direction(1,1)string{mustBeMember(direction,["forward","reverse"])}="forward"
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret dnm
	end
	ret=self.applyalong(@cumprod,dims,mode="iterate",keepdims=true,additionalinput={direction,nanflag});
end