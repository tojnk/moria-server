# syntax=docker/dockerfile:1
FROM steamcmd/steamcmd:ubuntu-22
RUN mkdir /moriaserver

# install wine
RUN apt-get update && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && apt update \
    && apt install --install-recommends winehq-stable -y \
    && apt install -y xvfb

# download VS2017 C++ runtime
RUN wget "https://aka.ms/vs/17/release/vc_redist.x64.exe"

# install mono
RUN apt-get install -y xz-utils \
    && mkdir -p /usr/share/wine/mono \
    && wget -O /usr/share/wine/mono/mono.tar.xz "https://dl.winehq.org/wine/wine-mono/9.4.0/wine-mono-9.4.0-x86.tar.xz" \
    && tar -xf /usr/share/wine/mono/mono.tar.xz -C /usr/share/wine/mono/ \
    && rm /usr/share/wine/mono/mono.tar.xz

EXPOSE 7777/udp
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
