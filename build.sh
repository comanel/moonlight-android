rm app/build/outputs/apk/nonRoot/release/app-nonRoot-release-unsigned.apk
./gradlew clean build
keytool -genkey -keystore selfsigned.keystore -keyalg RSA -keysize 2048 \
        -validity 10000 -alias app -dname "cn=Unknown, ou=Unknown, o=Unknown, c=Unknown" \
        -storepass potato -keypass potato
jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore selfsigned.keystore -storepass potato -keypass potato -signedjar moonlightsigned.apk app/build/outputs/apk/nonRoot/release/app-nonRoot-release-unsigned.apk app
rm signed.apk
zipalign -v 4 moonlightsigned.apk signed.apk
