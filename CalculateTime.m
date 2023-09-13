function time = CalculateTime(pointMatrix, speedMatrix)

%A added an empty line and this comment to test interactive adding
%Lij = zeros(1, size(pointMatrix) - 1);
speedMatrixSize = size(speedMatrix);

%Tij = zeros(1, size(pointMatrix) - 1);
pointMatrixSize = size(pointMatrix);

dx = pointMatrix(pointMatrixSize(1), 1) - pointMatrix(1, 1);
dy = pointMatrix(pointMatrixSize(1), 2) - pointMatrix(1, 2);

time = 0;

for index = 1 : pointMatrixSize(1) - 1
    %dx = pointMatrix(index, 1) - pointMatrix(index + 1, 1);
    %dy = pointMatrix(index, 2) - pointMatrix(index + 1, 2);
    indexX = index;
    indexY = index;
    if(dx < 0)
        indexX = index + 1;
    end
    if(dy < 0)
        indexY = index + 1;
    end
    l = sqrt((pointMatrix(index, 1) - pointMatrix(index + 1, 1))^2 + (pointMatrix(index, 2) - pointMatrix(index + 1, 2))^2);
    
    %Lij(index) = l;
    %t = l / speedMatrix(pointMatrix(indexY, 4), pointMatrix(indexX, 3));
    i = pointMatrix(indexY, 4);
    if i > speedMatrixSize(1)
        i = speedMatrixSize(1);
    end
    j = pointMatrix(indexX, 3);
    if j > speedMatrixSize(2)
        j = speedMatrixSize(2);
    end
    t = l / speedMatrix(i, j);
    time = time + t;
end