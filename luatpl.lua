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

local luatpl = {}
-- Solves the luatpl template.
-- @template_str Template specification (as string)
-- @template_input Template input content (as string)
function luatpl:solve(template_str, template_input)
  local pattern = '%[%!=?.-%!%]'
  local found = ''
  local i = 0
  local j = 0
  local ant = 0
  -- instanciation
  local out = template_input

  --validation
   -- out = out..'\n--validate\nrequire "check-luatpl"\n';
  out = out..'output_str = ""\n'
  --out = out.."\nif(not checkXTemplateIn()) then exit() end\n\n";

  while true do
    i,j = string.find(template_str, pattern, j+1);
    --print(i, j);
    if i == nil then break end
    found = string.sub(template_str, i, j);
    out = out.."local str = [["..string.sub(template_str, ant, i-1).."]];\n output_str = output_str .. str\n"
    if string.sub(found, 3, 3) == "=" then
      out = out.."output_str = output_str .. "..string.sub(found, 4, #found-2).."\n"
    else
      out = out..string.sub(found, 3, #found-2).."\n"
    end
    ant = j+1
  end
  out = out.."str = [["..string.sub(template_str, ant, #template_str).."]]\n output_str = output_str .. str\n"
  -- out = out.."return output_str"

  -- print lua file
  -- print(out)

  --exec file and generate final NCL
  assert(loadstring(out))()
  return output_str
end

return luatpl
