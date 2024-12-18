# agda2hs benchmarks

The test files themselves are based on
conv\_eval.v and conv\_eval.agda
written by András Kovács.

For Agda, an empty type-checking takes 0.501s;
I subtract this
(but sometimes I get negative or something similar;
then, I write ~0).
Coq can output a time specifically for a given phase.

|               | Agda    | Coq    |
|---------------|---------|--------|
|NatConv1M      | ~0      | 3.43   |
|NatConv5M      | 19.220  | 16.807 |
|NatConv10M     | 39.294  | 41.828 |
|TreeConv15     | 0.098   | 0.023  |
|TreeConv18     | 0.061   | 0.039  |
|TreeConv19     | 0.051   | 0.039  |
|TreeConv20     | 14.108  | 1.471  |
|TreeConv21     | 26.216  | 2.792  |
|TreeConv22     | 53.148  | 5.515  |
|TreeConv23     | 102.571 | 10.83  |

|               |  Agda  | Coq lazy | Coq compute | Coq vm\_compute |
|---------------|--------|----------|-------------|----------------|
|ForceTree15    | 0.471  | 0.135 | 0.148 | 0.005 |
|ForceTree18    | 1.204  | 1.005 | 0.687 | 0.05  |
|ForceTree19    | 2.110  | 1.796 | 1.167 | 0.098 |
|ForceTree20    | 3.732  | 3.503 | 2.129 | 0.194 |
|ForceTree21    | 7.177  | 6.94  | 3.974 | 0.581 |
|ForceTree22    | 14.037 | 13.374 | 7.905 | 1.217 |
|ForceTree23    | 27.573 | 26.482 | 14.762 | 2.194 |


| | phase | Agda MAlonzo | agda2hs | Coq OCaml extraction |
|-|-------|--------------|---------|----------------------|
| n2   | translation | 1.162 | 0.610             | 0.162 |
|      | compilation | 1.303/1.819/1.823 | 0.915/0.934/0.950 | 0.017 |
|      | running     | 0.014/0.014/0.014 | 0.014/0.014/0.013 | 0.003 |
| n100 | translation | 1.172 | 0.590             | 0.156 |
|      | compilation | 1.306/1.791/1.900 | 0.850/0.901/0.929 | 0.021 |
|      | running     | 0.013/0.013/0.014 | 0.013/0.013/0.012 | 0.006 |
| n10k | translation | 1.173 | 0.600             | 0.140 |
|      | compilation | 1.351/1.743/1.847 | 0.885/0.929/0.910 | 0.016|
|      | running     | 0.012/0.014/0.012 | 0.014/0.012/0.014 | 0.003 |
| n100k | translation | 1.195 | 0.559             | 0.152 |
|      | compilation | 1.334/1.787/1.818 | 0.868/0.914/0.924 | 0.022 |
|      | running     | 0.023/0.024/0.013 | 0.034/0.013/0.014 | 0.004 |
| n1M  | translation | 1.163 | 0.582             | 0.151 |
|      | compilation | 1.291/1.823/1.853 | 0.889/0.906/0.889 | 0.019 |
|      | running     | 0.232/0.160/0.185 | 0.224/0.141/0.150 | 0.029 |
| n5M  | translation | 1.133 | 0.581             | 0.146 |
|      | compilation | 1.339/1.755/1.829 | 0.871/0.911/0.902 | 0.024 |
|      | running     | 0.951/0.832/0.813 | 0.766/0.191/0.181 | 0.073 |
| n10M | translation | 1.193 | 0.560             | 0.153 |
|      | compilation | 1.279/1.767/1.866 | 0.848/0.931/0.887 | 0.023 |
|      | running     | 2.039/1.656/1.670 | 1.560/1.410/1.388 | 0.156 |
| n100M | translation | 1.162 | 0.572            | 0.144 |
|      | compilation | 1.334/1.805/1.869 | 0.878/0.886/0.925 | 0.018 |
|      | running     | 21.008/18.686/18.721 | 15.242/2.290/2.291 | 1.502 |
| n500M | translation | 1.807 | 0.995 | 0.153 |
|      | compilation | 2.002/2.775/2.824 | 1.335/1.488/1.501 | 0.029 |
|      | running     | killed | killed | 7.786 |
| n1G  | translation | 1.837 | 0.976 | 0.149 |
|      | compilation | 1.985/2.752/2.886 | 1.393/1.434/1.449 | 0.017 |
|      | running     | killed | killed | 15.224 |
| t15  | translation | 1.101 | 0.621             | 0.164 |
|      | compilation | 1.294/1.820/1.848 | 0.881/0.971/0.941 | 0.022 |
|      | running     | 0.013/0.024/0.024 | 0.013/0.013/0.024 | 0.009 |
| t18  | translation | 1.090 | 0.613             | 0.148 |
|      | compilation | 1.308/1.807/1.826 | 0.890/0.925/0.948 | 0.021 |
|      | running     | 0.054/0.033/0.044 | 0.034/0.033/0.035 | 0.049 |
| t19  | translation | 1.142 | 0.615             | 0.149 |
|      | compilation | 1.270/1.799/1.857 | 0.912/0.923/0.925 | 0.021 |
|      | running     | 0.095/0.063/0.075 | 0.044/0.043/0.054 | 0.108 |
| t20  | translation | 1.081 | 0.592             | 0.143 |
|      | compilation | 1.268/1.806/1.826 | 0.872/0.913/0.917 | 0.022 |
|      | running     | 0.184/0.124/0.113 | 0.063/0.074/0.083 | 0.188 |
| t21  | translation | 1.143 | 0.603             | 0.145 |
|      | compilation | 1.326/1.755/1.865 | 0.882/0.952/0.941 | 0.020 |
|      | running     | 0.314/0.224/0.244 | 0.134/0.124/0.145 | 0.344 |
| t22  | translation | 1.091 | 0.602             | 0.139 |
|      | compilation | 1.312/1.796/1.856 | 0.866/0.922/0.927 | 0.017 |
|      | running     | 0.604/0.423/0.404 | 0.255/0.244/0.234 | 0.709 |
| t23  | translation | 1.131 | 0.602             | 0.145 |
|      | compilation | 1.352/1.737/1.870 | 0.888/0.939/0.922 | 0.018 |
|      | running     | 1.153/0.794/0.793 | 0.444/0.434/0.423 | 1.373 |
