# mango 
# Mes petits utilitaires sympa pour le mini routeur MANGO
# ESC+# pour cacher les numéros de lignes sous nano afin de pouvoir copier/coller !

zf230327.2247, zf230404.1343

# Installation des packages minimalistes et super rapide
On récupère le fichier d'installation dans la RAM et on l'exécute

```
cd /tmp && rm -f install.sh && wget https://raw.githubusercontent.com/zuzu59/mango/master/install.sh && ash install.sh
```

# Installation du dépôt GIT pour modifications
Il faut en premier installer GIT dans la RAM du routeur MANGO pour après pouvoir faire le *git clone* de manière temporaire dans la RAM ou permanent sur la clef USB:
```
opkg update
opkg install zlib
opkg -d ram install git
ln -s /tmp/usr/bin/git /usr/bin/git
```

ATTENTION: il faut 'prendre' sa clef ssh avec soit lors de la connexion SSH afin que cela fonctionne avec Github en ssh:
```
ssh-add -l
ssh-add
ssh-add -l
ssh -A -o SendEnv="GIT*" root@192.178.0.55
```

puis cloner en RAM:
```
cd /tmp
git clone git@github.com:zuzu59/mango.git
cd mango

source ./alias
ash ./env_git_a_zuzu.sh
```

ou cloner sur la clef USB FLASH:
```
cd /mnt/sda1
git clone git@github.com:zuzu59/mango.git
cd mango

source ./alias
ash ./env_git_a_zuzu.sh
```

# Installation, juste du dépôt sans le GIT, sur la clef USB FLASH
```
opkg update
opkg install unzip

cd /mnt/sda1

wget https://github.com/zuzu59/mango/archive/refs/heads/master.zip -O ./mango.zip
unzip mango.zip
mv mango-master/ mango
```


