function [smoothedEnergy waveletCoefs] = WaveletEnergy(series,...
                                            waveletName,...
                                            minScale,...
                                            maxScale,...
                                            windowSize)
%������ ������� ������� � ����� �� �� �����.

n = length(series);% ���������� ����� ����

waveletCoefs = cwt(series, minScale:maxScale, waveletName);

%��������� �� ���������
Energy = sum(abs(waveletCoefs).^2, 1);

windowPosition=1;
smoothedEnergy = zeros(1, n - windowSize + 1);

while(windowPosition+windowSize-1 <= n)%���� �������� ������� ������ ��� ����� n
  %��������� �������� ������ ����
  smoothedEnergy(windowPosition) = sum(Energy(windowPosition:windowPosition+windowSize-1));
  windowPosition=windowPosition+1;
end
end