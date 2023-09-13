function A = CalculateLinearEqMatrix(times, dimX, dimY, precision)

sizeT = size(times);
A = zeros(sizeT(1), dimX * dimY);

for index = 1 : sizeT(1)
    pointMatrix = GetPointMatrixSimple(dimX, dimY, precision, times(index, 1), times(index, 3), times(index, 2), times(index, 4));
    pointMatrixSize = size(pointMatrix);
    dx = pointMatrix(pointMatrixSize(1), 1) - pointMatrix(1, 1);
    dy = pointMatrix(pointMatrixSize(1), 2) - pointMatrix(1, 2);
    for pindex = 1 : pointMatrixSize(1) - 1
        l = sqrt((pointMatrix(pindex, 1) - pointMatrix(pindex + 1, 1))^2 + (pointMatrix(pindex, 2) - pointMatrix(pindex + 1, 2))^2);
        %Lij(index) = l;
        indexX = pindex;
        indexY = pindex;
        if(dx < 0)
            indexX = pindex + 1;
        end
        if(dy < 0)
            indexY = pindex + 1;
        end
        i = pointMatrix(indexY, 4);
        if i > dimY
            i = dimY;
        end
        j = pointMatrix(indexX, 3);
        if j > dimX
            j = dimX;
        end
    
        A(index, (i - 1) * dimY + j) = l;
        %t = l / SpeedMatrix(PointMatrix(index, 4), PointMatrix(index, 3));
        %time = time + t;
    end
end