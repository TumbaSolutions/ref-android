# Tumba way of building and distributing iOS apps

### Prerequisites
 - Github repo
 - CircleCI account 
 - Gradle
 
 ## Continuous Integration
   - gradle configuration - builds, tests and distributes the app
     - configure app signing
     - configure gradle tasks 
   - circle.yml configures the build environment and calls the build/test commands:
     - configure the environment - GRADLE_OPTS: -Xmx512m -XX:MaxPermSize=512m
     - assemble the app and run unit tests
     - save the build outputs and test results to CircleCI artifacts for easy access 

 ## Continuous delivery
  - ### Test phase - Crashlitics
    - circle.yml 
      - fetches the keystore from AWS S3
      - signs the app with the development cert
      - ships the app to Crashlitics
  - ### UAT and Release
    - no clear UAT procedure;
    - signs the app with the distribution key
    - publish the app - https://developers.google.com/android-publisher/
    
  
