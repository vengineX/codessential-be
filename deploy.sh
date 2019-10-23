#!/usr/bin/env bash

# Work Folder / Back-End / Front-End 
export CDX_ROOT="~/gitdata/repos/private/codessential"
export CDX_BE="${CODEX_ROOT}/backend"
export CDX_FE="${CODEX_ROOT}/frontend"

export DEPLOY_IP="65.182.104.50"
export DEPLOY_USER="codessential"
export DEPLOY_CSTR="${DEPLOY_USER}@{DEPLOY_IP}"

if [[ -z $DEPLOY_PASSWD ]]; then
  read -p "Enter connection password to [ ${DEPLOY_CSTR} ]: " DEPLOY_PW
  DEPLOY_PASSWD=$( echo $DEPLOY_PW | base64 -i - ;) 
  unset DEPLOY_PW; export DEPLOY_PASSWD
else
  return 0
fi


ssh-keyscan -H "${1}" >> ~/.ssh/known_hosts
ssh "deploy@${1}" rm -rf ~/backend/*

scp -r ./server "dfeploy@${1}:/~backend/"
scp -r ./package.json "deploy@${1}:~/backend"
scp -r ./package-lock.json "deploy@${1}:/backend/"
ssh "${1}" "cd ~ ;\
  npm i; \
  forever stopall; \
  forever start server.js; "
