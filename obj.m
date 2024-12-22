% Objetivo 1
function data = read_data(file)
    try
        temp = xlsread(file);                                   % ler
    catch ERR
        error('Erro a abrir o ficheiro: %s', ERR.message);      % erro
    end

    data(size(temp, 1)) = struct();                             % criar array igual ao num de rows do excel

    for row = 1:size(temp,1)                                    % loop pelo num de linhas
        data(row).id = temp(row,1);
        data(row).x = temp(row,2);
        data(row).y = temp(row,3);
        data(row).malign = temp(row,4);
    end
end

y = read_data("dadosTP2/dados.csv");

% Objetivo 2
function show_data(patient_id, patients_array)
    try
        patient = patients_array(patient_id);

        if patient.malign == 0
            disp("Paciente sem nódulo maligno");
            return
        end

        file_name = sprintf("dadosTP2/dados/%d.mat", patient_id);
        mat_file = load(file_name);                              
        node_seg = mat_file.mask;

        img = zeros(512, 512, 3);
        img(:,:,1) = node_seg;
        img(:,:,2) = 0.5 * node_seg;
        img(:,:,3) = 0 * node_seg;

        for cx=-2:2                                         % (x-cx)^2 + (y-cy)^2 = r^2
            for cy=-2:2
                if (cy)^2 + (cx)^2 < 2
                    img(patient.y+cy,patient.x+cx,1) = 1;
                    img(patient.y+cy,patient.x+cx,2) = 0;
                    img(patient.y+cy,patient.x+cx,3) = 0;
                end
            end
        end

        end_res = img & mat_file.ct;
        imshow(end_res);
        
        imshow(img);
    catch ERR
        error('Erro a mostrar a CT do paciente: %s', ERR.message);      % erro
    end
end

show_data(15, y);

% Objetivo 3
function area, perimetro = calc_nod_geom(img_ct, node_seg)
    try
        
    catch ERR
        error('Erro a calcular área e perímetro: %s', ERR.message);      % erro
    end
end