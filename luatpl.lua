--[[
  luatpl allows you to embed Lua scripts to produce text files.
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

-- instanciation
file = io.input(arg[2])
out = io.read("*all")
out = out.."\nf = io.open('out.ncl', 'w');\n"

--validation
out = out..'\n--validate\nrequire "check-luatpl"\n';
--out = out.."\nif(not checkXTemplateIn()) then exit() end\n\n";

io.close(file)

-- read template file
print("### XTemplate based in Lua scripts built-in ###");
print("### Developed by Roberto Azevedo (robertogerson@telemidia.puc-rio.br) ###");

print("\nRunning with \n# Template file  = "..arg[1].." and \n# Input file = "..arg[0]);

file = io.input(arg[1]);
fileStr = io.read("*all");

pattern = '%[%!=?.-%!%]'
found = ''
i = 0
j = 0
ant = 0

print("\tStep 1 from 3. Parsing template file ...");
while true do
	i,j = string.find(fileStr, pattern, j+1);
--	print(i, j);
	if i == nil then break end
	found = string.sub(fileStr, i, j);
	out = out.."str = [["..string.sub(fileStr, ant, i-1).."]];\nf:write(str)\n"
	if string.sub(found, 3, 3) == "=" then
		out = out.."f:write("..string.sub(found, 4, #found-2)..");\n"
	else
		out = out..string.sub(found, 3, #found-2).."\n"
	end
	ant = j+1
end
out = out.."str = [["..string.sub(fileStr, ant, #fileStr).."]]\n f:write(str)\n"

out = out.."\nf:flush(); f:close();\n"

print("\tStep 2 from 3. Validating input file...");
print("\tStep 3 from 3. Generating output file = out.ncl");

-- print lua file
-- print(out)

--exec file and generate final NCL
assert(loadstring(out))()
io.close(file);
print("## DONE");
