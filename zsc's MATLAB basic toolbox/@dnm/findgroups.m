function [ret,ID]=findgroups(dnms,options)
	arguments(Input,Repeating)
		dnms dnm
	end
	arguments(Input)
		options.dims{mustBeA(options.dims,["logical","double","string","char","cell"])}
	end
	arguments(Output)
		ret dnm
	end
	arguments(Output,Repeating)
		ID dnm
	end
	if ~isfield(options,"dims")
		star=starclass;
		options.dims=flatten(unique([star{dnms}{:}.dimnames]))';
	end
	[ret,ID{1:numel(dnms)}]=fevalalong(@findgroups_,options.dims,dnms{:},mode="flattenall",keepdims=true,broadcastsizedims="",keepotherdims=[false,true]);
end
function [ret,ID]=findgroups_(A)
	arguments(Input,Repeating)
		A
	end
	arguments(Output)
		ret
	end
	arguments(Output,Repeating)
		ID
	end
	sz=cumsum(cellfun(@(x)size(x,2),A));
	A=cellfun(@(x)num2cell(x,1),A,"uniformoutput",false);
	A=horzcat(A{:});
	[ret,ID{1:numel(A)}]=findgroups(A{:});
	ID=arrayfun(@(i)horzcat(ID{ifinline(i==1,@()1,@()sz(i-1)+1):sz(i)}),1:numel(sz),"uniformoutput",false);
end