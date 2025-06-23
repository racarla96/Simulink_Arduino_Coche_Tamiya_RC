


% --- VISUALIZACIÓN DE PARÁMETROS INTERPOLADOS ---
figure;
plot(U_medio, J_ident, 'o'); hold on;
plot(U_medio, fit_J(U_medio), 'r--'); hold on;
title('Interpolación de J');
xlabel('U medio [V]'); ylabel('J');

figure;
plot(U_medio, b_ident, 'o'); hold on;
plot(U_medio, fit_b(U_medio), 'r--'); hold on;
title('Interpolación de b');
xlabel('U medio [V]'); ylabel('b');

figure;
plot(U_medio, K_ident, 'o'); hold on;
plot(U_medio, fit_K(U_medio), 'r--'); hold on;
title('Interpolación de K');
xlabel('U medio [V]'); ylabel('K');

figure;
plot(U_medio, L_ident, 'o'); hold on;
plot(U_medio, fit_L(U_medio), 'r--'); hold on;
title('Interpolación de L');
xlabel('U medio [V]'); ylabel('L');

figure;
plot(U_medio, R_ident, 'o'); hold on;
plot(U_medio, fit_R(U_medio), 'r--'); hold on;
title('Interpolación de R');
xlabel('U medio [V]'); ylabel('R');