% Datos de intensidad vs. ADC
intensidad = [0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 ...
              1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 ...
              3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 ...
              4.6 4.7 4.8 4.9 5.0];

adc = [0 10 16 20 28 35 40 45 52 58 64 70 78 ...
       84 90 115 120 125 130 135 144 148 154 158 164 167 174 178 ...
       186 192 197 202 207 215 220 226 231 236 245 250 255 260 265 ...
       270 280 285 290 300];

% Ajuste lineal (recta de calibración)
p = polyfit(intensidad, adc, 1); % p(1): pendiente, p(2): ordenada al origen

% Crear puntos ajustados para graficar
x_fit = linspace(min(intensidad), max(intensidad), 200);
y_fit = polyval(p, x_fit);

% Gráfico
figure;
plot(intensidad, adc, 'o', x_fit, y_fit, '-r', 'LineWidth', 2);
xlabel('Intensidad (A)');
ylabel('Valor ADC');
title('Calibración de Intensidad');
legend('Datos originales', 'Ajuste lineal', 'Location', 'best');
grid on;

% Mostrar la ecuación
fprintf('Ecuación de la recta: y = %.2fx + %.2f\n', p(1), p(2));

% Cargar el archivo con ruido de intensidad
load('power_module_intensity_noise.mat');

% Extraer los valores
int_values = squeeze(data.Data); % Asegura que sea vector columna

% Convertir a double para estadísticas
int_values = double(int_values);

% Calcular estadísticos
media_int = mean(int_values);
varianza_int = var(int_values);
desviacion_int = sqrt(varianza_int);

% Histograma con líneas de ±σ
figure;
histogram(int_values, 'Normalization', 'pdf');
hold on;

xline(media_int, 'r', 'LineWidth', 2, 'DisplayName', 'Media');
xline(media_int + desviacion_int, '--k', 'LineWidth', 2, 'DisplayName', '+1σ');
xline(media_int - desviacion_int, '--k', 'LineWidth', 2, 'DisplayName', '-1σ');

legend('Location', 'best');
xlabel('Valor de salida (ADC)');
ylabel('Densidad');
title('Histograma de la intensidad en estado estático - 2A');
grid on;

% Recta de calibración (si no la hiciste antes)
p_int = polyfit(intensidad, adc, 1);
x_fit = linspace(min(intensidad), max(intensidad), 200);
y_fit = polyval(p_int, x_fit);
y_fit_plus_sigma = y_fit + desviacion_int;
y_fit_minus_sigma = y_fit - desviacion_int;

% Gráfico con bandas ±σ
figure;
plot(intensidad, adc, 'o', x_fit, y_fit, '-r', ...
     x_fit, y_fit_plus_sigma, '--k', ...
     x_fit, y_fit_minus_sigma, '--k', 'LineWidth', 2);
xlabel('Intensidad (A)');
ylabel('Valor ADC');
title('Recta de Calibración de Intensidad con Bandas ±1σ');
legend('Datos originales', 'Ajuste lineal', '+1σ', '-1σ', 'Location', 'best');
grid on;

