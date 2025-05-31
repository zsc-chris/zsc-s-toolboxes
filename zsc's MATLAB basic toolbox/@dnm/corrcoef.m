function [ret,L,RP,RU]=corrcoef(self,other,dims,options)
	arguments(Input)
		self dnm
		other dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1
		options.Alpha(1,1)double=0.05
		options.Row(1,1)string{mustBeMember(options.Row,["all","complete","pairwise"])}="all"
	end
	arguments(Output)
		ret dnm
		L dnm
		RP dnm
		RU dnm
	end
	dstar=dstarclass;
	[ret,L,RP,RU]=fevalalong(@corrcoef_,dims,self,other,mode="flattenall",keepotherdims=true,broadcastsizedims="all",additionalinput={dstar{options}});
end
function [ret,L,RP,RU]=corrcoef_(self,other,options)
	arguments(Input)
		self
		other
		options.Alpha(1,1)double=0.05
		options.Row(1,1)string{mustBeMember(options.Row,["all","complete","pairwise"])}="all"
	end
	tmp=[self,other];
	if size(tmp,1)==1
		[ret,L,RP,RU]=deal(nan(size(self),"like",self));
		return
	end
	star=starclass;
	dstar=dstarclass;
	[ret,L,RP,RU]=corrcoef(tmp,dstar{options});
	[ret,L,RP,RU]=star{cellfun(@(x)diag(x(1:end/2,end/2+1:end))',{ret;L;RP;RU},uniformoutput=false)}{:};
end