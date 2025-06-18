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

构建环境镜像
```bash
sh build.sh jdk8 buildenv:jdk8
```

编译项目
```bash
docker run -it --rm \
    -v /path/to/youproject:/workspace \ #映射工作路径
    -v /path/to/yoursettings.xml:/root/.m2/settings.xml \  #映射maven配置文件(可选)
    -v /path/to/yourlocalrepository:/root/.m2/repository \ #映射maven本地仓库(可选)
    <Image Tag>
```

进入容器交互bash终端后
```bash
cd /workspace
```
即可看到外部宿主机共享的项目，从而进行编译
如：
```bash
mvn clean package
```