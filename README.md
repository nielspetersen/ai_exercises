# Code proposals in regard to the course "Artificial Intelligence for Knowledge Discovery"

**1. Three-Level XOR**
```lua
mlp = nn.Sequential() -- container for the network

inputs = 2; -- input layer
outputs = 1; -- output layer
HUs = 20; -- hidden layer

-- create the network with hidden layer
mlp:add(nn.Linear(inputs, HUs))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(HUs, outputs))

criterion = nn.MSECriterion() -- loss function
```
Within `threelevelxor.lua` a small implementation of a neural network is provided for solving the 3-Level-XOR problem. 

**2. Monte Carlo Domineering**

The file  `AIdomino.lua` contains the implementation of the Domineering problem in Torch.
It includes:
* the implementation of the neural network itself 
```lua
local convnet = nn.Sequential()
  local nplanes = 64 -- hidden nodes
  local num_rows = 4000 -- total number of training cases

  convnet:add(nn.SpatialConvolution(3, nplanes, 5, 5,1,1,2,2))
  convnet:add(nn.ReLU())
  convnet:add(nn.SpatialConvolution(nplanes, nplanes, 3, 3,1,1,1,1))
  convnet:add(nn.ReLU())
  convnet:add(nn.SpatialConvolution(nplanes, nplanes, 3, 3,1,1,1,1))
  convnet:add(nn.ReLU())
  convnet:add(nn.SpatialConvolution(nplanes, nplanes, 3, 3,1,1,1,1))
  convnet:add(nn.ReLU())
  convnet:add(nn.SpatialConvolution(nplanes, nplanes, 3, 3,1,1,1,1))
  convnet:add(nn.ReLU())
  convnet:add(nn.SpatialConvolution(nplanes, 1, 3, 3,1,1,1,1))
  convnet:add(nn.View(64))
  convnet:add(nn.SoftMax())
  convnet:add(nn.View(8,8))

  criterion = nn.MSECriterion()
  error = 1
```

* the generation of training and test data (see `dom.java` and `domineering.csv`)
* the import of the training and test data (see `csvreading.lua`)

```lua 
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

```

* and the data augmentation (see `dataaugmentation.lua`)
  * for increasing the accuray of the neural network
  
via horizontal, vertical or a combined flip
```lua
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
```
  
**3. Results**

This implementations achieves a good accuracy with a total error of approx. `0.015381567763701` after 4000 iterations. 
