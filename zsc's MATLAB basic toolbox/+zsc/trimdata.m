function B=trimdata(A,m,options)
%zsc.trimdata	Improved version of MATLAB TRIMDATA
%	B=zsc.trimdata(A,m,*,Dimension="auto",FillValue=[],Pattern="constant",
%	Side="trailing") works if Dimension is empty.
	arguments
		A
		m(1,:){mustBeInteger,mustBeNonnegative}
		options.Dimension(1,:){mustBeTrue(m,options.Dimension,"@(m,Dimension)isequal(Dimension,""auto"")||all(Dimension>0)&&succeeds(@()mustBeInteger(Dimension))&&(isscalar(m)||numel(m)==numel(Dimension))&&numel(Dimension)==numel(unique(Dimension))")}="auto"
		options.Side(1,1)string{mustBeMember(options.Side,["trailing","leading","both"])}="trailing"
	end
	if isempty(options.Dimension)||isempty(m)
		B=A;
		return
	end
	dstar=dstarclass;
	B=trimdata(A,m,dstar{options});
end