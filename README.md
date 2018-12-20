# mariadb:10.2-alpine

<p align="center">
	<img alt="logo-docker" class="avatar rounded-2" height="150" src="https://avatars2.githubusercontent.com/u/35675959?s=400&u=b1f9ebca6fa8e5be55cb524e16f38b52f2f1dd58&v=4" width="160">
	<br>
	Travis-CI<br>
	<a href="https://travis-ci.org/docker-sources/mariadb">
		<img src="https://travis-ci.org/docker-sources/mariadb.svg?branch=master" alt="Build Status">
	</a>
</p>

Essa é uma imagem **docker** criada para start simplificado de bases de dados utilizando o motor MariaDB.

As palavras-chave "DEVE", "NÃO DEVE", "REQUER", "DEVERIA", "NÃO DEVERIA", "PODERIA", "NÃO PODERIA", "RECOMENDÁVEL", "PODE", e "OPCIONAL" presentes em qualquer parte deste repositório devem ser interpretadas como descritas no [RFC 2119](http://tools.ietf.org/html/rfc2119). Tradução livre [RFC 2119 pt-br](http://rfc.pt.webiwg.org/rfc2119).

## Imagens disponíveis

 Consulte a guia [Tags](https://hub.docker.com/r/fabiojanio/mariadb/tags/) no repositório deste projeto no **Docker Hub** para ter acesso a outras versões.

## Pacotes presentes na imagem

 - MariaDB 10.2

## Considerações relevantes

 - Porta **3306** exposta
 - Arquivo **my.cnf** customizado e mínimo
 - Shell padrão: **sh**

## Start container

Essa instrução cria o container utilizando um volume compartilhado, essa abordagem permite persistir a base de dados fora do container:

```
docker run -d --name mariadb -p 3306:3306 -v mariadb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root fabiojanio/mariadb:10.2-alpine
```

Veja a lista de variáveis que podem ser passadas como parâmetro na criação do container. Ao omitir essas variaveis na criação do container, o respectivo valor padrão será atribuido:

 - MYSQL_ROOT_PASSWORD=root
 - MYSQL_DATABASE
 - MYSQL_PORT=3306
 - MYSQL_USER
 - MYSQL_PASSWORD
 - MYSQL_CHARACTER=utf8
 - MYSQL_COLLATION_SERVER=utf8_unicode_ci

**Obs**: observe que criamos o contaienr com a opção "-d", ou seja, ele será executado em background, como um daemon. Caso tenha a intenção de acompanhar o output da console, altere esse parâmetro para "-it".

Após a criação do container é possível se conectar a ele desta forma:

```
docker exec -it mariadb sh
```

## docker-compose.yml

Disponibilizei um [**docker-compose.yml**](docker-compose.yml) prontinho para subir uma aplicação *php + apache + banco de dados MariaDB*, efetue o download do arquivo, modifique os parâmetros necessários e posteriormente execute a instrução abaixo no mesmo local em que se encontra o arquivo [**docker-compose.yml**](docker-compose.yml):

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

Os passos anteriores estão configurados para utilizar a imagem já compilada disponível no **Docker Hub**, entretanto, caso queira compilar sua própria imagem, basta efetuar o download do arquivo [**Dockerfile**](Dockerfile), [**mysql_start.sh**](mysql_start.sh) e [**my.cnf**](my.cnf), modificar o que for necessário e executar a instrução:

```
docker build -t mariadb:10.2 .
```

Posteriormente pode criar o container executando:

```
docker run -d --name mariadb -p 3306:3306 -v mariadb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mariadb:10.2
```

E para conectar ao container executando:

```
docker exec -it mariadb sh
```

## Licença MIT

Para maiores informações, leia o arquivo de [licença](LICENSE) disponível neste repositório.