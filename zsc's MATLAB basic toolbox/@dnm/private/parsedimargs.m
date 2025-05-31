function subs=parsedimargs(dimnames,subs,supportscalar)
	arguments(Input)
		dimnames(1,:)string
		subs(1,:)cell
		supportscalar(1,1)logical=true
	end
	arguments(Output)
		subs(2,:)cell
	end
	dstar=dstarclass;
	if isempty(subs)
		subs=cell(2,0);
	elseif isscalar(subs)&&(isstruct(subs{1})||isa(subs{1},"dictionary")||isa(subs{1},"table"))
		subs=dstar(subs{1});
	elseif isnumeric(subs{1})
		if supportscalar&&(isscalar(subs)||isstring(subs{2}))
			if isscalar(subs)
				subs{2}=[dimnames(1:min(numel(subs{1}),numel(dimnames))),"x"+string(numel(dimnames)+1:numel(subs{1}))];
			end
			subs=dstar(table(subs{2}',subs{1}'));
		else
			subs=[subs;subs];
			subs(1,:)=num2cell([dimnames(1:min(size(subs,2),numel(dimnames))),"x"+string(numel(dimnames)+1:size(subs,2))]);
		end
	else
		subs=reshape(subs,2,[]);
	end
	subs=subs(:,~ismissing(zsc.cell2mat(subs(1,:))));
end