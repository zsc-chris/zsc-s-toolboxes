function ret=movfunind(x,r,Endpoints)
%	Search in 1d, and return min & max inds. For movfun series.
	arguments
		x(1,:){mustBeNumeric}
		r(1,2)
		Endpoints(1,1)string{mustBeMember(Endpoints,["shrink","discard","fill"])}="shrink"
	end
	switch Endpoints
		case "shrink"
			ret=arrayfun(@(x,r1,r2)-r1+1:r2-1,1:numel(x),movsum(ones(size(x)),[r(1),0]),movsum(ones(size(x)),[0,r(2)]),"uniformoutput",false);
		case "discard"
			ret=arrayfun(@(x,r1,r2)-r1+1:r2-1,1:numel(x),movsum(ones(size(x)),[r(1),0]),movsum(ones(size(x)),[0,r(2)]),"uniformoutput",false);
			ret=ret(movprod(ones(size(x)),[r(1),0],"Endpoints",0)&movprod(ones(size(x)),[0,r(2)],"Endpoints",0));
		case "fill"
			ret=arrayfun(@(x,r1,r2)-r1+1:r2-1,1:numel(x),movsum(ones(size(x)),[r(1),0],"Endpoints",1),movsum(ones(size(x)),[0,r(2)],"Endpoints",1),"uniformoutput",false);
	end
end