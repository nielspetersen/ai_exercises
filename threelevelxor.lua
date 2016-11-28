require "nn"

mlp = nn.Sequential() -- container for the network


inputs = 2;
outputs = 1;
HUs = 20;

-- create the network with hidden layer
mlp:add(nn.Linear(inputs, HUs))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(HUs, outputs))

criterion = nn.MSECriterion()

for i = 1,20000 do
  local input = torch.Tensor(4, 2);
  local output = torch.Tensor(4);

  input[1][1] = 1;
  input[2][1] = 0;

  input[3][1] = 1;
  input[4][1] = 0;

  input[1][2] = 1;
  input[2][2] = 1;

  input[3][2] = 0;
  input[4][2] = 0;

  output[1] = 0;
  output[2] = 1;
  output[3] = 1;
  output[4] = 0;

  criterion:forward(mlp:forward(input), output)

  mlp:zeroGradParameters()
  mlp:backward(input, criterion:backward(mlp.output, output))
  -- update the parameters with a 0.01 learning rate
  mlp:updateParameters(0.01)
end

x = torch.Tensor(2)
x[1] =  1; x[2] =  1; print(mlp:forward(x))
x[1] =  1; x[2] = 0; print(mlp:forward(x))
x[1] = 0; x[2] =  1; print(mlp:forward(x))
x[1] = 0; x[2] = 0; print(mlp:forward(x))
