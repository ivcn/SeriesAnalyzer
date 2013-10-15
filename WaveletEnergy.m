function [smoothedEnergy waveletCoefs] = WaveletEnergy(series,...
                                            waveletName,...
                                            minScale,...
                                            maxScale,...
                                            windowSize)
%расчет вейвлет энергии и вывод ее на экран.

n = length(series);% количество точек ряда

waveletCoefs = cwt(series, minScale:maxScale, waveletName);

%суммируем по масштабам
Energy = sum(abs(waveletCoefs).^2, 1);

windowPosition=1;
smoothedEnergy = zeros(1, n - windowSize + 1);

while(windowPosition+windowSize-1 <= n)%пока конечная позиция меньше или равна n
  %суммируем элементы внутри окна
  smoothedEnergy(windowPosition) = sum(Energy(windowPosition:windowPosition+windowSize-1));
  windowPosition=windowPosition+1;
end
end