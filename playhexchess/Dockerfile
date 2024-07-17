FROM nginx:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install git curl gcc openssh-client openssh-server libssl-dev pkg-config -y

# Install the rust toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"
# Install the hexchess repo
RUN git clone https://github.com/williamsnell/hexchess.git

WORKDIR /hexchess/server
RUN cargo build -r

# Only build the bumblebot agent's executable, which gets
# called by the server when needed.
WORKDIR /hexchess/bumblebot
RUN cargo build -r


# Install NPM for the frontend
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -s -- -y
RUN apt-get install -y nodejs
RUN npm install -D vite

COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

RUN chmod +x /hexchess/frontend/build.sh

COPY playhexchess.com /etc/nginx/conf.d/playhexchess.conf

ENTRYPOINT ["./entrypoint.sh"]
