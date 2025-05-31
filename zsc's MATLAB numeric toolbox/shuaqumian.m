function [fitobjret,gofret]=shuaqumian(x,y,z,fittype,time,lower,upper)
%SHUAQUMIAN	An algorithm to fit surface.
%	Brute-force-Monte-Carlo-type surfacefitting conceived first by
%	Chris H. Zhao
%	[fitobjret,gofret]=SHUAQUMIAN(x,y,z) use (1,:) data x,y to fit (1,:)
%	data z and returns the best fit object and the best goodness.
%
%	See also fit, sfit 

%	Copyright 2022 Chris H. Zhao
    arguments
        x(:,:)double{mustBeReal}
        y(:,:)double{mustBeReal,mustBeEqualSize(x,y)}
		z(:,:)double{mustBeReal,mustBeEqualSize(x,z)}
        fittype='default'
        time(1,1)double{mustBePositive,mustBeInteger}=100;
		lower(1,:)=-inf
		upper(1,:)=inf
	end
	x=x(:);
	y=y(:);
	z=z(:);
	x=x(~isnan(z));
	y=y(~isnan(z));
	z=z(~isnan(z));
    if isequal(fittype,'default')
        fittype=input('Enter the fittype desired: ');
    end
    warn=warning;
    warning('off')
	if nargin<=5
		[fitobjret,gofret]=fit([x,y],z,fittype);
    	for i=1:time
        	try
            	[fitobj,gof]=fit([x,y],z,fittype);
            	if gof.rsquare>gofret.rsquare
                	[fitobjret,gofret]=deal(fitobj,gof);
                	disp(vpa(gofret.rsquare))
            	end
        	catch
        	end
    	end
	else
		[fitobjret,gofret]=fit([x,y],z,fittype,'lower',lower,'upper',upper);
    	for i=1:time
        	try
            	[fitobj,gof]=fit([x,y],z,fittype,'lower',lower,'upper',upper);
            	if gof.rsquare>gofret.rsquare
                	[fitobjret,gofret]=deal(fitobj,gof);
                	disp(vpa(gofret.rsquare))
            	end
        	catch
        	end
    	end
	end
    warning(warn)
end
function mustBeEqualSize(a,b)
    % Test for equal size
    if ~isequal(size(a),size(b))
        eid='Size:notEqual';
        msg='Inputs must have equal size.';
        throwAsCaller(MException(eid,msg))
    end
end