FROM gpac/ubuntu

RUN apt update && apt install -y screen ttyd fonts-noto-cjk && rm -rf /var/lib/apt/lists/*
WORKDIR /app
#COPY --from=builder /app /app
COPY ./wrapper /app/
COPY ./wrapper /backup/
COPY ./mp4decrypt /usr/bin/
COPY ./dl /app/
COPY ./config.yaml /app/amdl/
COPY ./config.yaml /backup/
RUN ln -s /app/dl /usr/bin
COPY ./start.sh /app/
RUN chmod -R 755 /app&& chmod 755 /usr/bin/mp4decrypt&&chmod 755 /app/start.sh
RUN echo 'mouse on' > /root/.screenrc
ENV args ""

#CMD ["bash", "-c", "/app/wrapper ${args}"]
CMD bash -c "/app/start.sh && /app/wrapper ${args}"
