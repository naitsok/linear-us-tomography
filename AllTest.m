% this is comment to save in "master" branch for test diff "..."
% this is change for branch for test

%A added an empty line and this comment to test interactive adding
%number of transducers
numberOfTrans = 20;
%number of receivers
numberOfRec = 500;
%Sensor configuration
sensorConfig = 'circle';

%перевод в скорость и обратно
minSpeed = 1;
maxSpeed = 1.05;

%для обратной задачи сетка
dimX = 100;
dimY = 100;

precision = 1e-9;%eps('double') * 10;
alpha = 1e-11;

%save options
imageName = 'sample6';
dataDir = '.\Data\';
imageExt = '.bmp';

imagefile = strcat(dataDir, imageName, imageExt);

transArray = GenerateTransducers(numberOfTrans, sensorConfig);
%transArray = [0, 0.2; 0, 0.7; 0.3, 1; 0.8, 1; 1, 0.6; 1, 0.3; 0.7, 0; 0.2, 0];
%transArray = [0, 0; 0, 0.1; 0, 0.2; 0, 0.3; 0, 0.4; 0, 0.5; 0, 0.6; 0, 0.7; 0, 0.8; 0, 0.9; 0, 1;
%    0, 1; 0.1, 1; 0.2, 1; 0.3, 1; 0.4, 1; 0.5, 1; 0.6, 1; 0.7, 1; 0.8, 1; 0.9, 1; 1, 1];
%transArray = [0, 0; 0, 0.2; 0, 0.4; 0, 0.6; 0, 0.8; 0, 1;
%    0, 1; 0.2, 1; 0.4, 1; 0.6, 1; 0.8, 1; 1, 1];
%transArray = [0, 0; 0, 0.2; 0, 0.4; 0, 0.6; 0, 0.8; 0, 1;
%    1, 0; 1, 0.2; 1, 0.4; 1, 0.6; 1, 0.8; 1, 1];
recArray = GenerateReceivers(numberOfRec, sensorConfig);

[speedMatrixInput, minColor, maxColor] = GetSpeedFromImage(imagefile, minSpeed, maxSpeed);

Times = SolveDirectProblem(transArray, recArray, speedMatrixInput, precision);

A = CalculateLinearEqMatrix(Times, dimX, dimY, precision);

speedMatrixOutput = CalculateSpeedMatrix(A, Times, alpha, dimX, dimY, minSpeed, maxSpeed);

picture = GetImageFromSpeed(speedMatrixOutput, minColor, maxColor, minSpeed, maxSpeed);

% SAVE IMAGE
%make folder if not exist
saveImageDir = strcat(dataDir, imageName);
if (exist(saveImageDir, 'dir') == 0)
    mkdir(dataDir, imageName);
end
%generate image name
saveImageName = strcat(saveImageDir, '\', sensorConfig, '_');
saveImageName = strcat(saveImageName, num2str(numberOfTrans, '%d'), '_trans_', num2str(numberOfRec, '%d'), '_rec_');
saveImageName = strcat(saveImageName, num2str(alpha, '%10.2e'), '_alpha_');
saveImageName = strcat(saveImageName, num2str(minSpeed, '%.4f'), '_minSpeed_' ,num2str(maxSpeed, '%.4f'), '_maxSpeed_');
saveImageName = strcat(saveImageName, num2str(dimX, '%d'), '_dimX_' ,num2str(dimY, '%d'), '_dimY', imageExt);

%writename = '.\Data\sample_9_20_trans_alpha_1e-11_circle_speed_5%.bmp';
imwrite(picture, saveImageName);

figure;
sample = imread(imagefile);
subplot(1,2,1), image(picture)
subplot(1,2,2), image(sample)

%subplot(1,2,1), imagesc(speedMatrixOutput / max(speedMatrixOutput(:))), colormap(gray)
%subplot(1,2,2), imagesc(speedMatrixInput / max(speedMatrixInput(:))), colormap(gray)