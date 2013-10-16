function output = WaveletFilter(input,...
                                waveletName,...
                                decompositionLevel,...
                                alpha,...
                                keepApprox,...
                                hardThreshold)
temp = zeros(1,length(input));
if (size(input,1) > size(input,2) )
    temp = input';
end
[c,l] = wavedec(temp, decompositionLevel, waveletName);

sigma = wnoisest(c,l,1);

thr = wbmpen(c,l, sigma, alpha);

output = zeros(size(temp));

if (hardThreshold == 1)
    output = wdencmp('gbl',c,l,waveletName,decompositionLevel,thr,'h',keepApprox);
else
    output = wdencmp('gbl',c,l,waveletName,decompositionLevel,thr,'s',keepApprox);
end

if (size(output) ~= size(input))
    output = output';
end

end

