function [fitobjret,gofret]=shuaquxian(x,y,fittype,time,lower,upper)
%SHUAQUXIAN	An algorithm to fit curve.
%	Brute-force-Monte-Carlo-type curvefitting conceived first by
%	Chris H. Zhao
%	[fitobjret,gofret]=SHUAQUXIAN(x,y) use (1,:) data x to fit (1,:) data y
%	and returns the best fit object and the best goodness.
%
%	See also fit, cfit 

%	Copyright 2022 Chris H. Zhao
    arguments
        x(1,:)double{mustBeReal}
        y(1,:)double{mustBeReal,mustBeEqualSize(x,y)}
        fittype='default'
        time(1,1)double{mustBePositive,mustBeInteger}=100;
		lower(1,:)=-inf
		upper(1,:)=inf
	end
	x=x';
	y=y';
	x=x(~isnan(y));
	y=y(~isnan(y));
    if isequal(fittype,'default')
        fittype=input('Enter the fittype desired: ');
    end
    warn=warning;
    warning('off')
	if nargin<=4
		[fitobjret,gofret]=fit(x,y,fittype);
    	for i=1:time
        	try
            	[fitobj,gof]=fit(x,y,fittype);
            	if gof.rsquare>gofret.rsquare
                	[fitobjret,gofret]=deal(fitobj,gof);
                	disp(vpa(gofret.rsquare))
            	end
        	catch
        	end
    	end
	else
		[fitobjret,gofret]=fit(x,y,fittype,'lower',lower,'upper',upper);
    	for i=1:time
        	try
            	[fitobj,gof]=fit(x,y,fittype,'lower',lower,'upper',upper);
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