function gradDesc(inputs,correct_output,NN,epsilon)
%GRADDESC Needs a better name
%   Finds the gradient descent vector (based on a step-size epsilon) and
%   finds the learing rate eta and alters (trains) the weights/biases
if nargin < 4 || isempty(epsilon)
	epsilon = 1e-2;	% "step-size" for deltaV
end
weights_biass = NN.weights_biass;
n_o_layers = length(weights_biass);	% Actual total number is this +1
n_o_wb = 0;	% Init counter for number of weights and biases
for i=1:n_o_layers
	wb_in_layer(i) = size(weights_biass{i},2);
	neurons_in_layer(i) = size(weights_biass{i},1);
	n_o_wb = n_o_wb + wb_in_layer(i)*neurons_in_layer(i);
end
C_0 = quadrCost(inputs,correct_output,NN);	% initial cost
% initialize/preallocate some variables before loop
grad_C = zeros(1,n_o_wb);
current_layer = 1;
current_neuron = 1;
current_wb = 1;
for i=1:n_o_wb
	% Nested ifs are for indexing the weight/bias to be altered
	if current_wb > wb_in_layer(current_layer)
		current_wb = 1;
		current_neuron = current_neuron + 1;
		if current_neuron > neurons_in_layer(current_layer)
			current_neuron = 1;
			current_layer = current_layer + 1;
% 			if current_layer > n_o_layers
% 				disp("check for-loop/if-statements");
% 			end
		end
	end
	% altering weight/bias number 'i'
	temp_wb = weights_biass{current_layer};
	temp_wb(current_neuron,current_wb) = temp_wb(current_neuron,current_wb) + epsilon;
	weights_biass{current_layer} = temp_wb;
	NN.weights_biass = weights_biass;
	
	C = quadrCost(inputs,correct_output,NN);
	grad_C(i) = (C-C_0)/epsilon;
	
	% alter weight/bias back again
	temp_wb(current_neuron,current_wb) = temp_wb(current_neuron,current_wb) - epsilon;
	weights_biass{current_layer} = temp_wb;
	NN.weights_biass = weights_biass;
	
	current_wb = current_wb + 1;
end

eta = epsilon/norm(grad_C);
delta_v = -eta.*grad_C;
% Similar for-loop as before, but now for changeing the weights/biases
current_layer = 1;
current_neuron = 1;
current_wb = 1;
for i=1:n_o_wb
	% Nested ifs are for indexing the weight/bias to be altered
	if current_wb > wb_in_layer(current_layer)
		current_wb = 1;
		current_neuron = current_neuron + 1;
		if current_neuron > neurons_in_layer(current_layer)
			current_neuron = 1;
			current_layer = current_layer + 1;
% 			if current_layer > n_o_layers
% 				disp("check for-loop/if-statements 2");
% 			end
		end
	end
	% altering weight/bias number 'i'
	temp_wb = weights_biass{current_layer};
	temp_wb(current_neuron,current_wb) = temp_wb(current_neuron,current_wb) + delta_v(i);
	weights_biass{current_layer} = temp_wb;
	NN.weights_biass = weights_biass;
	
	current_wb = current_wb + 1;
end
end

