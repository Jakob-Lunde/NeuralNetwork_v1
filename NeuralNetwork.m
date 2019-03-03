classdef NeuralNetwork
	%NEURALNETWORK An object containing all the neurons and weights and
	%biases your heart desires
	%   Also you can give it an input (obviously), and it returns an output
	%   (which should also be quite obvious)
	
	properties
		neurons_
		n_o_layers
		input_layer
		n_o_inputs
		output_layer
		n_o_outputs
		weights_biass
	end
	
	methods
		function obj = NeuralNetwork(neurons)
			%NEURALNETWORK Construct a 'blank' neural network with randomly
			%assigned weights and biases
			%   Input argument 'neurons' must be a vector where the
			%   value in each element is the number of neurons in each
			%   layer. The first element is the input layer, and the last
			%   element is the output layer
			obj.neurons_ = neurons;
			obj.n_o_layers = length(obj.neurons_);
			obj.input_layer = zeros(1,obj.neurons_(1));
			obj.n_o_inputs = length(obj.input_layer);
			obj.output_layer = zeros(1,obj.neurons_(end));
			obj.n_o_outputs = length(obj.output_layer);
% 			if obj.n_o_layers < 2, disp('Error: too few layers'); end
			weights_biass = cell(1,obj.n_o_layers-1);
			for i=2:obj.n_o_layers
				nPreLay = obj.neurons_(i-1);
				w = randn(obj.neurons_(i),nPreLay+1);
				weights_biass(1,(i-1)) = {w};
			end
			obj.weights_biass = weights_biass;
		end
		function outputs = Outputs(obj, inputs)
			%OUTPUTS Does the neural network thingy
% 			for i=1:obj.n_o_inputs
% 				obj.input_layer(i) = inputs(i);
% 			end
% 			t_map_in = tic;
			obj.input_layer = inputs(:)';
% 			t_map_in_toc = toc(t_map_in)
			preLayer = sigmoid(obj,obj.input_layer);
% 			t_all_neurons = tic;
			for i=2:obj.n_o_layers
				n_o_neurons = obj.neurons_(i);
				neuron = zeros(1,n_o_neurons);
				weights = obj.weights_biass{1,(i-1)};
				for n=1:n_o_neurons
					w = weights(n,1:(end-1));
					neuron(n) = sum(w.*preLayer) + weights(end);
				end
				neuron = sigmoid(obj,neuron);
				preLayer = neuron;
			end
			outputs = neuron;
% 			t_all_neurons_toc = toc(t_all_neurons)
		end
		function sig = sigmoid(~,in)
			sig = 1./(1+exp(in));
		end
	end
end

