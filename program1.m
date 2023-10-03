clear all;

fileID = fopen('FileList.txt','r');                         % otevreni seznamu, ktery si musite vytvorit
textdata = textscan(fileID,'%s');                           % nacteni
fclose(fileID);                                             % zavreni seznamu
fileNames = string(textdata{:});                             % pole s nazvy souboru vcetne kompletnich cest
numFiles = size (fileNames, 1);                              % pocet souboru


fileID = fopen('Results.txt', 'w' );                        % otevreni souboru s danym jemnem pro vypis vysledku
for i = 1:numFiles
    sig = audioread(fileNames(i));                          % do vektoru nacte vzorky daneho signalu
	times = splitToSections(sig);
    beginSpeechTime = times.first;
    endSpeechTime = times.last;
    fprintf(fileID, '%4.2f  %4.2f\n', beginSpeechTime, endSpeechTime);    % vypise na  1 radek obe nalezene hodnoty - na 2 desetinna cisla
   

    % pause;                                                % prikaz pause se muze hodit v dobe ladeni
    %clf                                                    % zde se pripadny obrazek smaze

end

fclose(fileID);                                                % zavreni souboru



