clear
close all;
% clc

NN = NeuralNetwork([28*28, 16, 16, 10]);
[images, labels] = MNIST('MNIST_data/','train',30);
n_o_data = length(labels);
solution = zeros(n_o_data,NN.n_o_outputs);
for i=1:n_o_data
	solution(i,labels(i)+1) = 1;
end
epsilon = 1e-2;
grad_C = gradDesc(NN.weights_biass,epsilon);
eta = epsilon/norm(grad_C);

% cost = quadrCost(images,solution,NN)
% randi()

% output = Outputs(NN,images(:,:,1));
% output = output'
% w = NN.weights_biass;
% w{1,1} = w{1,1}*0.5;
% NN.weights_biass = w;
% output2 = Outputs(NN,images(:,:,1));
% output2 = output2'

% exportWeightsAndBiases('firstTry2', w);
% 
% b = importWeightsAndBiases('firstTry');

% NeuralStructure = [3 2 1];
% NN = NeuralNetwork(NeuralStructure);
% output = Outputs(NN,[1 3 9]);

% w = init_weights([3 2 1]);

% imgs = [3 6 1 9 89 ...
% 	123 546 37 23 86 ...
% 	9999 2345 1462 12 2 ...
% 	291 9518 8321 1511 10000 ...
% 	910 1284 64 90 23];
% tic
% [images, labels] = MNIST('MNIST_data','train','all');
% toc
% 
% figure(1);
% for i=1:length(imgs)
% % 	figure('name',num2str(labels(i)));
% 	subplot(5,5,i)
% 	imshow(images(:,:,i),[0 255]);
% 	title(num2str(labels(i)));
% end

% fid = fopen('MNIST_data/train-images.idx3-ubyte','rb');%,'b','windows-1252');
% % A = fread(fid,1,'uint32','b');
% % [mgic,imgs,rws,clm] = fread(fid,4,'uint32','b');
% fileContent = fread(fid,'uint8');
% magicNumber = sum(bitshift(fileContent(1:4)', [24 16 8 0]));
% numberOfImages = sum(bitshift(fileContent(5:8)',[24 16 8 0]));
% numberOfRows = sum(bitshift(fileContent(9:12)',[24 16 8 0]));
% numberOfColumns = sum(bitshift(fileContent(13:16)',[24 16 8 0]));
% 
% image1 = zeros(numberOfRows,numberOfColumns);
% imageArray = fileContent(17:801);
% for i=1:784
% 	image1(i) = imageArray(i);
% end
% image1 = image1';
% imshow(image1);