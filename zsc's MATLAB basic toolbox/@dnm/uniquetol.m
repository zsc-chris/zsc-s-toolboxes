function [ret,IA,IC]=uniquetol(self,tol,dims,occurence,options)
	arguments(Input)
		self dnm{mustBeFloat}
		tol double{mustBeTrue(tol,"@(tol)isscalar(tol)&&tol>0||isequal(tol,[])")}=[]
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		occurence(1,1)string{mustBeMember(occurence,["lowest","highest"])}="lowest"
		options.DataScale dnm=1
		% options.PreserveRange(1,1)logical=false
	end
	arguments(Output)
		ret dnm
		IA dnm
		IC dnm
	end
	if isequal(tol,[])
		tol=ternary(isUnderlyingType(self,"double"),1e-12,1e-6);
	end
	[ret,IA,IC]=fevalalong(@(self,DataScale)uniquetol(self,tol,occurence,byrows=true,datascale=DataScale),dims,self,options.DataScale,mode="flattenall",keepdims=true,keepotherdims=[true,false],broadcastsizedims="other");
end