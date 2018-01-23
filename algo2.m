
load('htwo.mat');
n = 3;
L = length (h);
d=0;

n = 1;

M = movmean (h, 200, 'omitnan');
subplot (3,1,1);
plot (y);

%subplot (4,1,2);
%plot (h);

%subplot (4,1,3);
%plot (M);

a = 1;
b = 1;
n = 1;
ACC(L) = 0;
Z(4) = 0;
temp (L) = 0;
while n < L
    Z(a) = M(n);
    n = n+1; a = a+1;
    if (a == 4)
        temp(b) = trapz (Z);
        a = 1;
        b = b+1;
    end
end

n = 2;
while n < length(temp)
    ACC(n) = temp(n)+ temp (n-1);
    n = n+1;
end

subplot (3,1,2);
plot (ACC);

 x = 2:60000;
 y = ACC(n);

   %# Find section sizes, by using an inverse of the approximation of the derivative
   numOfSections = 4;
   indexes = round(linspace(1,numel(y),numOfSections));
   derivativeApprox = diff(y(indexes));
   inverseDerivative = 1./derivativeApprox;
   weightOfSection =  inverseDerivative/sum(inverseDerivative);   
   totalRange = max(x(:))-min(x(:));   
   sectionSize = weightOfSection.* totalRange;

   %# The relevant nodes
   xNodes = x(1) + [ 0 cumsum(sectionSize)];
   yNodes = log(log(xNodes));
   subplot (3,1,3);
   plot (yNodes);