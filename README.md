# mango
Mes petits utilitaires sympa pour le mini routeur MANGO

zf230327.1609

# Installation minimaliste et rapide
On récupère le fichier d'installation dans la RAM et on l'exécute

cd /tmp
wget https://raw.githubusercontent.com/zuzu59/mango/master/install.sh
ash install


exit



Il faut en premier installer GIT dans le routeur MANGO pour après pouvoir faire le git clone de manière temporaire dans la RAM

opkg update && opkg remove git && 

opkg -d RAM install git

puis cloner avec un github ssh mais en RAM pour commencer !

cd /tmp
git clone git@github.com:zuzu59/mango.git
cd mango
install_utils.sh



