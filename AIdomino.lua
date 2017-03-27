require "nn"

function main()

  local csvreader = require "csvreading"
  local dataaugmenter = require "dataaugmentation"

  local function setUp()
    --load data from CSV file
    csvreader.loadData("data/domineering.csv")
    x = torch.load("data/input.txt", "ascii")
    y = torch.load("data/output.txt", "ascii")
    -- augmentate training data
    input, output = dataaugmenter.augmentateData(x, y)
    print("Data has been augmented")
    torch.save("data/augmentedinputdata.txt", input, "ascii")
    torch.save("data/augmentedoutputdata.txt", output, "ascii")
  end

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

  setUp()

  for i = 1,num_rows do
      error = criterion:forward(convnet:forward(input[i]), output[i])
      convnet:zeroGradParameters()
      convnet:backward(input[i], criterion:backward(convnet.output, output[i]))
      convnet:updateParameters(0.01)
  end

  print("Total error after 4000 iterations:"..error)
end

main()
