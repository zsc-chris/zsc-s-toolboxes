function [ret,I]=sort(self,dims,direction,options)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		direction(1,1)string{mustBeMember(direction,["ascend","descend"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret dnm
		I dnm
	end
	dstar=dstarclass;
	[ret,I]=applyalong(self,@sort,dims,mode="flatten",keepdims=true,additionalinput={direction,dstar{options}});
end