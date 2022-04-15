#!/bin/bash
#
#-------------------------------------------------#
# Script Name: playshell.sh
# Description: Interagindo com o Bash
# Linkedin: https://www.linkedin.com/in/deborah-melo/
# Written by: Déborah Melo
#-------------------------------------------------#
# Usage: ./playshell.sh
# Obs: Unprivileged users should use sudo
#-------------------------------------------------#
#
TIME=2 # Define a variavel TIME com valor 2
clear # Executa o comando clear para limpar o terminal

echo "Olá Humano que me gerencia!!" #echo serve para mostra uma mensagem na tela, e tbm pode ser usado para transmitir uma mensagem para um arquivo
echo " " # não mostra nada, também usado para pular a linha 
echo "Qual é o seu nome?"

read NOME # Ler nome que for passado e armazenar na variavel chamada NOME
sleep 1 #Serve para aguarda um tempo estabelecido
echo " "
echo "Boas vindas $NOME ao Fabuloso Mundo Linux!" # Vai transmitir uma mensagem com o valor que for passado
sleep $TIME # aguarda 2 segundos prazo da variavel TIME

echo " " 

echo "Por questões de segurança, qual a sua idade?"

read IDADE # Ler a idade e aramazenar na variavel

# Então o ele vai falar com a gente, fazer a pergunta, e armazenar a resposta na variavel NOME
echo " " 

sleep $TIME
if [ $IDADE -ge 18 ] # se a idade armazenada for maior ou igual à 18
then ## então
	echo "Ok, como você tem $IDADE anos, pode utilizar o serviço como quiser!" # mostra na tela esta mensagem
else ## senão vai mostrar...
	echo "Vish, você tem $IDADE anos, chame um responsável antes de continuar..." # senão mostra esta mensagem
	sleep 3

echo " " # Usado para pular linha
	
echo "Já chamou seu responsável??? Digite uma opção '(yes|y)/(no|n)'." # Depois do tempo definido mostra a mensagem
read RESPOSTA; # ler a resposta e armazenar na variavel

echo " " 

case  "$RESPOSTA" in # caso a resposta sejam essas especificadas...

	yes|YES|y) # vai mostrar isso
		echo "Beleza... Pode continuar a utilizar os serviços!"
		;; # para continuar dar condição
	no|NO|n) ## caso seja essas, ou em branco
		echo "Infelizmente não podemos continuar..." # mostra isso...
		echo "Saindo do programa..."
		sleep $TIME
		exit 0 #sai e fecha o script
		;;
		*)
		echo "Opção invalida, saindo do programa..."
		sleep $TIME
		exit 0 #sai e fecha o script

esac # fechamos o case com o esac para finalizar
fi # e fechamos o nosso if com o fi, referente a analise da idade 
sleep $TIME

echo " " 
echo "Se quiser saber mais sobre mim, execute o comando 'man bash', quando encerrar este programa."
	sleep $TIME

echo " " 
echo -e "Mas... Quer saber sobre mim agora? 
Vou contar até 5 enquanto você pensa, ok?" ## O -e ele permite o scape, o espaço
sleep $TIME
echo " " 

for i in $(seq 5); #para laço de repetição/para 'i' variavel que sera escrita. entao definimos que i terá um sequencia até 5
do ## faça a execução até atingir a sequencia definida
	echo $i; ## Mostra o resultado
  sleep 1
done #fez a execução e finalizou

echo "Pronto já pensou??" # Pergunta
echo " " 
echo "Ok, se já pensou..."
echo "1 - Execute o meu manual."  # Pergunta dando alternativas
echo "2 - Se ainda não pensou."
read RESP; ## Lê a resposta

if [ $RESP == "1" ]; #Se a resposta for igual a 1
then #então vai executar o seguinte
	man bash > manual-bash && cat manual-bash #para o terminal não ficar preso, jogar saida para arquivo e ler este arquivo
	echo "############################################" #realizar separação
	echo " " 
	echo "Viva agora você vai aprender tudo sobre mim!"	
	echo " "
        sleep $TIME

