# Adventure_Works

<img src="https://media.giphy.com/media/vISmwpBJUNYzukTnVx/giphy.gif" width="300">

Avant-Propos :

Dans le cadre d'un exercice sur les requêtes SQL, le projet necessite la restauration de deux bases de données via leurs versions .bak, situés ici dans le dossier data. Une fois chose faite, et la base de donnée connectée, se trouvent dans le fichier script "50requetes.sql" à appliquer à la base de donnée "AdventureWorks2019"

# Obtenir les fichiers .bak à restaurer :

Telechargez ces deux fichiers :
[AdventureWorks2019.bak](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak)
[AdventureWorksDW2019.bak](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2019.bak)

Et copiez-les dans le dossier data


# Procédure de restauration des bases de données SQL Server dans Docker

Ce guide explique comment lancer un conteneur Docker SQL Server, y restaurer des fichiers .bak et exécuter des scripts SQL pour la restauration des bases de données.

## Lancement du conteneur Docker SQL Server

Pour lancer un conteneur Docker SQL Server avec les fichiers .bak à restaurer, utilisez la commande suivante :

```bash
sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Admin123" -p 1433:1433 --name sqlpreview -v <chemin_vers_dossier_local>:/var/opt/mssql/backup -d mcr.microsoft.com/mssql/server:2022-preview-ubuntu-22.04
```

Créez un dossier "data" dans le conteneur pour les fichiers .bak :

```bash
sudo docker exec -it sqlpreview mkdir /var/opt/mssql/data
```

Copiez les fichiers .bak dans le conteneur :

```bash
sudo docker cp <chemin_vers_fichier_AdventureWorks2019.bak> sqlpreview:/var/opt/mssql/data/
sudo docker cp <chemin_vers_fichier_AdventureWorksDW2019.bak> sqlpreview:/var/opt/mssql/data/```
```

Exécutez un shell interactif dans le conteneur :

```bash
sudo docker exec -it sqlpreview bash
```

Dans le shell du conteneur, vérifiez que les fichiers .bak sont présents :

```bash
ls /var/opt/mssql/data/
```

Ouvrez DBeaver ou Azure Data Studio.

Connectez-vous à la base de données SQL Server en utilisant les informations de connexion suivantes :
   - Serveur: localhost,1433
   - Nom d'utilisateur: sa
   - Mot de passe: Admin123

Une fois connecté, rafraichissez la liste des bases de données pour voir les bases restaurées.

Ouvrez le script SQL contenant les instructions de requête, comme celui que vous avez précédemment préparé.

Exécutez le script SQL pour effectuer des opérations sur les bases de données restaurées.
