function output = WaveletFilter(input,...
                                waveletName,...
                                decompositionLevel,...
                                alpha,...
                                keepApprox,...
                                hardThreshold)

[c,l] = wavedec2(input, decompositionLevel, waveletName);

% Estimate the noise standard deviation from the
% detail coefficients at level 1.
det1 = detcoef2('compact',c,l,1);
sigma = median(abs(det1))/0.6745;



%alpha = 1.2;
%alpha=2;
% Use wbmpen for selecting global threshold  
% for image de-noising.
thr = wbmpen(c,l,sigma,alpha);

% Use wdencmp for de-noising the image using the above
% thresholds with soft thresholding and approximation kept.
%keepapp = 1;
%keepapp = 5;
if (hardThreshold == 1)
    output = wdencmp('gbl',c,l,waveletName,decompositionLevel,thr,'h',keepApprox);
else
    output = wdencmp('gbl',c,l,waveletName,decompositionLevel,thr,'s',keepApprox);
end
% Plot original and de-noised images.
%figure(2)
%colormap(pink(nbc));
%subplot(221), image(wcodemat(X))
%title('Original image')
%subplot(222), image(wcodemat(xd))
%title('De-noised image')

end

