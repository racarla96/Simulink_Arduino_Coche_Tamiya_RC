load('calib_servo_counts.mat')

out = double(squeeze(data{5}.Values.Data(100:2:2*19500)));
in = double(squeeze(data{6}.Values.Data(50:19500)));

% Ajuste lineal
p1 = polyfit(in, out, 1);
y_fit1 = polyval(p1, in);

% Ajuste cúbico
p3 = polyfit(in, out, 3);
y_fit3 = polyval(p3, in);

% Graficar
figure;
plot(in, out, 'o', ...
     in, y_fit1, '-r', ...
     in, y_fit3, '--g', 'LineWidth', 2);
xlabel('Entrada');
ylabel('Salida');
title('Calibración: Ajuste Lineal y Cúbico');
legend('Datos originales', 'Ajuste lineal', 'Ajuste cúbico', 'Location', 'best');
grid on;

% Mostrar ecuaciones
fprintf('Ecuación lineal: y = %.4fx + %.4f\n', p1(1), p1(2));
fprintf('Ecuación cúbica: y = %.4fx^3 + %.4fx^2 + %.4fx + %.4f\n', p3(1), p3(2), p3(3), p3(4));

% Ajuste cúbico
p3 = polyfit(in, out, 3);
y_fit3 = polyval(p3, in); % Evaluado en los mismos puntos que los datos

% Error cuadrático medio
ecm_lineal = mean((polyval(p1, in) - out).^2);
ecm_cubico = mean((y_fit3 - out).^2);

% Mostrar resultados
fprintf('ECM ajuste lineal: %.4f\n', ecm_lineal);
fprintf('ECM ajuste cúbico: %.4f\n', ecm_cubico);

% R² para el ajuste lineal
y_lineal = polyval(p1, in);
SS_res_lineal = sum((out - y_lineal).^2);
SS_tot = sum((out - mean(out)).^2);
r2_lineal = 1 - SS_res_lineal / SS_tot;

% R² para el ajuste cúbico
y_cubico = polyval(p3, in);
SS_res_cubico = sum((out - y_cubico).^2);
r2_cubico = 1 - SS_res_cubico / SS_tot;

% Mostrar R²
fprintf('R² ajuste lineal: %.4f\n', r2_lineal);
fprintf('R² ajuste cúbico: %.4f\n', r2_cubico);