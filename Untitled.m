%Function for finding the thresholding using an image histogram for
%Balanced histogram thresholding
 
%Implemented from pseudocode found at https://en.wikipedia.org/wiki/Balanced_histogram_thresholding
function bht = bhist(hist)
%       
    n_bins = length(hist);  % assumes 1D histogram
    h_s = 1;
    h_e = 1;
    h_c = 1;
    w_l = 1;
    w_r = 1;
    min_count = 10;
    
    while hist(h_s) <= min_count
        h_s = h_s + 1;  % ignore small counts at start
        h_e = n_bins - 1;
    end
    
    while hist(h_e) <= min_count
        h_e = h_e - 1;  % ignore small counts at end
        
        % use mean intensity of histogram as center; alternatively: (h_s + h_e) / 2)
        h_c = int(round(np.average(np.linspace(0, 2 * 8 - 1, n_bins), hist)));
        w_l = np.sum(hist(h_s:h_c));  % weight in the left part
        w_r = np.sum(hist(h_c : h_e + 1));  % weight in the right part
    end
 
    while h_s <= h_e
        if w_l > w_r  % left part became heavier
            w_l = w_l - hist(h_s);
            h_s = h_s + 1;
        else  % right part became heavier
            w_r = w_r - hist(h_e);
            h_e = h_e - 1;
            new_c = uint8(round((h_e + h_s) / 2));  % re-center the weighing scale
        end
 
        if new_c <= h_c  
            % move bin to the other side
            w_l = w_l - hist(h_c);
            w_r = w_r + hist(h_c);
        elseif new_c > h_c
            w_l = w_l + hist(h_c);
            w_r = w_r - hist(h_c);
        end
        
        h_c = new_c;
    end
 
    bht = h_c;
end
