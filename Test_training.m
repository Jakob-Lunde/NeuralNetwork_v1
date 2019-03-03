[test_im,test_lab] = MNIST('MNIST_data','test','all');

guess = zeros(10000,1);

for i=1:10000
	output = Outputs(NN,test_im(:,:,i));
	[mx,inx] = max(output(:));
	guess(i) = inx-1;
end

isCorrect = eq(guess,test_lab');
correct_guesses = sum(isCorrect,'all')
correct_guesses_if_random = 10000/10
