# docker-simplesecrets
Docker repo to manage a simple secret service on S3.

Call:
```
bin/init
bin/install
```

Then
```
S3KEY=abcde S3SECRET=1234 BUCKET=mybucket ; simplesecrets-config
PASS=password123 ; cat myfile | simplesecrets 
```

Thgen use the ssdownload script with no dependencies or config:
```
PASS=password123 ; ssdownload -b BUCKET HASH > myfile
```
(available here: ...)
