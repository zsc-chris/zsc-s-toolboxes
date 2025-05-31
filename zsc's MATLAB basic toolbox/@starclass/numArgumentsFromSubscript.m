function ret=numArgumentsFromSubscript(self,s,indexingContext)
%	TODO: 本地化
	arguments
		self starclass
		s(:,1)struct
		indexingContext(1,1)matlab.indexing.IndexingContext
	end
	switch s(1).type
		case "."
			ret=builtin("numArgumentsFromSubscript",self,s,indexingContext);
		case "{}"
			if indexingContext==matlab.indexing.IndexingContext.Assignment
				s(1).subs{1}=string(s(1).subs{1});
				[ind,name]=regexp(s(1).subs{1},"^[^\(\{]*","end","match");
				if isempty(ind)
					name=s(1).subs{1};
					subs="";
				else
					subs=extractBetween(s(1).subs{1},ind+1,strlength(s(1).subs{1}));
				end
				s(1).subs=paddata(s(1).subs,2,"fillvalue",{1});
				s_=evalin("caller","str2subs("""+subs+""")");
				try
					ret=prod(size(evalin("caller",s(1).subs{1}),s(1).subs{2}));
				catch
					if isempty(s_)||s_(end).type~="()"
						evalin("caller",s(1).subs{1}+"=[];");
						ret=prod(size(evalin("caller",s(1).subs{1}),s(1).subs{2}));
					else
						if ~isscalar(s_)
							try
								varname=join(string(evalin("caller","who")),"")+"a"+string(keyHash(randi(1000000)));
								assignin("caller",varname,s_(1:end-1));
								varname1=join(string(evalin("caller","who")),"")+"a"+string(keyHash(randi(1000000)));
								evalin("caller",varname1+"=subsref("+name+","+varname+");")
								evalin("caller",name+"=subsasgn("+name+","+varname+",[]);")
								evalin("caller",s(1).subs{1}+"=0;")
								ret=prod(size(evalin("caller",s(1).subs{1}),s(1).subs{2}));
								evalin("caller",name+"=subsasgn("+name+","+varname+","+varname1+");")
								evalin("caller","clear "+varname)
								evalin("caller","clear "+varname1)
							catch
								evalin("caller","clear "+varname)
								evalin("caller","clear "+varname1)
								try
									val=evalin("caller",name);
								end
								eval("val"+subs+"=0;");
								ret=prod(size(eval("val"+subs),s(1).subs{2}));
							end
						else
							try
								varname1=join(string(evalin("caller","who")),"")+"a"+string(keyHash(randi(1000000)));
								evalin("caller",varname1+"="+name+";")
								evalin("caller",name+"=[];")
								evalin("caller",s(1).subs{1}+"=0;")
								ret=prod(size(evalin("caller",s(1).subs{1}),s(1).subs{2}));
								evalin("caller",name+"="+varname1+";")
								evalin("caller","clear "+varname1)
							catch
								evalin("caller","clear "+varname1)
								val=[];
								eval("val"+subs+"=0;");
								ret=prod(size(eval("val"+subs),s(1).subs{2}));
							end
						end
					end
				end
			else
				s(1).subs=paddata(s(1).subs,2,"fillvalue",{1});
				ret=prod(size(s(1).subs{1},s(1).subs{2}));
			end
		case "()"
			try
				zsc.assert(isscalar(s))
			catch
				throw(MException(message("MATLAB:structRefFromNonStruct")))
			end
			ret=1;
	end
end