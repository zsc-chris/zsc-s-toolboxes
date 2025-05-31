function ret=mindim(x)
	ret=find(size(x)~=1,1,"last");
	if isempty(ret)
		ret=0;
	end
end