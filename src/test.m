function [ accuracy ] = test(trainImages, trainLabels, testImages, ...
    testLabels, mean, eigenVectors, numEigen)
    
    
    subMeanTest = testImages - repmat(mean, 1, size(testImages, 2));
    subMeanTrain = trainImages - repmat(mean, 1, size(trainImages, 2));
    % sizes of train and test are image dimension * number of images
    
    useEigenV = eigenVectors(:, 1:numEigen);
    % size of eigenVectors is image dimension * number of used eigen vectors
    
    projectTest = subMeanTest' * useEigenV;
    projectTrain = subMeanTrain' * useEigenV;
    
    [numTest, projDim] = size(projectTest);
    [numTrain, projDim] = size(projectTrain);
    correctPred = 0;
    for i = 1: numTest
        test = projectTest(i,:); % i-th image
        
        % compute Euclidean distance to all train images.
        distances = sum((repmat(test, numTrain, 1) - projectTrain) .^ 2, 2);
        % size of distances is number of tainImages * 1;
        [minValue, minPos] = min(distances);
        
        prediction = trainLabels(minPos);
        groundTruth = testLabels(i);
        
        if prediction == groundTruth
            correctPred = correctPred + 1;
        end
    end
    accuracy = correctPred / numTest;
    % TODO: add image show of training or test examples.
end

