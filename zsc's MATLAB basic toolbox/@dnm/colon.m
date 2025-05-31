function ret=colon(j,i,k)
	arguments(Input)
		j(1,1)dnm
		i(1,1)dnm
		k(1,1)dnm=missing
	end
	arguments(Output)
		ret(:,1)dnm
	end
	if ismissing(k)
		j.dimnames=union(j.dimnames,i.dimnames);
		ret=dnm(j.value:i.value,[missing,j.dimnames(1)]);
	else
		j.dimnames=union(j.dimnames,union(i.dimnames,k.dimnames));
		ret=dnm(j.value:i.value:k.value,[missing,j.dimnames(1)]);
	end
end