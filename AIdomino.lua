require "nn"
require "csvreading.lua"


local convnet = nn.Sequential();

convnet:add(nn.SpatialConvolution(3, 64, 5, 5,1,1,2,2))
convnet:add(nn.ReLU())
convnet:add(nn.SpatialConvolution(64, 64, 3, 3,1,1,1,1))
convnet:add(nn.ReLU())
convnet:add(nn.SpatialConvolution(64, 64, 3, 3,1,1,1,1))
convnet:add(nn.ReLU())
convnet:add(nn.SpatialConvolution(64, 64, 3, 3,1,1,1,1))
convnet:add(nn.ReLU())
convnet:add(nn.SpatialConvolution(64, 64, 3, 3,1,1,1,1))
convnet:add(nn.ReLU())
convnet:add(nn.SpatialConvolution(64, 1, 3, 3,1,1,1,1))
--convnet:add(nn.View(9))
--convnet:add(nn.SoftMax())
--convnet:add(nn.View(3,3))



criterion = nn.MSECriterion()

for i = 1,2500 do

  local input = torch.DoubleTensor(3,3,3);
  local output = torch.DoubleTensor(1,3,3);

    -- Input
    input[1][1][1]=1
    input[1][1][2]=1
    input[1][1][3]=0
    input[1][2][1]=0
    input[1][2][2]=0
    input[1][2][3]=0
    input[1][3][1]=0
    input[1][3][2]=0
    input[1][3][3]=0

    input[2][1][1]=0
    input[2][1][2]=0
    input[2][1][3]=1
    input[2][2][1]=1
    input[2][2][2]=1
    input[2][2][3]=1
    input[2][3][1]=1
    input[2][3][2]=1
    input[2][3][3]=1

    input[3][1][1]=1
    input[3][1][2]=1
    input[3][1][3]=1
    input[3][2][1]=1
    input[3][2][2]=1
    input[3][2][3]=1
    input[3][3][1]=1
    input[3][3][2]=1
    input[3][3][3]=1


    --Output
     output[1][1][1]=0
     output[1][1][2]=0
     output[1][1][3]=0
     output[1][2][1]=0
     output[1][2][2]=1
     output[1][2][3]=0
     output[1][3][1]=0
     output[1][3][2]=1
     output[1][3][3]=0

  criterion:forward(convnet:forward(input), output [1])


  convnet:zeroGradParameters()
  convnet:backward(input, criterion:backward(convnet.output, output))
  convnet:updateParameters(0.01)

end

x = torch.Tensor(3,3,3)
    x[1][1][1]=1
    x[1][1][2]=1
    x[1][1][3]=0
    x[1][2][1]=0
    x[1][2][2]=0
    x[1][2][3]=0
    x[1][3][1]=0
    x[1][3][2]=0
    x[1][3][3]=0

    x[2][1][1]=0
    x[2][1][2]=0
    x[2][1][3]=1
    x[2][2][1]=1
    x[2][2][2]=1
    x[2][2][3]=1
    x[2][3][1]=1
    x[2][3][2]=1
    x[2][3][3]=1

    x[3][1][1]=1
    x[3][1][2]=1
    x[3][1][3]=1
    x[3][2][1]=1
    x[3][2][2]=1
    x[3][2][3]=1
    x[3][3][1]=1
    x[3][3][2]=1
    x[3][3][3]=1

print('Test 1: Case 3')
print(convnet:forward(x))
