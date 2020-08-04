function PSO1_PSO2_mean()
    load("H_PSO1.mat",'H_PSO1');
    H_PSO1_mean = mean(H_PSO1,2);
    H_PSO1_PSO2_mean = reshape(H_PSO1_mean,20000,22);
    load("H_PSO2.mat",'H_PSO2');
    H_PSO2_mean = mean(H_PSO2,2);
    H_PSO3_mean = reshape(H_PSO2_mean,20000,22);
    H_PSO1_PSO2_mean(:,:,2) = H_PSO3_mean;
    n=1;
end

