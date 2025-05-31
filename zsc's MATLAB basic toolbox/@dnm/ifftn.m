function ret=ifftn(self,sz,symflag)
	arguments(Input)
		self dnm
		sz(1,:)double{mustBeInteger,mustBeNonnegative}=size(self)
		symflag(1,1)string{mustBeMember(symflag,["symmetric","nonsymmetric"])}="nonsymmetric"
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@ifftn,self,additionalinput={sz,symflag});
end