# mango
# Mes petits utilitaires sympa pour le mini routeur MANGO
# ESC+# pour cacher les numéros de lignes sous nano !

zf230327.1716

# Installation minimaliste et super rapide
On récupère le fichier d'installation dans la RAM et on l'exécute

```
cd /tmp && rm -f install.sh && wget https://raw.githubusercontent.com/zuzu59/mango/master/install.sh && ash install.sh
```

# Installation du dépôt GIT pour modifications
Il faut en premier installer GIT dans le routeur MANGO pour après pouvoir faire le git clone de manière temporaire dans la RAM
```
opkg update
opkg install zlib
opkg -d ram install git
ln -s /tmp/usr/bin/git /usr/bin/git
```

puis cloner avec un github ssh en RAM:
```
cd /tmp
git clone git@github.com:zuzu59/mango.git
cd mango

source ./alias
ash ./env_git_a_zuzu.sh
```

ou cloner avec un github ssh sur la clef USB FLASH:
```
cd /mnt/sda1
git clone git@github.com:zuzu59/mango.git
cd mango

source ./alias
ash ./env_git_a_zuzu.sh
```

