FROM adoptopenjdk/openjdk11:alpine as builder

WORKDIR /app

ENV JAR=devops-knowledge-share-api.jar
ARG CODEARTIFACT_AUTH_TOKEN

RUN apk add --no-cache gradle~=6

COPY build.gradle settings.gradle ./

RUN gradle build -i --stacktrace

COPY src/ src/

RUN gradle bootJar

FROM adoptopenjdk/openjdk11:alpine-jre as runner

WORKDIR /app
ENV JAVA_ENABLE_DEBUG=${JAVA_ENABLE_DEBUG}
ENV JAR=devops-knowledge-share-api.jar

COPY entrypoint.sh .
COPY --from=builder /app/build/libs/${JAR} .
RUN apk add --no-cache curl musl~=1 libtasn1~=4 libjpeg-turbo~=2 && \
    addgroup --system appuser -g 1001 && \
    adduser --system -g appuser -u 1001 appuser && \
    mkdir -p /app/data && \
    chown -R appuser:appuser /app && \
    chown appuser:appuser ${JAR} && \
    chmod 500 ${JAR}

EXPOSE 8080
USER 1001

CMD ["./entrypoint.sh"]
