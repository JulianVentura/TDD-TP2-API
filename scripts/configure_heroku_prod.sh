#!/bin/bash
# IMPORTANT: before running this script ensure to run heroku login!!!!

set -e

# heroku login

APP_NAME=moscu-api-prod
SUMOLOGIC_SOURCE=https://endpoint4.collection.sumologic.com/receiver/v1/http/ZaVnC4dhaV2Teo1N2S5scz9X6pC5RU-QoruRaEDm-4r0UVVGW8RnLoVOUx5CKK_Q2pgmEgnrhCRmESqb-7PYlBZ20-QuA3O3hIr1QEkWqwEUbPtNlYceVg==

heroku apps:create $APP_NAME
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
heroku config:set RACK_ENV=production --app $APP_NAME
heroku drains:add $SUMOLOGIC_SOURCE --app $APP_NAME
