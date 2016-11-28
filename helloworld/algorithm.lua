require 'nn'

mlp = nn.Sequential()

inputSize = 10
hiddenLayer1Size = 10
hiddenLayer2Size = 10

print(string.format('hiddenLayer1Size: %d', hiddenLayer1Size))
print(string.format('hiddenLayer2Size: %d', hiddenLayer2Size))

mlp:add(nn.Linear(inputSize, hiddenLayer1Size))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(hiddenLayer1Size, hiddenLayer1Size))
mlp:add(nn.Tanh())

nclasses = 2

mlp:add(nn.Linear(hiddenLayer2Size, nclasses))
mlp:add(nn.LogSoftMax())

out = mlp:forward(torch.randn(1,10))
print(out)

criterion = nn.ClassNLLCriterion()
trainer = nn.StochasticGradient(mlp, criterion)
trainer.learningRate = 0.01

trainer:train(dataset)

x = torch.randn(10)
y = mlp:forward(x)
print(y)
