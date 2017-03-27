local M = {}

function string:splitAtCommas()
  local sep, values = ",", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern,
	function(c)
		values[#values+1] = c
	end)
  return values
end

function M.loadData(dataFile)
  local dataset = {}
  i = 1
  local x = torch.Tensor(1000,3,8,8) -- input values

  local y = torch.Tensor(1000,8,8) -- output values
  for line in io.lines(dataFile) do
    local values = line:splitAtCommas()
    --print(values)
    count = 1
  	for v=1,3 do
  		for u=1,8 do
  			for t=1,8 do
  				x[i][v][u][t] = values[count]
  				count = count +1
      	end
  		end
  	end

  	for u=1,8 do
  		for t=1,8 do
  			y[i][u][t] = values[count]
  			count = count +1
  	  end
  	end

    i = i + 1
    if i==1001 then
    	break
    end
  end

  function dataset:size()
    return (i - 1)
    end

  -- save into textfile / Task 3.1
  torch.save("data/input.txt", x, "ascii")
  torch.save("data/output.txt", y, "ascii")
end

return M
