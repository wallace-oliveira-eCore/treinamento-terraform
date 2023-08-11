#!/bin/bash

yum update -y
yum install ${PACKAGE} -y
systemctl enable ${SERVICE} --now
