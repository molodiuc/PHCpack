n = [    16,     32,      48,      56,      63]
c = [113.51, 813.65, 2556.36, 4179.06, 5947.15]
g = [143.07, 155.32,  266.55,  337.87,  403.07]
for k in range(0,len(n)):
   print n[k], c[k], g[k], c[k]/g[k]

# running for dimension 16 and frequency 10000 on CPU
# ['real 113.51', 'user 112.21', 'sys 0.05']
# running for dimension 16 and frequency 10000 on GPU
# ['real 143.07', 'user 95.34', 'sys 46.03']
# running for dimension 32 and frequency 10000 on CPU
# ['real 813.65', 'user 812.80', 'sys 0.22']
# running for dimension 32 and frequency 10000 on GPU
# ['real 155.32', 'user 68.08', 'sys 85.56']
# running for dimension 48 and frequency 10000 on CPU
# ['real 2656.36', 'user 2653.69', 'sys 0.57']
# running for dimension 48 and frequency 10000 on GPU
# ['real 266.55', 'user 117.05', 'sys 148.14']
# time ./run_mgs_qd 56 56 10000 1
# real    69m39.056s = 4179.056 s
# user    69m34.959s = 4174.959 s
# sys     0m0.839s   =    0.839 s
# time ./run_mgs_qd 56 56 10000 0
# real    5m37.873s = 337.873 s
# user    2m21.849s = 141.849 s
# sys     3m14.780s = 194.780 s
# time ./run_mgs_qd 63 63 10000 1
# real    99m7.147s  = 5947.147 s
# user    99m1.230s  = 5941.230 s
# sys     0m1.210s   =    1.210 s
# time ./run_mgs_qd 63 63 10000 0
# real    6m43.070s  = 403.070 s
# user    2m54.157s  = 174.157 s
# sys     3m46.751s  = 226.751 s
