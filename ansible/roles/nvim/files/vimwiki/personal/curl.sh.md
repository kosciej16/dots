#!/bin/bash
ACCESS_TOKEN=""
curl \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  https://www.googleapis.com/fitness/v1/users/me/dataSources
