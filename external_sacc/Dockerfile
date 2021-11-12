# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

ARG GO_VER=1.14.4
ARG ALPINE_VER=3.12

FROM golang:${GO_VER}-alpine${ALPINE_VER}

WORKDIR /go/src/github.com/hyperledger/fabric-samples/sacc
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

EXPOSE 9998
#CMD ["go run /go/src/github.com/hyperledger/fabric-samples/sacc/external_sacc.go"]
CMD ["go", "run", "external_sacc.go"]