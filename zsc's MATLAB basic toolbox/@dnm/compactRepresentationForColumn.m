function ret=compactRepresentationForColumn(self,~,~)
	arguments(Input)
		self dnm
		~
		~
	end
	dimstring=matlab.internal.display.dimensionString(subsref(self,substruct("()",{self.dimnames(1),dnm(1,self.dimnames(1))})));
	ret=CompactDisplayRepresentation(repmat(dimstring+" dnm",size(self,1),1),repmat(strlength(dimstring+" dnm"),size(self,1),1),repmat(dimstring+" dnm",size(self,1),1));
end