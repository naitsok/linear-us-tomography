function pointMatrix = GetPointMatrixSimple(dimX, dimY, precision, x0, x1, y0, y1)


%dimentions
%dimX = 500;
%dimY = 500;
%precision = 1e-9;%eps('double') * 10;%1e-6;eps

%x0 = 0.5;%0.501;
%y0 = 1;%0;
%x1 = 1;%0.607;
%y1 = 0.99;%1;

dx = 1 / dimX;
dy = 1 / dimY;

rowNum = floor(x0 / abs(dx));
colNum = floor(y0 / abs(dy));

%if abs(x0 - 1) < precision
%    rowNum = rowNum - 1;
%end

%if abs(y0 - 1) < precision
%    colNum = colNum - 1;
%end

A = [x0, y0, rowNum + 1, colNum + 1];
pointMatrix = [x0, y0, rowNum + 1, colNum + 1];
if abs(x0 - x1) < precision
    y = colNum * dy;
    dy = sign(y1 - y0) * dy;
    index = 1;
    while abs(y - y1) > abs(dy)
        y = y + dy;
        pointMatrix(index + 1, 1) = x0;
        pointMatrix(index + 1, 2) = y;
        pointMatrix(index + 1, 3) = rowNum + 1;
        pointMatrix(index + 1, 4) = floor(y * dimY + precision / dimY) + 1;
        index = index + 1;
    end
    pointMatrix(index + 1, 1) = x0;
    pointMatrix(index + 1, 2) = y1;
    pointMatrix(index + 1, 3) = rowNum + 1;
    pointMatrix(index + 1, 4) = floor(y1 * dimY + precision / dimY) + 1;

elseif abs(y0 - y1) < precision
    x = rowNum * dx;
    dx = sign(x1 - x0) * dx;
    index = 1;
    while abs(x - x1) > abs(dx)
        x = x + dx;
        pointMatrix(index + 1, 1) = x;
        pointMatrix(index + 1, 2) = y0;
        pointMatrix(index + 1, 3) = floor(x * dimX + precision / dimX) + 1;
        pointMatrix(index + 1, 4) = colNum + 1;
        index = index + 1;
    end
    pointMatrix(index + 1, 1) = x1;
    pointMatrix(index + 1, 2) = y0;
    pointMatrix(index + 1, 3) = floor(x1 * dimX + precision / dimX) + 1;
    pointMatrix(index + 1, 4) = colNum + 1;
else

    k = (y1 - y0) / (x1 - x0);

    dx = sign(x1 - x0) * dx;
    dy = sign(y1 - y0) * dy;

    x = 0;
    if (dx < 0)
        x = rowNum * abs(dx);
        if (x0 == x)
            x = x - abs(dx);
        end
    end
    if (dx > 0)
        x = rowNum * abs(dx) + dx;
    end

    y = 0;
    if (dy < 0)
        y = colNum * abs(dy);
        if (y0 == y)
            y = y - abs(dy);
        end
    end
    if (dy > 0)
        y = colNum * abs(dy) + dy;
    end

    %A = [x0, y0, rowNum, colNum];
    index = 1;
    while 1
        if abs(x - x1) < abs(dx) - precision
            break;
        end
        
        tempY = A(index, 2) + (x - A(index, 1)) * k;
        A(index + 1, 1) = x;
        A(index + 1, 2) = tempY;
        A(index + 1, 3) = floor(x * dimX + precision / dimX) + 1;
        A(index + 1, 4) = floor(tempY * dimY + precision / dimY) + 1;
        
        index = index + 1;
        x = x + dx;
    end
    
    A(index + 1, 1) = x0; A(index + 1, 2) = y0; 
    A(index + 1, 3) = rowNum + 1; A(index + 1, 4) = colNum +1;
    
    index = index + 1;
    while 1 
        if abs(y - y1) < abs(dy) - precision
            break;
        end
        
        tempX = A(index, 1) + (y - A(index, 2)) / k;
        A(index + 1, 1) = tempX;
        A(index + 1, 2) = y;
        A(index + 1, 3) = floor(tempX * dimX + precision / dimX) + 1;
        A(index + 1, 4) = floor(y * dimY + precision / dimY) + 1;
        
        index = index + 1;
        y = y + dy;
    end
    
    A(index + 1, 1) = x1; 
    A(index + 1, 2) = y1; 
    A(index + 1, 3) = floor(x1 * dimX + precision / dimX) + 1;
    A(index + 1, 4) = floor(y1 * dimY + precision / dimY) + 1;
    
    C = sortrows(A, 1);
    pointMatrix = [0, 0, 0, 0];
    pointMatrix(1, 1) = C(1, 1); 
    pointMatrix(1, 2) = C(1, 2);
    pointMatrix(1, 3) = C(1, 3);
    pointMatrix(1, 4) = C(1, 4); 
    bindex = 1;
    
    for index = 1 : size(A)
        if(abs(pointMatrix(bindex, 1) - C(index, 1)) <= precision) && (abs(pointMatrix(bindex, 2) - C(index, 2)) <= precision)
            continue;
        end
        
        pointMatrix(bindex + 1, 1) = C(index, 1);
        pointMatrix(bindex + 1, 2) = C(index, 2);
        pointMatrix(bindex + 1, 3) = C(index, 3);
        pointMatrix(bindex + 1, 4) = C(index, 4);
        
        bindex = bindex + 1;
        
    end
end

%PLOT
%xp = zeros(1, size(pointMatrix));
%yp = zeros(1, size(pointMatrix));
%for index = 1 : size(pointMatrix)
%   xp(index) = pointMatrix(index, 1);
%   yp(index) = pointMatrix(index, 2);
%end
%plot(xp, yp);