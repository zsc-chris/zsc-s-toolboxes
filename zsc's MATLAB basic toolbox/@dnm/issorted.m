function ret=issorted(self,dims,direction,options)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		direction(1,1)string{mustBeMember(direction,["ascend","descend","monotonic","strictascend","strictdescend","strictmonotonic"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret(1,1)logical
	end
	dstar=dstarclass;
	ret=gather(applyalong(self,@issorted,dims,mode="flatten",additionalinput={direction,dstar{options}}));
end