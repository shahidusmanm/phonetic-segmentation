clc; clear;
[y, Fs] = audioread ('H_1.wav.wav');
n=2;
%h(Fs) = 0;
Ru0 = 0;
Ru1 = 0;
L = length (y);
Ru0avg = 0;

while n < L
 Ru0 = abs(y(n) - y(n-1));
 Ru0avg = Ru0avg + Ru0;
 Ru0avg = Ru0avg/L;
 n = n+1;
end


n = 2;
while n < L

	Ru0 = abs(y(n) - y(n-1));
	Ru1 = Ru1 + abs(y(n+1) - y(n));
	
	k = sqrt (Ru1/Ru0);
    
	Rk = k*Ru0;

	B = (log10(Rk/Ru0avg))/(log10(1/Fs));

	h(n) = B;
    n=n+1;
end

n = 2;
Lh = length (h);

while n < Lh

    if isnan (h(n))
        h(n) = h(n-1) + h(n+1);
        h(n) = h(n)/2;
    end
    n=n+1;
end

n = 2;
Lh = length (h);

while n < Lh

    if isnan (h(n))
        h(n) = h(n-1) + h(n+2);
        h(n) = h(n)/2;
    end
    n=n+1;
end

n=1;
while n<5
    h(~isfinite(h))=0;
n=n+1;
end

n=10000;
while n<Lh
    if h(n)== 0;
        h(n) = h(n-1) + h(n+1);
        h(n) = h(n)/2; 
    end
    n=n+1;
end

subplot(2,1,1); plot(y);
subplot(2,1,2); plot (h);

H = buffer(h,Fs*32e-3,Fs*10e-3);

%{
n = 2;
Lh = length (h);
havg = 0;
while n < Lh
 havg = h(n) + h(n+1);
 n = n+1;
 havg = havg/Lh ; 
end
%}


%{
k=0;
for k = Lh
    ACC(k) = h(1:k) - ones(1,k)*havg ;
    k = k+1;
end 
%}



