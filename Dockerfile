# ベースイメージ
FROM ruby:2.7.1-alpine

# 変数
ARG WORKDIR

# 環境変数
ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

# ベースイメージへの命令
RUN echo ${HOME}

# 作業ディレクトリの指定
WORKDIR ${HOME}

# COPY <ローカルのファイルパス> <Dokerイメージのファイルパス>
COPY Gemfile* ./

# Alpine Linuxのコマンド

# 利用可能なパッケージの最新リストを取得
RUN apk update && \
# インストールされているパッケージをアップグレード
    apk upgrade && \
# ローカルにキャッシュしないようにする、addコマンド
    apk add --no-cache ${RUNTIME_PACKAGES} && \
# パッケージをまとめる
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
# パッケージの削除
    apk del build-dependencies

COPY . .

# コンテナ内でのコマンドの実行
CMD ["rails", "server", "-b", "0.0.0.0"]
