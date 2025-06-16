ARG JDK_VERSION=8
ARG MAVEN_VERSION=

FROM adoptium/temurin:${JDK_VERSION}-jdk

ARG JDK_VERSION
ARG MAVEN_VERSION

RUN set -eux; \
    # 读取系统代号，如 bullseye, bookworm
    codename=$(grep VERSION_CODENAME /etc/os-release | cut -d= -f2); \
    echo "Detected Debian codename: $codename"; \
    # 写入阿里源配置文件
    echo "deb http://mirrors.aliyun.com/debian/ $codename main contrib non-free" > /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ $codename main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian-security $codename-security main" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian-security $codename-security main" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian/ $codename-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ $codename-updates main contrib non-free" >> /etc/apt/sources.list; \
    apt-get update && apt-get install -y git wget curl unzip vim && rm -rf /var/lib/apt/lists/*

# 先更新系统工具
RUN apt-get install -y git wget curl unzip vim && \
    rm -rf /var/lib/apt/lists/*

# 选择 Maven 版本
RUN if [ -z "$MAVEN_VERSION" ]; then \
      if [ "$JDK_VERSION" = "8" ]; then MAVEN_VERSION=3.6.3; \
      elif [ "$JDK_VERSION" = "11" ]; then MAVEN_VERSION=3.8.8; \
      elif [ "$JDK_VERSION" = "17" ]; then MAVEN_VERSION=3.9.6; \
      elif [ "$JDK_VERSION" = "21" ]; then MAVEN_VERSION=3.9.6; \
      else echo "Unsupported JDK_VERSION: $JDK_VERSION" && exit 1; fi; \
    fi && \
    echo "Installing Maven $MAVEN_VERSION for JDK $JDK_VERSION" && \
    mkdir -p /opt/maven && cd /opt/maven && \
    wget https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} apache-maven && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    echo $MAVEN_VERSION > /opt/maven/maven_version

ENV MAVEN_VERSION=${MAVEN_VERSION}
ENV MAVEN_HOME=/opt/maven/apache-maven
ENV PATH=$MAVEN_HOME/bin:$PATH

RUN mkdir -p /root/.m2/repository

WORKDIR /workspace

CMD echo "容器已启动，JDK=$JDK_VERSION，Maven=$MAVEN_VERSION" && java -version && mvn -version && bash
