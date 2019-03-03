function exportWeightsAndBiases(filename,cellArray)
%EXPORTWEIGHTSANDBIASES Summary of this function goes here
%	Detailed explanation goes here
if ~ischar(filename)
	filename = 'weightsAndBiases.mat';
elseif ~strcmp(filename((end-3):end),'.mat')
	filename(end+1:end+4) = '.mat';
end
save(filename,'cellArray');
end

