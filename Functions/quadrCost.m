function C = quadrCost(inputs,correct_output,NN)
%QUADRCOST Quadratic cost function
%   'inputs' must be an NxMxI array where I is the number of inputs

n_o_inputs = size(inputs,3);
NN_output = zeros(n_o_inputs,NN.n_o_outputs);
for i=1:n_o_inputs
	NN_output(i,:) = Outputs(NN,inputs(:,:,i));
end
Sigma = 0;
for i=1:n_o_inputs
	Sigma = Sigma + norm(NN_output(i,:)-correct_output(i,:))^2;
end
C = 1/(2*n_o_inputs)*Sigma;
end

