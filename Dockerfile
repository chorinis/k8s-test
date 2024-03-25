FROM openjdk:11-jre-slim

# Встановлення Liquibase
ENV LIQUIBASE_VERSION=4.5.0

RUN apt-get update && apt-get install -y wget

RUN wget -O liquibase-${LIQUIBASE_VERSION}.tar.gz https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz \
    && tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz \
    && rm liquibase-${LIQUIBASE_VERSION}.tar.gz \
    && chmod +x liquibase \
    && mv liquibase /usr/local/bin/

# Копіювання конфігураційних файлів (якщо вони потрібні)
COPY ./liquibase.properties /liquibase.properties

COPY ./db/changelog /liquibase/changelog

# Команда за замовчуванням для запуску
CMD ["liquibase", "--help"]