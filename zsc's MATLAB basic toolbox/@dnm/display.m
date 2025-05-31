function display(self,name)
	arguments(Input)
		self dnm
		name(1,:)char=subsref(str2func("@inputname"),substruct("()",{1}));
	end
	displayinternal(self,name)
end