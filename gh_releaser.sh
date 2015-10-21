#!/bin/bash 

#Create the release
curl -H "Authorization: token $GITHUB_OAUTH_TOKEN" -H "Content-Type: application/json" -d '{ "tag_name": "v0.0.\$CIRCLE_BUILD_NUM", "target_commitish": "develop", "name": "v0.0.\$CIRCLE_BUILD_NUM", "body": "Release descrinption" }'  -X POST https://api.github.com/repos/TumbaSolutions/ref-android/releases

#Strip the upload URL from the release data
UPLOAD_URL=`curl -H "Authorization: token $GITHUB_OAUTH_TOKEN" https://api.github.com/repos/TumbaSolutions/ref-ios/releases/tags/v0.0.\$CIRCLE_BUILD_NUM | grep upload_url | awk '{print $2}' | sed -r 's/\{\?name,label\}",?|"//g'`

#Upload the apk to Github releases
curl -H "Authorization: token $GITHUB_OAUTH_TOKEN" -H "Content-Type: application/vnd.android.package-archive" -d @app/build/outputs/app-release.apk -X POST $UPLOAD_URL?name=Ref-Android-App

