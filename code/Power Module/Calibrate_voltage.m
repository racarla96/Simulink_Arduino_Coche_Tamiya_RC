% Calibrate POWER MODULE

% Voltage
in = [0 5 5.5 6 6.5 7 7.5 8 8.5 9.2 9.8 10.1 10.7 11.4 11.9 12.5]; % Voltaje de entrada de la fuente
out = [0 620 670 740 805 860 915 980 1035 1130 1200 1240 1310 1390 1455 1525]; % Valor medido con el ADC

% Calcular la recta de calibración (ajuste lineal)
p = polyfit(in, out, 1); % p(1): pendiente, p(2): ordenada

% Generar valores ajustados para graficar la recta
x_fit = linspace(min(in), max(in), 100);
y_fit = polyval(p, x_fit);

% Cargar y analizar datos de ruido
load('power_module_voltage_noise.mat')
data_values = squeeze(data.Data);
media = mean(data_values);
varianza = var(double(data_values));
desviacion = sqrt(varianza);

% Graficar los puntos y la recta de calibración
figure;
plot(in, out, 'o', x_fit, y_fit, '-r', 'LineWidth', 2);
xlabel('Voltaje (V)');
ylabel('Salida');
title('Recta de Calibración');
legend('Datos originales', 'Ajuste lineal','Location','best');
grid on;

% Rectas paralelas a ±1σ de la recta de calibración
y_fit_plus_sigma = y_fit + desviacion;
y_fit_minus_sigma = y_fit - desviacion;

% Graficar recta de calibración con bandas ±σ
figure;
plot(in, out, 'o', x_fit, y_fit, '-r', ...
     x_fit, y_fit_plus_sigma, '--k', ...
     x_fit, y_fit_minus_sigma, '--k', 'LineWidth', 2);
xlabel('Voltaje (V)');
ylabel('Salida');
title('Recta de Calibración con Bandas ±1σ');
legend('Datos originales', 'Ajuste lineal', '+1σ', '-1σ', 'Location', 'best');
grid on;

% Mostrar la ecuación en consola
fprintf('Ecuación de la recta: y = %.2fx + %.2f\n', p(1), p(2));

% Histograma de la salida en estado estático
figure;
histogram(data_values, 'Normalization', 'pdf');
hold on;
xline(media, 'r', 'LineWidth', 2, 'DisplayName', 'Media');
xline(media + desviacion, '--k', 'LineWidth', 2, 'DisplayName', '+1σ');
xline(media - desviacion, '--k', 'LineWidth', 2, 'DisplayName', '-1σ');
legend('Location', 'best');
xlabel('Valor de salida');
ylabel('Densidad');
title('Histograma de la salida en estado estático - 12.5V');
grid on;
