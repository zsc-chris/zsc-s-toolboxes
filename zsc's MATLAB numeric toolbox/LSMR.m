function ret=LSMR(x,y,M,ycbar,siglev)
%LSMR Least Square Mean Regression
%	LSMR(x,y) returns a structure with regression parameters of y=mx+b
%	m,s_m,b,s_b,S_xx,S_yy,S_xy,SS_resid,SS_tot,SS_regr,Rsquare,s_regr,
%	s_resid,F,etc. in it
%	LSMR(x,y,M,ycbar) returns a structure with all above parameters and
%	xcbar,x_c,CI in it

%	Copyright 2022 Chris H. Zhao
	arguments
		x(1,:)double{mustBeReal}
		y(1,:)double{mustBeReal,mustBeEqualSize(y,x)}
		M(1,1)double{mustBePositive,mustBeInteger}=0x7fffffff
		ycbar(1,:)double{mustBeReal}=nan
		siglev(1,1)double{mustBePositive}=0.05
	end
	ret.x=x;
	ret.y=y;
	ret.xbar=mean(ret.x);
	ret.ybar=mean(ret.y);
	ret.N=length(ret.x);
	ret.S_xx=sum((ret.x-ret.xbar).^2);
	ret.S_yy=sum((ret.y-ret.ybar).^2);
	ret.S_xy=sum((ret.x-ret.xbar).*(ret.y-ret.ybar));
	ret.m=ret.S_xy/ret.S_xx;
	ret.b=ret.ybar-ret.m*ret.xbar;
	ret.s_r=sqrt((ret.S_yy-ret.m^2*ret.S_xx)/(ret.N-2));
	ret.s_m=ret.s_r^2/ret.S_xx;
	ret.s_b=ret.s_r*sqrt(1/(ret.N-sum(ret.x)^2/sum(ret.x.^2)));
	ret.SS_resid=sum((ret.y-ret.b-ret.m*ret.x).^2);
	ret.SS_tot=ret.S_yy;
	ret.SS_regr=ret.SS_tot-ret.SS_resid;
	ret.Rsquare=ret.SS_regr/ret.SS_tot;
	ret.s_regr=sqrt(ret.SS_regr);
	ret.s_resid=sqrt(ret.SS_resid/(ret.N-2));
	ret.F=(ret.s_regr/ret.s_resid)^2;
	if M==0x7fffffff && isnan(ycbar)
		return
	end
	ret.M=M;
	ret.ycbar=ycbar;
	ret.s_c=ret.s_r/ret.m*sqrt(1/ret.M+1/ret.N+(ret.ycbar-ret.ybar).^2/ret.m^2/ret.S_xx);
	ret.t=tinv(1-siglev,ret.N-2);
	ret.xcbar=(ret.ycbar-ret.b)/ret.m;
	ret.CI=[ret.xcbar-ret.s_c*ret.t,ret.xcbar+ret.s_c*ret.t];
end
function mustBeEqualSize(a,b)
    % Test for equal size
    if ~isequal(size(a),size(b))
        eid='Size:notEqual';
        msg='Inputs must have equal size.';
        throwAsCaller(MException(eid,msg))
    end
end