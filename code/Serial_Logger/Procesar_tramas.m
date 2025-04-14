% Uso de la función
a = "DATA_6.TXT"; % Archivo de entrada
b = "datos_6.csv"; % Archivo de salida
limpiar_tramas(a, b);

function limpiar_tramas(archivo_entrada, archivo_salida)
    % Leer el archivo como un string completo
    fid = fopen(archivo_entrada, 'r');
    if fid == -1
        error('No se pudo abrir el archivo. Verifica el nombre.');
    end
    datos = fread(fid, '*char')'
    fclose(fid);
    
    % Expresión regular para detectar tramas válidas
    patron = 'A,\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,(-)?\d*.\d*,Z';
    tramas = regexp(datos, patron, 'match')
    
    % Escribir las tramas limpias en el archivo de salida
    fid_out = fopen(archivo_salida, 'w');
    if fid_out == -1
        error('No se pudo abrir el archivo de salida.');
    end
    
    for i = 1:length(tramas)
        fprintf(fid_out, '%s\n', tramas{i});
    end
    fclose(fid_out);
    
    fprintf('Se han procesado %d tramas limpias y guardado en %s\n', length(tramas), archivo_salida);
end