require 'image'

local M = {}
function M.augmentateData(x,y)
  offsetx = x:size(1) -- number of rows before resizing
  offsety = y:size(1) --number of rows before resizing

  x:resizeAs(torch.Tensor(4000,3,8,8))
  y:resizeAs(torch.Tensor(4000,1,8,8))

  -- augmentating input
  k = 1
  for i=1, offsetx do -- row of the Tensor
    for z=1, 3 do
      for j=1, x:size(2) do -- column for the matrix (not_empty, empty, vertical)
        a = flip(x[i][j], z)
        x[offsetx + k][j] = a
      end
      k = k +1
    end
  end

  -- augmentating output
  o = 1
  for i=1, offsety do -- row of the Tensor
    for z=1, 3 do
      for j=1, y:size(2) do -- column for the matrix (output)
        a = flip(y[i][j], z)
        y[offsety + o][j] = a
      end
      o = o +1
    end
  end

  return x, y -- augmenteddata input and output
end

function flip(matrix, type)
    local result = torch.Tensor(8,8)
    if type == 1 then
      result = image.hflip(matrix)
    elseif type == 2 then
      result = image.vflip(matrix)
    elseif type == 3 then
      result = image.hflip(image.vflip(matrix))
    end
    return result;
end

return M
