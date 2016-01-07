--[[
  luatpl allows you to embed Lua scripts to produce text files.
   Copyright (C) 2009,2014 Bruno Lima, Carlos de Salles and Roberto Azevedo

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

local LUATPL = require("luatpl")

-- Main function
function main()
  -- read template file
  print("### Templates based in Lua scripts built-in ###");
  print("### Developed by Roberto Azevedo (robertogerson@telemidia.puc-rio.br) ###");

  print("\nRunning with \n# Template file  = "..arg[2].." and \n# Input file = "..arg[1]);

  -- Open and read the template specification file.
  local file = io.open(arg[1]);
  local template_str = file:read("*all");
  file:close(file)

  -- Open and read the template input file.
  file = io.open(arg[2])
  local template_input = file:read("*all")
  file:close()

  print("\tStep 1 from 3. Parsing template file ...");

  -- calls the main function to solve luatpl template.
  local solved = LUATPL:solve ( template_str, template_input)

  print("\tStep 2 from 3. Validating input file...");

  print("\tStep 3 from 3. Generating output file = out.ncl");
  file = io.open("out.ncl", "w")
  file:write(solved)
  file:flush()
  file:close()
  print("## DONE");
end

-- Start the program
main()

