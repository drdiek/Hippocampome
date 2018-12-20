function sine_fit_commas2periods(fileName)

fid = fopen(fileName, 'r');

data = fscanf(fid, '%c', [1,inf]);

fclose(fid);

commasIdx = findstr(data, ',');

data(commasIdx) = '.';

fileName = sprintf('%s', fileName);

fid = fopen(fileName, 'w');

fprintf(fid, '%c', data);

fclose(fid);
