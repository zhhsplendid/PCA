function [accuracy] = main( )
    DATA_DIR = '../MNIST/';
    DATA_FILE_NAME = [DATA_DIR, 'digits.mat'];
    
    % for experiments, we use 100, 150, 200, ...  images to train
    NUMBER_FOR_TRAIN = 250:50:600; 
    % for experiments, we use 10, 20, ...  eigen values to show result.
    NUMBER_FOR_EIGEN = 10:10:80;
    
    accuracy = zeros(length(NUMBER_FOR_TRAIN), length(NUMBER_FOR_EIGEN));
    
    [trainImages, trainLabels, testImages, testLabels] = readData(DATA_FILE_NAME);
    
    for i = 1:length(NUMBER_FOR_TRAIN)
        trainNum = NUMBER_FOR_TRAIN(i);
        % pick how many data we need for training and convert 3d images to 1d vectors
        [pickImages, pickLabels] = pickData(trainImages, trainLabels, trainNum);
        
        A = imageFeature(pickImages);
            
        [mean, eigenVector] = hw1FindEigendigits( A );
        %'compute eigenvectors over, begin test'
        for j = 1:length(NUMBER_FOR_EIGEN)
            numEigen = NUMBER_FOR_EIGEN(j);            
            accuracy(i, j) = test(pickImages, pickLabels, testImages, testLabels, mean, eigenVector, numEigen);
            fprintf(['train on ', num2str(trainNum) ,' images\n']);
            fprintf(['use ', num2str(numEigen) ,' eigenvector\n']);
            fprintf(['accuracy = ', num2str(accuracy(i, j)), '\n']);
        end
    end
    
    % generate 3d plot
    [x, y] = meshgrid(NUMBER_FOR_EIGEN, NUMBER_FOR_TRAIN);
    mesh(x, y, accuracy);
end

