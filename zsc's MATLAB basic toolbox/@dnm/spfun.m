function dnms=spfun(f,dnms)
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Output,Repeating)
		dnms dnm
	end
	[dnms{:}]=feval(@deal,dnms{:});
	ind=find(dnms{1}.value);
	for i=2:numel(dnms)
		ind=union(ind,find(dnms{i}.value));
	end
	tmp=repmat(dnms(1),[nargout,1]);
	star=starclass;
	for i=ind(:)'
		[tmp_{1:nargout}]=f(star{cellfun(@(x)full(x.value(i)),dnms),2}{:});
		for j=1:nargout
			tmp{j}.value(i)=tmp_{j};
		end
	end
	dnms=tmp;
end