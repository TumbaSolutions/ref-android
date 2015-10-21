#!/bin/bash 

RELEASE_NOTES=`cat ./release_notes`
REQUEST_BODY='{ "tag_name": "v0.0.'"$CIRCLE_BUILD_NUM"'", "target_commitish": "master", "name": "v0.0.'"$CIRCLE_BUILD_NUM"'", "body": "'"$RELEASE_NOTES"'" }'
HEADER1="Content-Type: application/json"
HEADER2="Authorization: token $GITHUB_OAUTH_TOKEN"
HEADER3="Content-Type: application/octet-stream"
ARTIFACT="@app/build/outputs/apk/app-release.apk"
REQUEST_URL="https://api.github.com/repos/TumbaSolutions/ref-android/releases"

#Create the release and notes in Github
curl -H "$HEADER2" -H "$HEADER1" -d "$REQUEST_BODY"  -X POST "$REQUEST_URL"

#Strip the upload URL from the release data
curl -H "Authorization: token $GITHUB_OAUTH_TOKEN" $REQUEST_URL/tags/v0.0.$CIRCLE_BUILD_NUM
UPLOAD_URL=`curl -H "Authorization: token $GITHUB_OAUTH_TOKEN" $REQUEST_URL/tags/v0.0.$CIRCLE_BUILD_NUM | grep upload_url | awk '{print $2}' | sed -r 's/\{\?name,label\}",?|"//g'`

#Upload the apk to Github releases
curl -H "$HEADER2" -H "$HEADER3" -d $ARTIFACT -X POST $UPLOAD_URL?name=Ref-Android-App

