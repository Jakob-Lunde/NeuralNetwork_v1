% close all
clear

NN = NeuralNetwork([28*28, 16, 16, 10]);

[images, labels] = MNIST('MNIST_data/','train',14000);
n_o_data = length(labels);
solution = zeros(n_o_data,NN.n_o_outputs);
for i=1:n_o_data
	solution(i,labels(i)+1) = 1;
end

% cost1 = quadrCost(images,solution,NN);
% gradDesc(images(:,:,1:10),solution(1:10,1),NN);
% gradDesc(images(:,:,11:20),solution(11:20,1),NN)
% cost2 = quadrCost(images,solution,NN);
% change = cost2-cost1



% tic
% out = NN.Outputs(images(:,:,i));
% toc


% tic
% gradDesc(images(:,:,1),solution(1,:),NN);
% toc % time it takes for the NN to calculate an output 13003 times 
% % (it needs to do it 780180000 times to run through all the training data)


mini_batch = 100;
n_o_batches = 140;	% a lie waiting to happen

for i=1:n_o_batches
	a = i*mini_batch-mini_batch+1;
	b = a+mini_batch-1;
	gradDesc(images(:,:,a:b),solution(a:b,:),NN);
end