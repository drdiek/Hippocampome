% Download and unzip the atlasVolume and annotation zip files
 
% 25 micron volume size
size = [528 320 456];
% VOL = 3-D matrix of atlas Nissl volume
% fid = fopen('atlasVolume/atlasVolume.raw', 'r', 'l' );
% VOL = fread( fid, prod(size), 'uint8' );
% fclose( fid );
% VOL = reshape(VOL,size);
% ANO = 3-D matrix of annotation labels
fid = fopen('annotation.raw', 'r', 'l' );
ANO = fread( fid, prod(size), 'uint32' );
fclose( fid );
ANO = reshape(ANO,size);
 
% Display one coronal section
% figure;imagesc(squeeze(VOL(264,:,:)));colormap(gray);
figure;imagesc(squeeze(ANO(264,:,:)));colormap(lines);
 
% Display one sagittal section
figure;imagesc(squeeze(ANO(:,:,220)));colormap(lines);
% figure;imagesc(squeeze(VOL(:,:,220)));colormap(gray);