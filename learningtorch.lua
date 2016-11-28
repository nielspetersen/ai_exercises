function addTensors(a,b)
    return a + b
end

a = torch.ones(5,2)
b = torch.Tensor(2,5):fill(4)
print(addTensors(a,b))
