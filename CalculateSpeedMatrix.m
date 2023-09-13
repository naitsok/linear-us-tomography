function speedMatrix = CalculateSpeedMatrix(A, times, alpha, dimX, dimY, minSpeed, maxSpeed)

timeSize = size(times);
t = zeros(timeSize(1), 1);

for i = 1 : size(times)
    t(i, 1) = times(i, 5);
end

%%%%%% Ax = b;

%tranA = transpose(A);

AtranA = A' * A;

cholA = chol((AtranA + alpha * eye(size(AtranA))));

b = A' * t;

y = cholA' \ b;

linearC = cholA \ y;

%sizeC = size(linearC);
%sizeC = sizeC(1);

speedMatrix = zeros(dimY, dimX);

for i = 1 : dimY
    for j = 1 : dimX
        speedMatrix(i, j) = 1.0 / linearC((i - 1) * dimY + j); %abs(sizeC - dimY * dimX) + 
        if (speedMatrix(i, j) == Inf)
            speedMatrix(i, j) = minSpeed;
        end
    end
end