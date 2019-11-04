function [g] = computeGradAtPoint(fun, x0, h, diffType, numPts, useParallel)
%computeGradAtPoint Summary of this function goes here
%   Detailed explanation goes here

    if(strcmpi(diffType,'central'))
        if(mod(numPts,2) == 0) %even
            numPtsPerSide = numPts/2;
        else %odd
            numPtsPerSide = (numPts-1)/2;
        end        
        
        if(numPtsPerSide <= 0)
            numPtsPerSide = 1;
        end
        
        xPts = [-numPtsPerSide:1:0, 1:1:numPtsPerSide];
        disp(xPts);
    elseif(strcmpi(diffType,'forward'))
        xPts = 0:1:(numPts-1);
    elseif(strcmpi(diffType,'backward'))
        xPts = 0:-1:(numPts-1);
    else
        error('Invalid finite difference type!  Only forward, backward, and central allowed!');
    end
    xPts = xPts(:)';

    [diffCoeff,~,~] = TT(xPts,1);
    
    if(useParallel)
        p = gcp('nocreate');
        if(isempty(p))
            error('Cannot run gradient in parallel: no parallel pool exists!');
        else
            M = p.NumWorkers;
        end
    else
        M = 0;
    end
    
    x0 = x0(:);
    g = nan([numel(x0),1]);
    zeroArr = zeros(size(g));
    parfor(i=1:length(g), M)
        varArr = zeroArr;
        varArr(i) = 1;
        
        xDeltas = h*(varArr * xPts);
        
        xToEvalAt = bsxfun(@plus, x0, xDeltas);
        
        numPtsToEval = size(xToEvalAt, 2);
        
        numerator = 0;
        for(j=1:numPtsToEval)
            if(diffCoeff(j) ~= 0) %#ok<PFBNS> %otherwise we're just adding zero regardless
                numerator = numerator + diffCoeff(j) * fun(xToEvalAt(:,j)); %#ok<PFBNS>
            end
        end
        
        g(i) = numerator/h;
    end
end

