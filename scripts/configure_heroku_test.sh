#!/bin/bash
# IMPORTANT: before running this script ensure to run heroku login!!!!

set -e

# heroku login

APP_NAME=moscu-api-test
SUMOLOGIC_SOURCE=https://endpoint4.collection.sumologic.com/receiver/v1/http/ZaVnC4dhaV0OpdE-tm8141botebVLwtuZeEWsXEAsVDudjvDqCxDEexlLO0w3rdTipY1eISTv-_b1boalbCUk0dIGg9HMVrZ43V37Z_01cVucp3XnVRK-Q==

heroku apps:create $APP_NAME
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
heroku config:set RACK_ENV=production --app $APP_NAME
heroku drains:add $SUMOLOGIC_SOURCE --app $APP_NAME
