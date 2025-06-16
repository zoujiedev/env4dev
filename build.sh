#!/bin/bash

# 使用方式：./build.sh jdk8
jdk_tag="$1"

if [[ -z "$jdk_tag" ]]; then
  echo "❌ 用法: ./build.sh jdk8 | jdk17 | jdk21 [可选自定义 Maven 版本]"
  exit 1
fi

# 提取 JDK 版本号
case "$jdk_tag" in
  jdk8)  jdk_version=8 ;;
  jdk11) jdk_version=11 ;;
  jdk17) jdk_version=17 ;;
  jdk21) jdk_version=21 ;;
  *) echo "❌ 不支持的 JDK 标识: $jdk_tag" && exit 1 ;;
esac

# 可选: 传入第二个参数指定 Maven 版本
maven_version="$2"

# 构建命令
build_cmd="docker build --build-arg JDK_VERSION=$jdk_version"
tag_name="myapp:${jdk_tag}"

if [[ -n "$maven_version" ]]; then
  build_cmd="$build_cmd --build-arg MAVEN_VERSION=$maven_version"
  tag_name="${tag_name}-maven${maven_version}"
fi

build_cmd="$build_cmd -t $tag_name ."

echo "🚀 正在构建镜像: $tag_name"
echo "$build_cmd"
eval "$build_cmd"