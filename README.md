# mango
Mes petits utilitaires sympa pour le mini routeur MANGO

zf230327.1618

# Installation minimaliste et super rapide
On récupère le fichier d'installation dans la RAM et on l'exécute

```
cd /tmp && rm install.sh && wget https://raw.githubusercontent.com/zuzu59/mango/master/install.sh && ash install.sh
```

# Installation du dépôt GIT pour modifications
Il faut en premier installer GIT dans le routeur MANGO pour après pouvoir faire le git clone de manière temporaire dans la RAM

```
opkg update && opkg -d RAM install git
```

puis cloner avec un github ssh mais en RAM pour commencer !
```
cd /tmp
git clone git@github.com:zuzu59/mango.git
cd mango
```



