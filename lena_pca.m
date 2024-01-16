% Load the image
image = imread('lena.jpg');
data = double(image);

%%%%%performing PCA task.......
M = mean(data, 1);
A = data - M;
N=(size(A, 1) - 1);
Cov.matrix = (A' * A) / N;
[eigenvectors, eigenvalues] = eig(Cov.matrix);
eigenvalues = diag(eigenvalues);
[~, sorted] = sort(eigenvalues, 'descend');
eigenvectors = eigenvectors(:, sorted);

% Principle components 
k_compnent = [200,100,70, 50, 30, 20,10,5];

%for plotclc
percentage_data_loss = zeros(size(k_compnent));

for i = 1:length(k_compnent)
    k = k_compnent(i);
    E = eigenvectors(:, 1:k);
    C_data = A * E;
    recon_data = C_data * E';
    percentage_data_loss(i) = sum((A(:) - recon_data(:)).^2) / sum(A(:).^2) * 100;
    % Display original and reconstructed images
    figure;
    subplot(1,2,1);
    imshow(uint8(data));
    title('Original Image');
    subplot(1,2,2);
    imshow(uint8(recon_data + M));
    title(['Reconstructed Image (k = ', num2str(k), ')']);
     % Display k and percentage of data loss
    disp(['Number of Principal Components (k): ', num2str(k)]);
    disp(['Percentage of Data Loss: ', num2str(percentage_data_loss(i), '%.2f'), '%']);
end
% Plot for the principle component and percentage of loss
figure;
plot(k_compnent, percentage_data_loss, 'ro-','LineWidth', 2,'MarkerSize', 5);
xlabel('Number of Principal Components (k)');
ylabel('Percentage of Data Loss (%)');
title('Data Loss with respect to K');