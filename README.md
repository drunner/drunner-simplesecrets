# docker-simplesecrets
Docker repo to manage a simple secret service on S3. Not needed for secret download/retrieval.

To initialise and install:
```
bin/init
bin/install
```

Then:
* create an S3 Bucket, 
* create a folder /simplesecrets in that bucket
* create a new policy to allow PutObject into all files in that folder
* create a new IAM user and attach that policy
* set the bucket policy to allow public read access (GetObject)

Then configure with the IAM user's key and secret and the name of the bucket:
```
S3KEY=abcde S3SECRET=1234 BUCKET=mybucket simplesecrets-config
```

Now you can store secrets, e.g.:
```
PASS=password123 simplesecrets [NAME] < myfile 
```
If the environment variable PASS is set it will use that, otherwise generate a random
passphrase.

Then use the ssdownload script as shown in the output of simplesecrets:
```
PASS=password123 ; ssdownload BUCKET HASH [NAME] > myfile
```
PASS is required for ssdownload, which is available from [GitHub](https://raw.github.com/j842/scripts/master/ssdownload)
It can be installed and used without this Docker container.
