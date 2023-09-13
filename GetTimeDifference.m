%number of transducers
numberOfTrans = 8;
%number of receivers
numberOfRec = 310;
%Sensor configuration
sensorConfig = 'circle';

%перевод в скорость и обратно
minSpeed = 1;
maxSpeed = 1.05;

%для обратной задачи сетка
dimX = 50;
dimY = 50;

precision = 1e-9;%eps('double') * 10;
alpha = 1e-11;

% image without object
noobjImage = 'no_sample';

%save options
imageName = 'sample5';
dataDir = '.\Data\';
imageExt = '.bmp';

imagefile = strcat(dataDir, imageName, imageExt);
noobjImage = strcat(dataDir, noobjImage, imageExt);

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

[speedMatrixInput, minColor, maxColor] = GetSpeedFromImage(noobjImage, minSpeed, maxSpeed);

TimesNoObject = SolveDirectProblem(transArray, recArray, speedMatrixInput, precision);

TimesDiff = (TimesNoObject - Times);

AllTimes = [TimesNoObject(:, 5), Times(:, 5), TimesDiff(:, 5), 100 * TimesDiff(:, 5) ./ TimesNoObject(:, 5)];