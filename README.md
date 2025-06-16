# env4dev

包含一个Dockerfile文件，用于构建Java项目编译环境

* 使用 AdoptOpenJDK 8 作为基础镜像（Hotspot 版）
* 安装 Git、wget、curl 等必要工具
* 预装JDK8 和 JDK17，默认JAVA_HOME设置为JDK8
* 预装maven 版本3.6.3
  * maven配置settings.xml文件可在运行容器时挂载自己的进行覆盖
  * maven 本地仓库支持挂载映射，容器内默认本地仓库路径：/data/maven/localRepository，请与setting.xml配置的本地仓库路径保持一致
* 项目路径映射容器内工作路径：/workspace

## 文件说明

- Dockerfile
- build.sh

## usage

```bash
sh build.sh jdk8 [maven version]
```

