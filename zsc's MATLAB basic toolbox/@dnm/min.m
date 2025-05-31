function [ret,index]=min(self,other,dims,missingflag,mode)
	arguments(Input)
		self
		other=[]
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		missingflag(1,1){mustBeMember(missingflag,["omitmissing","omitnan","omitnat","omitundefined","includemissing","includenan","includenat","includeundefined"])}="omitmissing"
		mode{mustBeTrue(mode,"@(mode)isequal(mode,[])||isequal(mode,""linear"")")}=[]
	end
	arguments(Output)
		ret dnm
		index dnm
	end
	if isequal(other,[])
		[ret,index]=self.applyalong(@(x,dim,varargin)min(paddata(x,1,fillvalue=nan,dimension=dim),[],dim,varargin{:}),dims,mode="flatten",additionalinput=ifinline(isequal(mode,[]),@(){missingflag},@(){missingflag,mode}));
	else
		ret=feval(@min,self,other,additionalinput=ifinline(isequal(mode,[]),@(){missingflag},@(){missingflag,mode}));
		tmp=self>=other;
		index=dnm(find(tmp.value),catdims(self.dimnames));
	end
end