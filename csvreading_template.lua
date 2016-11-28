function string:splitAtCommas()
  local sep, values = ",", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern,
      function(c)
        values[#values+1] = c
      end
  )
  print(#values)
  break
  return values
end

function loadData(dataFile)
  local dataset = {}
  i = 1
  for line in io.lines(dataFile) do
    local values = line:splitAtCommas()
    local y = torch.Tensor(1) -- torch.Tensor(1) before
    y[y] = values[#values] -- the target class is the last number in the line
    values[#values] = nil
    local x = torch.Tensor(values) -- the input data is all the other numbers
    dataset[i] = {x, y}
    i = i + 1
  end
  function dataset:size() return (i - 1) end -- the requirement mentioned
  return dataset
end
