function [image,label] = MNIST(folderDirectory,whatData,whichData)
%MNIST A simple function for accessing the MNIST data
%   The MNIST-files must be de-compressed and stored in the same directory.
%   The files must also exlude the .gz-extension.
%	
%	How to use:
%	
%	The function returns a set of images and their corresponding labels as
%	two arrays. The 'image'-array is 28x28xN (N = number of images) and the
%	'label'-array is 1xN (where the index 'N' is the label for image number
%	N).
%	
%	Input arguments:
%	folderDirectory ->	a string containing the directory of the files
%	whatData		->	a string, either 'train' or 'test', specifing
%						whether to handle the training data or the testing data
%	whichData		->	specify which/how many images and labels to return.
%						Options are: 
%						*The string 'all' (returns all the images and
%						labels)
%						*A number n (i.e. a 1x1 array) (returns the n first
%						images and labels)
%						*An array containing numbers between 1 and the
%						number of images in the dataset (returns the images
%						and labels corresponding to each number in the
%						array)
%% Opening files
if nargin < 2 || isempty(whatData)
	whatData = 'train'; 
	disp("Warning: arg 'whatData' missing. Defaulting to training data");
end
if ~ischar(folderDirectory)
	disp("Warning: arg 'folderDirectory' must be a string. Using current directory");
	folderDirectory = '';
elseif folderDirectory(end) ~= '/'
	disp("Warning: arg 'folderDirectory' must end with an '/'. Appending one now");
	folderDirectory(end+1) = '/';
end

filesToOpen = strcmp(whatData,{'test','train'});
if sum(filesToOpen(1:end)) == 0
	disp("Error: no valid string for 'whatData'");
	return
end
if filesToOpen(2)
	file_ids(1) = fopen([folderDirectory,'train-images.idx3-ubyte'],'rb');
	file_ids(2) = fopen([folderDirectory,'train-labels.idx1-ubyte'],'rb');
elseif filesToOpen(1)
	file_ids(1) = fopen([folderDirectory,'t10k-images.idx3-ubyte'],'rb');
	file_ids(2) = fopen([folderDirectory,'t10k-labels.idx1-ubyte'],'rb');
end

%% Reading files
% reading metadata
imMetaData = fread(file_ids(1),4,'uint32','b');
labMetaData = fread(file_ids(2),2,'uint32','b');
nImgs = imMetaData(2);
rows = imMetaData(3);
columns = imMetaData(4);
nLabs = labMetaData(2);
if nImgs ~= nLabs
	disp("Error: number of images and number of labels do not match");
	return;
end

% reading file content
imgData = fread(file_ids(1),'uint8');
labData = fread(file_ids(2),'uint8');

% which data
if nargin < 3 || isempty(whichData), whichData = 'all'; end
if strcmp(whichData,'all')
	imgsToRead = nImgs; 
	whichData = 1:nImgs;
end
if length(whichData) == 1
	imgsToRead = whichData;
	whichData = 1:imgsToRead;
else
	imgsToRead = length(whichData); 
end
% storing bytes into image arrays
imgOffs = rows*columns;
image = -ones(rows,columns,imgsToRead);
label = -ones(1,imgsToRead);
tempImg = zeros(rows,columns);
for i=1:imgsToRead
	imgNumber = whichData(i);
	byteIndex = (imgNumber-1)*imgOffs+1;
	imgArr = imgData(byteIndex:(byteIndex+imgOffs-1));
	for n=1:imgOffs
		tempImg(n) = imgArr(n);
	end
	tempImg = tempImg';
	image(:,:,i) = tempImg;
	label(i) = labData(imgNumber);
	tempImg = tempImg';
end

%% Inverting the colours of the images
% 0 is white in MNIST, but is black in a grayscale image
for i=1:imgsToRead
	image(:,:,i) = 255-image(:,:,i);
end
%% Closing files
fclose(file_ids(1));
fclose(file_ids(2));