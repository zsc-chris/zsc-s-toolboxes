function ret=fftn(self,sz)
	arguments(Input)
		self dnm
		sz(1,:)double{mustBeInteger,mustBeNonnegative}=size(self)
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@fftn,self,additionalinput={sz});
end