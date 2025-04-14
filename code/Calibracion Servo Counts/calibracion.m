load('calib_servo_counts.mat')

out = double(squeeze(data{5}.Values.Data(100:2:2*19500)));
in = double(squeeze(data{6}.Values.Data(50:19500)));


% Calcular la recta de calibración (ajuste lineal)
p = polyfit(in, out, 1); % p(1): pendiente, p(2): ordenada

% Generar valores ajustados para graficar la recta
x_fit = linspace(min(in), max(in), 100);
y_fit = polyval(p, x_fit);

% Graficar los puntos y la recta de calibración
figure;
plot(in, out, 'o', x_fit, y_fit, '-r', 'LineWidth', 2);
xlabel('Entrada');
ylabel('Salida');
title('Recta de Calibración');
legend('Datos originales', 'Ajuste lineal','Location','best');
grid on;

% Mostrar la ecuación en consola
fprintf('Ecuación de la recta: y = %.2fx + %.2f\n', p(1), p(2));