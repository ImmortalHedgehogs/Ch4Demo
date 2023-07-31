[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/liatrio-delivery-povs/devops-knowledge-share-api/badge)](https://api.securityscorecards.dev/projects/github.com/liatrio-delivery-povs/devops-knowledge-share-api)
![CodeQL](https://github.com/liatrio-delivery-povs/devops-knowledge-share-api/workflows/CodeQL/badge.svg?branch=main)

# DevOps Knowledge Share DOB API

> **_Note:_** Please note this is the DevOps Bootcamp version of the [DevOps Knowledge Share API](https://github.com/liatrio-delivery-povs/devops-knowledge-share-api). Some of the contents of this repo were sanitized and various links/references may no longer function.

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [openjdk@11](https://openjdk.java.net/projects/jdk/11/)

### Local (gradle)
```bash
SPRING_PROFILES_ACTIVE=local ./gradlew clean bootRun
```

### Build Application
```bash
./gradlew clean build
```

> **_Note:_** If you make code changes ensure you run `./gradlew clean build` before attempting to run the `test`, `functionalTest`, or `contractTest` tasks below.

### Build and Run via Docker

1. Make sure that you have [Docker Desktop installed](https://docs.docker.com/desktop/mac/install/) and you have it running

2. Be sure to first build and run the devops-knowledge-share-api locally.

2. Use the following command to build your Docker image

   ```bash
   # Note: the --platform flag is required for building on Apple Silicon
   docker build -t <repo>/devops-knowledge-share-ui . --platform linux/amd64
   ```

3. Use the following command to start the container with port `3000` forwarded to your local machine

   ```bash
   docker run -p 8080:8080 -it <repo>/devops-knowledge-share-api
   ```

4. Navigate to `http://localhost:3000` to view your application

#### Run Unit Tests
```bash
./gradlew test
```

#### Run Functional Tests
```bash
./gradlew functionalTest
```

## Running Snyk scans Locally

> **_WARNING:_** Do not run `snyk monitor` from the command line locally as it should only be ran from CircleCI to maintain a single source of truth

Install the [Snyk CLI](https://docs.snyk.io/snyk-cli/install-the-snyk-cli)

```bash
brew tap snyk/tap
brew install snyk
```

Authenticate your Snyk CLI

```bash
snyk auth
```

Run `snyk test` to check for open source vulnerabilities and license issues

```bash
snyk test --severity-threshold=high --all-projects
```

Run `snyk code test` to find security issues using static code analysis

```bash
snyk code test --severity-threshold=high --all-projects
```

### docker-compose

1. Make sure you have cloned the repository for the [DevOps Knowledge Share UI](https://bitbucket.org/liatrio/devops-knowledge-share-ui/src/main/)
    - `$ git clone git@bitbucket.org:liatrio/devops-knowledge-share-ui.git`
1. Swap to your `devops-knowledge-share-api` directory
    ```bash
    $ cd <path>/<to>/devops-knowledge-share-api
    ```
1. Create API JAR file
    ```bash
    $ ./gradlew bootJar
    ```
1. Create `.env` file
    ```bash
    $ echo KNOWLEDGE_SHARE_API=http://api:8080 > .env
    $ echo SPRING_PROFILES_ACTIVE=local >> .env
    $ echo DKS_UI_DIR=/<absolute>/<path>/<to>/devops-knowledge-share-ui >> .env
    ```
1. `$ NPM_TOKEN=$(aws-vault exec <your team name>-prod -- aws codeartifact get-authorization-token --domain liatrio --output text --query authorizationToken) docker-compose up`
    - If you need to rebuild your API or UI docker images append `--build` to the end of the command above


## API defintions

With the application running, navigate to `<DKS API URL>/swagger-ui.html` to see existing
endpoints and test existing endpoints

## Healthcheck endpoints

* `/actuator/health/app`
