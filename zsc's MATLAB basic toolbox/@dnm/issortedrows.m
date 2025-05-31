function ret=issortedrows(self,dims,column,direction,options)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		column(1,:)double=1
		direction(1,:)string{mustBeMember(direction,["ascend","descend"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret(1,1)logical
	end
	dstar=dstarclass;
	ret=gather(fevalalong(@issortedrows,dims,self,mode="flattenall",additionalinput={column,direction,dstar{options}}));
end