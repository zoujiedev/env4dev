ARG BASE_IMAGE=maven:3.6.3-openjdk-8
FROM ${BASE_IMAGE}

# 创建一个工作目录（可随时进入）
WORKDIR /workspace

# 声明可挂载路径（文档作用）
VOLUME ["/workspace", "/root/.m2"]

# 启动默认交互式 shell
CMD ["bash"]
