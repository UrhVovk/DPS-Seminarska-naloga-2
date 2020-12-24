[rec,Fs] = audioread('3.yesterday_sinus.wav');
which bandstop
t = (0:length(rec)-1)/Fs;
n = 301;

Wnl = 290/(Fs/2);%Ustvarjanje lowpass filtra
hl = fir1(n,Wnl,'low');
tel = filter(hl,1,rec);
audiowrite('lowpass.wav',tel,Fs);%Uporaba lowpass filtra

Wnh = 380/(Fs/2);%Ustvarjanje highpass filtra
hh = fir1(n,Wnh,'high');
teh = filter(hh,1,rec);
audiowrite('highpass.wav',teh,Fs);%Uporaba highpass filtra

hbs = fir1(n,[Wnl Wnh],'DC-0');%Ustvarjanje bandstop filtra
tbs = filter(hbs,1,rec);
audiowrite('bandstop.wav',tbs,Fs);%Uporaba bandstop filtra

figure;%Prikazovanje rezultatov
zoom on;
subplot(2,2,1);
plot(t,rec);
title('Originalen signal');
xlabel('Time (s)');
grid on;

subplot(2,2,3);
plot(t,tel);
title('Po lowpass filtru');
xlabel('Time (s)');
grid on;

subplot(2,2,2);
plot(t,tbs);
title('Po bandstop filtru');
xlabel('Time (s)');
grid on;

subplot(2,2,4);
plot(t,teh);
title('Po highpass filtru');
xlabel('Time (s)');
grid on;

figure;
subplot(3,1,1);
%xdft = fft(teh);
%xdft = xdft(1:length(teh)/2+1);
%freq = 0:Fs/length(teh):Fs/2;
%plot(freq,abs(xdft));
%xlabel('Hz');
psdest = psd(spectrum.periodogram,tel,'Fs',Fs);
plot(psdest.Frequencies,psdest.Data);
title('Amplitudni spekter lowpass signala');
xlabel('Hz');ylabel('Amplitude');
grid on;

subplot(3,1,2);
psdest = psd(spectrum.periodogram,teh,'Fs',Fs);
plot(psdest.Frequencies,psdest.Data);
title('Amplitudni spekter highpass signala');
xlabel('Hz');ylabel('Amplitude');
grid on;

subplot(3,1,3);
psdest = psd(spectrum.periodogram,tbs,'Fs',Fs);
plot(psdest.Frequencies,psdest.Data);
title('Amplitudni spekter bandstop signala');
xlabel('Hz');ylabel('Amplitude');
grid on;