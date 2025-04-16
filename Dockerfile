FROM gpac/ubuntu

# 更新 apt 源并安装中文语言包、ffmpeg、ttyd 等
RUN apt update && apt install -y \
    locales \
    ffmpeg \
    screen \
    ttyd \
    nano \
    fonts-noto-cjk \
    && locale-gen zh_CN.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./wrapper /app/
COPY ./wrapper /backup/
COPY ./mp4decrypt /usr/bin/
COPY ./dl /app/
COPY ./config.yaml /app/amdl/
COPY ./config.yaml /backup/
COPY ./start.sh /app/
RUN ln -s /app/dl /usr/bin

# 权限设置
RUN chmod -R 755 /app && chmod 755 /usr/bin/mp4decrypt && chmod 755 /app/start.sh

# 配置 screen
RUN echo 'mouse on' > /root/.screenrc

# 设置语言环境变量
ENV LANG=zh_CN.UTF-8
ENV TERM=xterm-256color

# 设置 ttyd 登录账户密码（通过环境变量传递）
ENV TTYD_USERNAME=admin
ENV TTYD_PASSWORD=123456

ENV args ""

CMD bash -c "/app/start.sh && /app/wrapper ${args}"
