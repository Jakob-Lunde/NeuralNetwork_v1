function w = importWeightsAndBiases(filename)
%IMPORTWEIGHTSANDBIASES Summary of this function goes here
%   Detailed explanation goes here
S = load(filename,'cellArray');
w = S.cellArray;
end

