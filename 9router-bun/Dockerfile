FROM oven/bun:debian

WORKDIR /app

RUN bun init -y
RUN bun add 9router

ENV NODE_ENV=production
ENV HOSTNAME=0.0.0.0
ENV PORT=20128
ENV DATA_DIR=/app/data
ENV NEXT_PUBLIC_BASE_URL=http://localhost:20128

RUN mkdir -p /app/data

EXPOSE 20128

CMD ["bunx", "--bun", "9router", "-p", "20128", "-H", "0.0.0.0", "--no-browser", "-t", "-l", "--skip-update"]