elif [ $RESP == "2" ]; ## else+if -> senão for a 1, se a resposta for 2
then #Então fará isso
	echo "Tu é indeciso hein... " 	
	echo " "
	echo "Vou contar de novo até você decidir..."	
		sleep $TIME

	a=1 # atribui valor inicial para contagem, conta a partir de 1
	while [ $a -le 10 ]; do # Enquanto o valor de "a" for menor ou igual a 10 faça....
	echo $a; # mostra na tela que foi feito
  sleep 1
	(( a++ )) # vai adicionar valores até atingir o valor de 10 que definimos
	done #finaliza o 'do' após atingir o valor de 10

sleep $TIME
echo " "
apt-get install figlet -y > /dev/null 2>&1 #instala programa figlet manda a saida padrão e de erros para /dev/null
figlet Error 404 # mostra na tela

echo " "
sleep 4
fi # finaliza o if que iniciamos para as condições de altenativas de resposta

while true; do #Enquanto for verdade, então enquanto o script estiver executando, será executado o cabeçalho, só saindo para encerrar 
echo "##############################################################"
echo "############## Vamos gerenciar algo no sistema? ##############"  ## Cabeçalho com opções
echo "##############################################################"
echo "1 - Atualizar o sistema"
echo "2 - Realizar limpeza de pacotes não utilizados no sistema"
echo "3 - Realizar backup de um diretório do sistema"
echo "4 - Fazer uma lista de Super Herois"
echo "5 - Adicionar um usuario ao sistema"
echo "0 - Sair do Programa"
echo " "
read -a OPCAO -p "Escolha uma opção: " #vai ler opção

NOMEBKP="$DIR.`date +"%H%M%S"`" # definindo o valor da variável para backup com hora, minuto e segundo

if [  $OPCAO == "1" ]; # se for escolhida a opção 1
then # então
	echo "Atualizando o sistema... Aguarde"
	apt-get update && apt-get upgrade -y #atualiza pacotes e em seguida realiza a atualização do sistema
	sleep $TIME
	echo " "
	echo "Sistema atualizado com sucesso!"

elif [ $OPCAO == "2" ]; #se for escolhida a opção 2
then #então
	echo "Removendo pacotes não utilizados"
	apt autoremove # remove pacotes 'inuteis' para o sistema, que não estão em uso
	sleep $TIME
	echo " "
	echo "Pacotes removidos"
	
elif [ $OPCAO == "3" ]; # se for esta
then
	echo "Fazendo o backup, aguarde!"
	mkdir -p /root/backups/ # criar a pasta
	read -a DIR -p "Qual diretório quer realizar backup? "
	tar -cjvf /root/backups/$NOMEBKP.tar.bz /$DIR > /dev/null 2>&1 #comando para empacotamento e compressão[-c->cria arquivo]/[v-ver o que ocorre]/[f-usa o arquivo para empacotar]/[j-bzip2]
	sleep $TIME
	echo " "
	echo "Backup Realizado!!"
	
elif [ $OPCAO == "4" ];
then
	echo "('Escreva os nomes separados por espaços')"
	read -a HEROES -p "Quais herois quer listar? "
	
	echo "Você listou os seguintes herois: "
	for super in ${HEROES[@]}; # vamos fazer uma array, onde nos vamos passar as informações
	do
		echo " "
		echo $super 
	done	

elif [ $OPCAO == "5" ];
then
	read -a USER -p "Quais nomes de usuarios quer adicionar? "
	echo "('Escreva os nomes separados por espaços')"

	for u in ${USER[@]};
	do
	useradd -m -s /bin/bash $u
	echo "*******************"
	awk -F: '($3 >= 1000) {print $1,$3,$6}' /etc/passwd
	echo "*******************"
	done

elif [ $OPCAO == "0" ];
then 
	echo "Saindo do programa!"
	exit 0;
  
fi

done
