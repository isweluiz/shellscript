#!/bin/bash
docker images| grep $1 |  awk '{print $3}' | grep -vi image | xargs docker rmi --force
