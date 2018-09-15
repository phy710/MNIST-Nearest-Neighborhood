clear;
close all;
clc;
load mnist_uint8.mat
tic;
trainData = double(train_x);
testData = double(test_x);
trainLabels = zeros(60000, 1);
testLabels = zeros(10000, 1);
for a = 1 : 60000
    trainLabels(a) = find(train_y(a, :)) - 1;
end
for a = 1 : 10000
    testLabels(a) = find(test_y(a, :)) - 1;
end
count = 0;
for a = 1 : 10000
    diff2 = sum((testData(a, :) - trainData(1, :)).^2);
    diff2Min = diff2;
    estimatedLabel = trainLabels(1);
    for b = 2 : 60000
        diff2 = sum((testData(a, :) - trainData(b, :)).^2);
        if diff2 < diff2Min
            diff2Min = diff2;
            estimatedLabel = trainLabels(b);
        end
    end
    if estimatedLabel == testLabels(a)
        count = count + 1;
    end
    disp(['Calculating...', num2str(a/100), '%']);
end
accuracy = count / 10000;
toc;
disp(['Test data accuracy: ', num2str(accuracy*100), '%']);