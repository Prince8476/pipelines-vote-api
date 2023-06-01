ARG GO_VERSION=1.15

FROM golang:${GO_VERSION}-alpine
ENV GO111MODULE=on
FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:latest as builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache && chmod 000 /tmp/cache
RUN go mod vendor && go mod tidy

RUN CGO_ENABLED=0 go build -o a.out .

ENTRYPOINT [ "/src/a.out" ]

FROM scratch

WORKDIR /app
COPY --from=builder /tmp/api-server /app/api-server

CMD [ "/app/api-server" ]
