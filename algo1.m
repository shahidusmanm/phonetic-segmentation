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
subplot(2,1,1); plot(y);
subplot(2,1,2); plot (h);
