# env4dev

包含一个Dockerfile文件，用于构建Java项目编译环境

* 使用 maven:openjdk 作为基础镜像
* maven 配置
  * maven配置settings.xml文件可在运行容器时挂载自己的进行覆盖
  * maven 本地仓库支持挂载映射，容器内默认本地仓库路径：~/.m2/repository，如果外部覆盖setting.xml，请与setting.xml配置的本地仓库路径保持一致
* 项目路径映射容器内工作路径：/workspace

## 文件说明

- Dockerfile
- build.sh

## usage
- sh build.sh \<jdk version> \<ImageTag>
- jdk 支持：jdk8 jdk11 jdk17 jdk21
- Image Tag格式: <镜像名>:<标签>
- 标签可省略，默认为latest

```bash
sh build.sh jdk8 buildenv:jdk8
```

