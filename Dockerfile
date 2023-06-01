FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:latest as builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache && chmod 000 /tmp/cache

FROM scratch

WORKDIR /app
COPY --from=builder /tmp/api-server /app/api-server

CMD [ "/app/api-server" ]
