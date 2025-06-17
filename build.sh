#!/bin/bash

# 使用说明
usage() {
  echo "用法: $0 <jdk版本> <镜像标签名>"
  echo "示例: $0 jdk8 my-maven-dev"
  exit 1
}

# 检查参数
if [ $# -ne 2 ]; then
  usage
fi

jdk_version=$1
image_tag=$2

# 根据 JDK 版本选择 Maven 镜像
case "$jdk_version" in
  jdk8)
    maven_image="maven:3.6.3-openjdk-8"
    ;;
  jdk11)
    maven_image="maven:3.8.6-openjdk-11"
    ;;
  jdk17)
    maven_image="maven:3.8.5-openjdk-17"
    ;;
  jdk21)
    maven_image="maven:3.9.9-eclipse-temurin-21"
    ;;
  *)
    echo "❌ 不支持的 JDK 版本: $jdk_version"
    usage
    ;;
esac

# 构建镜像
echo "🔧 使用基础镜像: $maven_image"
echo "🚀 构建镜像标签: $image_tag"

docker build \
  --build-arg MAVEN_IMAGE="$maven_image" \
  -t "$image_tag" \
  .