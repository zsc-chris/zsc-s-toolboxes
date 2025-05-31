function ret=mad(self,flag,dims)
%MAD	Mean/median absolute deviation (×) I am mad (√)
%	ret=mad(self,flag,dims)
%
%	See also mad

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
		flag(1,1)double{mustBeMember(flag,[0,1])}=0
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	if flag
    	ret=nanmedian(abs(self-nanmedian(self,dims)),dims);
	else
    	ret=nanmean(abs(self-nanmean(self,dims)),dims);
	end
end