--[[
  luatpl Embeded allows you to embed Lua scripts to produce text files.
   Copyright (C) 2009 Bruno Lima, Carlos de Salles and Roberto Azevedo

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]
function exec_string(str)
 	return assert(loadstring(str))()
end

function checkTemplateIn ()
	local type;
	local error = false;
	for elementName, v in pairs(vocabulary) do
		print("\nElement = "..elementName);
		for t, value in pairs (v) do
			if(t == "type") then
				type = value;		
			end
			-- cardinality
				if (t == "min" ) then
					local str = "return #"..elementName.." >= "..value;
--					print ("checking cardinality - ", str );
					local x = exec_string(str);
					if( not x ) then
						error = true;
						 print("Number of element "..elementName.." must be at least "..value..".");
					end
				else 
					if ( t == "max" ) then
						local str = "return #"..elementName.." <= "..value;
						if(not (value == "unbounded")) then
--							print ("checking cardinality - ", str)
							local x = exec_string(str);
							if( not t ) then
								error = true;
								print("Number of element "..elementName.." must be "..value.."at the most.");
							end
						end
					end
					
				end
			--end cardinality

			-- check attributes
			if(t == "attrs") then
--				print ("Attributes = ");
				for t, descAttr in pairs(value) do
					for attrName, attrValue in pairs(descAttr) do
--						print(attrName, attrValue);
					end
				end
			else 
--				print (t, value);
			end
		end
	end
	return error;
end

--checkTemplateIn()
