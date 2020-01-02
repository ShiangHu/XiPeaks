# xipi: a toolbox to spilt Xi oscillation and multiple oscillatory Peaks

Main Functions:
1) Calculate the spectra using thomson multitaper method
2) Maximum number of peaks amounts to 15
3) Whittle approximation to spectrum likelihood
4) Stepwise optimization
5) Components selection
6) Multichannel spectrum fitting

Application:
1) Scalp EEG data
2) Inversed time series, cross spectrum over source space
3) Intracranial EEG

Dificullt cases in pcgyruspsd
Xi: [46, 53, 87, 88, 108, 109, 112];
1_alpha: [28, 58, 62, 68]
Xi + 1_alpha: [3, 7, 47, 95, 114, 116, 123]
Xi + n_alpha: [16, 30, 71, 74, ]
Xi + uncertain peaks: [20, 39, 40, 44, 52, 73, 83, 84, 85, 99, 100]
