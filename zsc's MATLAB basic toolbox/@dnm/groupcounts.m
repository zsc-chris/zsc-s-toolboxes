function [ret,BG,BP]=groupcounts(self,options)
%GROUPCOUNTS	Count each group after grouping
%	[ret,BG,BP]=GROUPSUMMARY(self,options) counts according to self along
%	its dimension.
%
%	Note: For elegance, do not allow groupbins and arguments related to it.
%	Use discretize on groupvars first.
%	Note: Do not use string data. Otherwise it may interfere with MATLAB®'s
%	chaotic evil arguments system.
%
%	See also groupcounts, dnm/groupsummary, dnm/grouptransform,
%	dnm/groupfilter, dnm/findgroups, dnm/discretize.

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
		options.IncludeMissingGroups(1,1)logical=true
		options.IncludeEmptyGroups(1,1)logical=false
	end
	arguments(Output)
		ret dnm
		BG dnm
		BP dnm
	end
	self=flatten(self);
	[ret,BG,BP]=feval(@groupcounts,self);
end