# MariaDB

<p align="center">
	<img alt="logo-docker" class="avatar rounded-2" height="150" src="https://avatars2.githubusercontent.com/u/35675959?s=400&u=b1f9ebca6fa8e5be55cb524e16f38b52f2f1dd58&v=4" width="160">
	<br>
	Travis-CI<br>
	<a href="https://travis-ci.org/docker-sources/mariadb">
		<img src="https://travis-ci.org/docker-sources/mariadb.svg?branch=master" alt="Build Status">
	</a>
</p>

Essa é uma imagem **docker** criada para start simplificado de bases de dados utilizando o motor **MariaDB**, tendo como base um sistema minimalista, simples, flexível e robusto chamado Alpine.

As palavras-chave "DEVE", "NÃO DEVE", "REQUER", "DEVERIA", "NÃO DEVERIA", "PODERIA", "NÃO PODERIA", "RECOMENDÁVEL", "PODE", e "OPCIONAL" presentes em qualquer parte deste repositório devem ser interpretadas como descritas no [RFC 2119](http://tools.ietf.org/html/rfc2119). Tradução livre [RFC 2119 pt-br](http://rfc.pt.webiwg.org/rfc2119).

## Imagens disponíveis

 Consulte a guia [Tags](https://hub.docker.com/r/fabiojanio/mariadb/tags/) no repositório deste projeto no **Docker Hub** para ter acesso a lista de versões disponíveis.

## Considerações relevantes

 - Porta **3306** exposta
 - Arquivo **my.cnf** customizado e mínimo
 - Shell padrão: **sh**

## Start container

Essa instrução cria o container utilizando um volume, essa abordagem permite persistir a base de dados fora do container:

```
docker run -d --name mariadb -p 3306:3306 -v mariadb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root fabiojanio/mariadb
```

Veja a lista de variáveis que podem ser passadas como parâmetro na criação do container. Ao omitir essas variaveis na criação do container, o respectivo valor padrão será atribuido:

 - MYSQL_ROOT_PASSWORD=root
 - MYSQL_DATABASE
 - MYSQL_PORT=3306
 - MYSQL_USER
 - MYSQL_PASSWORD
 - MYSQL_CHARACTER=utf8
 - MYSQL_COLLATION_SERVER=utf8_unicode_ci

**Obs**: caso o volume de dados já exista, ao criar um novo container a senha do usuário ROOT será preservada, este comportamento foi configurado no [**mysql_start.sh**](https://github.com/docker-sources/mariadb/blob/master/mysql_start.sh) como forma de evitar alterações "descuidadas por parte do usuário.

Após a criação do container é possível se conectar a ele desta forma:

```
docker exec -it mariadb sh
```

## docker-compose.yml

Disponibilizei um [**docker-compose.yml**](https://github.com/docker-sources/mariadb/blob/master/docker-compose.yml) prontinho para subir uma aplicação *php + apache + banco de dados MariaDB*, efetue o download do arquivo, modifique os parâmetros necessários e posteriormente execute a instrução abaixo no mesmo local em que se encontra o arquivo [**docker-compose.yml**](https://github.com/docker-sources/mariadb/blob/master/docker-compose.yml):

```
docker-compose up -d
```

Neste arquivo os containers estão nomeados como **web** e **mariadb**. Para se conectar:

```
docker exec -it web bash
```
e

```
docker exec -it mariadb sh
```

## Build (opcional)

Os passos anteriores estão configurados para utilizar a imagem já compilada disponível no **Docker Hub**, entretanto, caso queira compilar sua própria imagem, basta efetuar o download do arquivo [**Dockerfile**](https://github.com/docker-sources/mariadb/blob/master/docker-compose.yml), [**mysql_start.sh**](https://github.com/docker-sources/mariadb/blob/master/mysql_start.sh) e [**my.cnf**](https://github.com/docker-sources/mariadb/blob/master/my.cnf), modificar o que for necessário e executar a instrução:

```
docker build -t mariadb:latest .
```

Posteriormente pode criar o container executando:

```
docker run -d --name mariadb -p 3306:3306 -v mariadb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mariadb
```

E para conectar ao container executando:

```
docker exec -it mariadb sh
```

## Licença MIT

Para maiores informações, leia o arquivo de [licença](https://github.com/docker-sources/mariadb/blob/master/LICENSE) disponível neste repositório.