function [ret,lags]=xcorr(self,other,dims,maxlag,scaleopt)
	arguments(Input)
		self
		other
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=2
		maxlag double{mustBeTrue(maxlag,"@(maxlag)isequal(maxlag,[])||isscalar(maxlag)&&isinteger(maxlag)&&maxlag>=0")}=[]
		scaleopt(1,1)string{mustBeMember(scaleopt,["none","biased","unbiased","normalized","coeff"])}="none"
	end
	arguments(Output)
		ret dnm
		lags dnm
	end
	[ret,lags]=fevalalong(@xcorr_,dims,self,other,mode="flattenall",keepdims=true,keepotherdims=[true,false],additionalinput={maxlag,scaleopt});
end
function [ret,lags]=xcorr_(self,other,maxlag,scaleopt)
	arguments(Input)
		self
		other
		maxlag double{mustBeTrue(maxlag,"@(maxlag)isequal(maxlag,[])||isscalar(maxlag)&&isinteger(maxlag)&&maxlag>=0")}=[]
		scaleopt(1,1)string{mustBeMember(scaleopt,["none","biased","unbiased","normalized","coeff"])}="none"
	end
	star=starclass;
	N=max(size(self,1),size(other,1));
	[ret,lags]=xcorr([paddata(self,N,dimension=1),paddata(other,N,dimension=1)],star{ifinline(isequal(maxlag,[]),@(){},@(){maxlag})}{:},scaleopt);
	ret=reshape(ret,numel(lags),sqrt(size(ret,2)),sqrt(size(ret,2)));
	ret=ret(:,1:end/2,end/2+1:end);
	ret=ret(:,sub2ind(size(ret,2:3),1:size(ret,2),1:size(ret,3)));
	lags=lags';
end