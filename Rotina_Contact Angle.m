clear
close all
clc

%% carregar o pacote de processametno de imagens para conversão de RGB para
%%binário.
 
 
pkg load image

%%caso o pacote não estiver disponível, baixar em: https://octave.sourceforge.io/image/index.html


%% Diretório da imagem a ser analisada



file = 'C:\Users\.....'; %% Adicionar aqui o caminho onde a imagem está salva.

I = im2double(rgb2gray(imread(file)));



%% Mostra a imagem original 

figure(1)
imshow(file)

%% Aplica limiar de corte (cores claras viram 1 e cores escuras viram 0) 

thershold = 0.5
dummy=~im2bw(I,thershold); %#ok<IM2BW>

figure(2)
imshow(dummy)

%% Remove a sombra do meio da bolha e remove pequenos pontos

dummy = imfill(dummy, 'holes');
dummy = bwareaopen(dummy,5,4);

figure(3)
imshow(dummy)

%% Encontra o formato da bolha/gota

[row, col] =  find(dummy); %#ok<ASGLU>



%% Encontra a posição da base para remover (a base nao interessa) e encontra o formato da bolha novamente



dummy(row(1)-3:end,:) = 0;

figure(5)
imshow(dummy)

[row, col] =  find(dummy);

figure(6)
imshow(dummy)
hold on
plot(col,row,'.r') 

%% Encontra o ponto máximo e mínimo a serem usados como referencia de medida e plota uma linha entre estes pontos


col_minimo = col(1);
col_maximo = col(end);

for(i=1:length(col))
   if(col(i)==col_minimo)
       indice_minimo = i
   end
   
   if(col(i)==col_maximo)
       indice_maximo = i
   end
end
    
row_minimo = row(indice_minimo);
row_maximo = row(indice_maximo);

figure(7)
imshow(dummy)
hold on
plot([col_minimo, col_maximo],[row_minimo, row_maximo],'r','linewidth',3) 

figure(8)
imshow(file)
hold on
plot([col_minimo, col_maximo],[row_minimo, row_maximo],'r','linewidth',3)

%% Encontra o contorno da circunferencia

curva = zeros(1,(col_maximo - col_minimo));
vetor_curva = col_minimo:col_maximo;

inc = 1;

for ii = col_minimo : col_maximo
    clear index
    index = find(col == ii);
    
    curva(inc) = min(row(index));
    inc = inc + 1;
    
    if (ii >= col_maximo), break; end
end

f = figure(9);
imshow(file)
hold on
plot([col_minimo, col_maximo],[row_minimo, row_maximo],'r',vetor_curva,curva,'linewidth',3)
aH = gca;

%% Calcula o angulo interno da extremidade ESQUERDA

t=vetor_curva;
y=curva;

p = polyfit(t(1:100),y(1:100),3);
x1 = linspace(t(1),t(100),5000);
y1 = polyval(p,x1);


dy=diff(y1)./diff(x1);
k=1; % point number 1

tang=(x1-x1(k))*dy(k)+y1(k);

plot(x1,tang,'color','m','linewidth',5)
hold on
scatter(x1(k),y1(k),80,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[1 1 0],...
              'LineWidth',1.5)
          
plot(x1,y1,'-.c','linewidth',3)          
hold off

% Vetor unitário

X_vetor_curva = col_maximo-col_minimo;
Y_vetor_curva = row_maximo - row_minimo;

BaseUnitario_vetor_curva = sqrt(X_vetor_curva^2 + Y_vetor_curva^2);



X_curva =  x1(length(x1)) - x1(1);
Y_curva = tang(1) - tang(length(tang));

BaseUnitario_curva = sqrt(X_curva^2 + Y_curva^2);



produto_escalar = X_vetor_curva * X_curva + Y_vetor_curva * Y_curva;
Produto_normas = BaseUnitario_vetor_curva * BaseUnitario_curva;
teta1 = acosd(produto_escalar/Produto_normas);

text(col_minimo + 30,row_minimo - 30, [num2str(teta1) '°'],'Color','red','FontSize',20)


%% Calcula o angulo interno da extremidade DIREITA

t=vetor_curva;
y=curva;

p = polyfit(t((length(t)-50):length(t)),y((length(t)-50):length(t)),3);
x1 = linspace(t(length(t)-50),t(length(t)),5000);
y1 = polyval(p,x1);


dy=diff(y1)./diff(x1);
k=length(x1)-1; % point number 1
tang=(x1-x1(k))*dy(k)+y1(k);
hold on
plot(x1,tang,'color','m','linewidth',3);
scatter(x1(k),y1(k),80,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[1 1 0],...
              'LineWidth',1.5)
plot(x1,y1,'-.c','linewidth',3) 
hold off

% Vetor unitário


X_vetor_curva = col_maximo-col_minimo;
Y_vetor_curva = row_maximo - row_minimo;

BaseUnitario_vetor_curva = sqrt(X_vetor_curva^2 + Y_vetor_curva^2);


X_curva =  x1(end) - x1(end-650);
Y_curva = tang(end) - tang(end-650);

BaseUnitario_curva = sqrt(X_curva^2 + Y_curva^2);


produto_escalar = X_vetor_curva * X_curva + Y_vetor_curva * Y_curva;
Produto_normas = BaseUnitario_vetor_curva *BaseUnitario_curva;
teta2 = acosd(produto_escalar/Produto_normas);

text(col_maximo + 30,row_maximo - 30, [num2str(teta2) '°'],'Color','red','FontSize',18)

teta_estatico = (teta1 + teta2 ) / 2.
col_med= (col_maximo + col_minimo ) / 2.
text(col_med,max(row) - 30, [num2str(teta_estatico) '°'],'Color','red','FontSize',18)

legend('Superfície','Circunferencia medida','Angulos calculados','Ponto Tangente','Ajuste de curva circular')
