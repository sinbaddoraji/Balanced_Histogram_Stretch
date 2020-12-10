{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fmodern\fcharset0 Courier;}
{\colortbl;\red255\green255\blue255;\red2\green128\blue9;\red14\green0\blue255;}
{\*\expandedcolortbl;;\csgenericrgb\c784\c50196\c3529;\csgenericrgb\c5490\c0\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs20 \cf2 %Function for finding the thresholding using an image histogram for
\fs24 \cf0 \

\fs20 \cf2 %Balanced histogram thresholding
\fs24 \cf0 \

\fs20 \cf2  
\fs24 \cf0 \

\fs20 \cf2 %Implemented from pseudocode found at https://en.wikipedia.org/wiki/Balanced_histogram_thresholding
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf3 function\cf0  bht = bhist(hist)
\fs24 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf2 %       
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf0     n_bins = length(hist);  \cf2 % assumes 1D histogram
\fs24 \cf0 \

\fs20     h_s = 1;
\fs24 \

\fs20     h_e = 1;
\fs24 \

\fs20     h_c = 1;
\fs24 \

\fs20     w_l = 1;
\fs24 \

\fs20     w_r = 1;
\fs24 \

\fs20     min_count = 10;
\fs24 \

\fs20     
\fs24 \

\fs20     \cf3 while\cf0  hist(h_s) <= min_count
\fs24 \

\fs20         h_s = h_s + 1;  \cf2 % ignore small counts at start
\fs24 \cf0 \

\fs20         h_e = n_bins - 1;
\fs24 \

\fs20     \cf3 end
\fs24 \cf0 \

\fs20     
\fs24 \

\fs20     \cf3 while\cf0  hist(h_e) <= min_count
\fs24 \

\fs20         h_e = h_e - 1;  \cf2 % ignore small counts at end
\fs24 \cf0 \

\fs20         
\fs24 \

\fs20         \cf2 % use mean intensity of histogram as center; alternatively: (h_s + h_e) / 2)
\fs24 \cf0 \

\fs20         h_c = int(round(np.average(np.linspace(0, 2 * 8 - 1, n_bins), hist)));
\fs24 \

\fs20         w_l = np.sum(hist(h_s:h_c));  \cf2 % weight in the left part
\fs24 \cf0 \

\fs20         w_r = np.sum(hist(h_c : h_e + 1));  \cf2 % weight in the right part
\fs24 \cf0 \

\fs20     \cf3 end
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf3  
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf0     \cf3 while\cf0  h_s <= h_e
\fs24 \

\fs20         \cf3 if\cf0  w_l > w_r  \cf2 % left part became heavier
\fs24 \cf0 \

\fs20             w_l = w_l - hist(h_s);
\fs24 \

\fs20             h_s = h_s + 1;
\fs24 \

\fs20         \cf3 else\cf0   \cf2 % right part became heavier
\fs24 \cf0 \

\fs20             w_r = w_r - hist(h_e);
\fs24 \

\fs20             h_e = h_e - 1;
\fs24 \

\fs20             new_c = uint8(round((h_e + h_s) / 2));  \cf2 % re-center the weighing scale
\fs24 \cf0 \

\fs20         \cf3 end
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf3  
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf0         \cf3 if\cf0  new_c <= h_c  
\fs24 \

\fs20             \cf2 % move bin to the other side
\fs24 \cf0 \

\fs20             w_l = w_l - hist(h_c);
\fs24 \

\fs20             w_r = w_r + hist(h_c);
\fs24 \

\fs20         \cf3 elseif\cf0  new_c > h_c
\fs24 \

\fs20             w_l = w_l + hist(h_c);
\fs24 \

\fs20             w_r = w_r - hist(h_c);
\fs24 \

\fs20         \cf3 end
\fs24 \cf0 \

\fs20         
\fs24 \

\fs20         h_c = new_c;
\fs24 \

\fs20     \cf3 end
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf3  
\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf0     bht = h_c;
\fs24 \
\pard\pardeftab720\partightenfactor0

\fs20 \cf3 end
\fs24 \cf0 \
\
}
