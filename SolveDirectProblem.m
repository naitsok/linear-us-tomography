function times = SolveDirectProblem(transArray, recArray, speedMatrix, precision)

times = [0, 0, 0, 0, 0];
speedMatrixSize = size(speedMatrix);

index = 1;
for tr = 1 : size(transArray)
    for rec = 1 : size(recArray)
        if (abs(transArray(tr, 1) - recArray(rec, 1)) < precision) && (transArray(tr, 1) < 0 + precision || transArray(tr, 1) > 1 - precision)
           continue; 
        end
        
        if (abs(transArray(tr, 2) - recArray(rec, 2)) < precision) && (transArray(tr, 2) < 0 + precision || transArray(tr, 2) > 1 - precision)
            continue;
        end
        
        if(abs(transArray(tr, 1) - recArray(rec, 1)) < precision && abs(transArray(tr, 2) - recArray(rec, 2)) < precision)
            continue;
        end
        
        pointMatrix = GetPointMatrixSimple(speedMatrixSize(1), speedMatrixSize(2), precision, transArray(tr, 1), recArray(rec, 1), transArray(tr, 2), recArray(rec, 2));
        times(index, 1) = transArray(tr, 1); % = tr;
        times(index, 2) = transArray(tr, 2);% = rec;
        times(index, 3) = recArray(rec, 1); % = tr;
        times(index, 4) = recArray(rec, 2);% = rec;
        times(index, 5) = CalculateTime(pointMatrix, speedMatrix);
        
        index = index + 1;
    end
    %index = index + 1;
end