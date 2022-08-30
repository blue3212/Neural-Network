using StatsFuns;
using Distributions;
#code does stuff
#another comment
function newtonTrain()

    w1 = [0.1;0.1];
    b1 = [0.1 0.1];


    trainSize = 10000000
    data = zeros(trainSize,3);
    data[1:trainSize,1:2] = rand(Uniform(-1,1),(trainSize,2));
    for i in 1:trainSize
        data[i,1] = round(data[i,1],digits = 2)
        data[i,2] = round(data[i,2],digits = 2)
        data[i,3] = (data[i,1] + data[i,2])/2;
    end



    dataTest = zeros(100,3);
    dataTest[1:100,1:2] = rand(Uniform(-1,1),(100,2));
    for i in 1:100
        data[i,1] = round(data[i,1],digits =2)
        data[i,2] = round(data[i,2],digits =2)
        dataTest[i,3] = (dataTest[i,1] + dataTest[1,2])/2;
    end
    bcosts = [];
    for i in 1:100
        input = reshape(dataTest[i,1:2],(1,2))
        calculated = logistic.(input*w1 .+b1)[1];
        expected = dataTest[i,3];
        cost = 0.5*((expected-calculated)^2);
        push!(bcosts,cost);
    end
    costs = [];
    n = size(data,1);
    while(n > 0)
        input = reshape(data[n,1:2],(1,2))
        calculated = logistic.(input*w1 .+b1)[1]
        z2 = input*w1.+b1[1];

        expected = data[n,3];
        cost = 0.5*((expected-calculated)^2);

        #newtonBackprobagation
        dc = expected-calculated;
        sigPrimez2 = logisticPrime.(z2)[1]
        w1Adjust = dc*sigPrimez2*(input)'
        b1Adjust = dc*sigPrimez2
        push!(costs,cost);
        

        w1 = w1 .+ w1Adjust
        b1 = b1 .+ b1Adjust
        
        n -=1;
    end

    acosts = [];


    for i in 1:100
        input = reshape(dataTest[i,1:2],(1,2))
        calculated = logistic.(input*w1 .+b1)[1];
        expected = dataTest[i,3];
        cost = 0.5*((expected-calculated)^2);
        push!(acosts,cost);
    end

    return w1,b1,w2,b2,cost;
end



function network(w1,b1,w2,b2,input)
    result = ((input[1:2]*w1+b1)*w2)+b2;

end

function newtonBackprobagation(w1,b1,w2,b2,input)
    z1 = input *w1 +b1;
end

function Levenberg()

end

function logisticPrime(x)
    x = logistic(x);
    return x*(x+1);
end