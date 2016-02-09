function main( )
    DATA_DIR = '../MNIST/';
    DATA_FILE_NAME = [DATA_DIR, 'digits.mat'];
    
    [trainImages, trainLabels, testImages, testLabels] = readData(DATA_FILE_NAME);
    
    for trainNum = 100: 10: 200
        % pick trainNum of data for training
        [pickImages, pickLabels] = pickData(trainImages, trainLabels, trainNum);
        for featureMethod = 1:1 %TODO: use different feature extraction
            A = imageFeature(pickImages, featureMethod);
            
            [mean, eigenVector] = hw1FindEigendigits( A );
            %'compute eigenvectors over, begin test'
            
            testSet = imageFeature(testImages, featureMethod);
            
            
            for numEigen = 10:-1:10 
                %TODO: experiment of number of eigen vectors
                test(A, pickLabels, testSet, testLabels, mean, eigenVector, numEigen)
            end
        end
    end
end

