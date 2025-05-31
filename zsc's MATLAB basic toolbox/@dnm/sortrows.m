function [ret,index]=sortrows(self,dims,column,direction,options)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		column(1,:)double=1
		direction(1,:)string{mustBeMember(direction,["ascend","descend"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret dnm
		index dnm
	end
	dstar=dstarclass;
	[ret,index]=fevalalong(@sortrows,dims,self,mode="flattenall",keepdims=true,keepotherdims=[true,false],additionalinput={column,direction,dstar{options}});
end