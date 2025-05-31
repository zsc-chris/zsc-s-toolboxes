function ret=index(x,y)
	arguments
		x(1,:)string
		y(1,:)string
	end
	y=y(~ismissing(y));
	[~,ret]=ismember(y,x);
	out=outclass;
	ret(ret==0)=numel(x)+out{3,3,@unique,y(ret==0)};
end