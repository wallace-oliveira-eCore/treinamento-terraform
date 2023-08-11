#!/bin/bash
yum update -y

yum install ${PACKAGE_NAME} -y
systemctl enable ${SERVICE_NAME} --now
