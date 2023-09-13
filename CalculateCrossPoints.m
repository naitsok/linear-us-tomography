%function [A, dx, dy] = CalculateCrossPoints(dimX, dimY, precision, x0, x1, y0, y1)

%dimentions
%dimX = 500;
%dimY = 500;
%precision = 1e-6;

%x0 = 0;%0.501;
%y0 = 0;%0;
%x1 = 0.5;%0.607;
%y1 = 1;%1;

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
if abs(x0 - x1) < precision
    y = colNum * dy;
    dy = sign(y1 - y0) * dy;
    index = 1;
    while abs(y - y1) > abs(dy)
        y = y + dy;
        A(index + 1, 1) = x0;
        A(index + 1, 2) = y;
        A(index + 1, 3) = rowNum + 1;
        A(index + 1, 4) = floor(y * dimY + precision / dimY) + 1;
        index = index + 1;
    end
    A(index + 1, 1) = x0;
    A(index + 1, 2) = y1;
    A(index + 1, 3) = rowNum + 1;
    A(index + 1, 4) = floor(y1 * dimY + precision / dimY) + 1;

elseif abs(y0 - y1) < precision
    x = rowNum * dx;
    dx = sign(x1 - x0) * dx;
    index = 1;
    while abs(x - x1) > abs(dx)
        x = x + dx;
        A(index + 1, 1) = x;
        A(index + 1, 2) = y0;
        A(index + 1, 3) = floor(x * dimX + precision / dimX) + 1;
        A(index + 1, 4) = colNum + 1;
        index = index + 1;
    end
    A(index + 1, 1) = x1;
    A(index + 1, 2) = y0;
    A(index + 1, 3) = floor(x1 * dimX + precision / dimX) + 1;
    A(index + 1, 4) = colNum + 1;
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
    tempX = -1;
    while 1%abs(x - x1) > abs(dx)
        %tempX = x;
        tempY = A(index, 2) + (x - A(index, 1)) * k;
        if (dy > 0 && tempY > y) || (dy < 0 && tempY < y)
            while 1%(dx > 0 && tempX < x) || (dx < 0 && tempX > x)%abs(tempX - x) > precision
                tempX = A(index, 1) + (y - A(index, 2)) / k;
                if (dx > 0 && tempX > x) || (dx < 0 && tempX < x)
                    break;
                end
                A(index + 1, 1) = tempX;
                A(index + 1, 2) = y;
                A(index + 1, 3) = floor(tempX * dimX + precision / dimX) + 1;
                A(index + 1, 4) = floor(y * dimY + precision / dimY) + 1;
                index = index + 1;
                if abs(y - y1) < abs(dy) - precision
                    %y = y - dy;
                    if(abs(A(index, 2) - y1) < precision)
                        A(index, 1) = x1;
                        A(index, 2) = y1;
                        A(index, 3) = floor(x1 * dimX + precision / dimX) + 1;
                        A(index, 4) = floor(y1 * dimY + precision / dimY) + 1;
                    else
                        A(index + 1, 1) = x1;
                        A(index + 1, 2) = y1;
                        A(index + 1, 3) = floor(x1 * dimX + precision / dimX) + 1;
                        A(index + 1, 4) = floor(y1 * dimY + precision / dimY) + 1;
                    end
                    y = y + dy;
                    break;
                end
                y = y + dy;
            end
        end
        % after break or while

        
        if abs(x - x1) < abs(dx) - precision
            %(abs(abs(x - x1) - abs(dx)) < precision) % - precision) && (abs(y - y1) < abs(dy) - precision)
            %if abs(y - y1) < abs(dy) - precision
                if(abs(A(index, 1) - x1) < precision)
                    A(index, 1) = x1;
                    A(index, 2) = y1;
                    A(index, 3) = floor(x1 * dimX + precision / dimX) + 1;
                    A(index, 4) = floor(y1 * dimY + precision / dimY) + 1;
                else
                    A(index + 1, 1) = x1;
                    A(index + 1, 2) = y1;
                    A(index + 1, 3) = floor(x1 * dimX + precision / dimX) + 1;
                    A(index + 1, 4) = floor(y1 * dimY + precision / dimY) + 1;
                end
                break;
            %else
            %    x = x - dx;
            %end
            
        end
        
        if(abs(x - x0) > precision)
            A(index + 1, 1) = x;
            A(index + 1, 2) = tempY;
            A(index + 1, 3) = floor(x * dimX + precision / dimX) + 1;
            A(index + 1, 4) = floor(tempY * dimY + precision / dimY) + 1;
            index = index + 1;
        end
            
        
        
        x = x + dx;
        %y = y + dy;
        
    end
end

%L = zeros(1, size(A) - 1);
%Length = sqrt((x1 - x0)^2 + (y1 - y0)^2);
%for ind = 1 : size(A) - 1
%    L(ind) = sqrt((A(ind, 1) - A(ind + 1, 1))^2 + (A(ind, 2) - A(ind + 1, 2))^2);
%end
%Len = sum(L);

%PLOT
%xp = zeros(1, size(A));
%yp = zeros(1, size(A));
%for index = 1 : size(A)
%   xp(index) = A(index, 1);
%   yp(index) = A(index, 2);
%end
%plot(xp, yp);

%i = 1;
%dx = sign(x1 - x0) / 500;
%maxIndexX = abs(x1 - x0) * 500;

%x = x0;
%while abs(x - x1) > 1e-6
%    x = x + dx;
%    A(i + 1, 1) = x;
%    A(i + 1, 2) = A(i, 2) + dx * k;
%    i = i + 1;
%end

%y = y1;
%dy = sign(y0 - y1) / 500;
%while abs(y - y0) > 1e-6
%    y = y + dy;
%    A(i + 1, 1) = A(i, 1) + dy / k;
%    A(i + 1, 2) = y;
%    i = i + 1;
%end

%A = sort(A);

%for i = 1 : maxIndexX
%   A(i + 1, 1) = A(i, 1) + dx;
%   A(i + 1, 2) = A(i, 2) + dx / k;
%end

%i = maxIndexX + 1;

