function cross(self,other,dim)
	arguments(Input)
		self
		other
		dim(1,:){mustBeA(dim,["logical","double","string","char","cell"])}=1
	end
	fevalalong(@cross,dim,self,other)
end