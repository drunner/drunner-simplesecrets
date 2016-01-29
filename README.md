# Docker-Simplesecrets
Docker repo to manage a simple secret service on S3. Not needed for secret download/retrieval.

## Use with dr

### Install

```
dr install j842/simplesecrets SERVICENAME
```

### Configuration 

After the base installation, 
* create an S3 Bucket, 
* create a folder /simplesecrets in that bucket,
* create a new policy to allow PutObject into all files in that folder,
* create a new IAM user and attach that policy,
* set the bucket policy to allow public read access (GetObject).

Then configure with the IAM user's key and secret and the name of the bucket:
```
S3KEY=abcde S3SECRET=1234 BUCKET=mybucket dr SERVICENAME configure
```

### Storing Secrets

#### Simple Method
Now you can store secrets. If you don't care about the name or password:
```
dr SERVICENAME store < myfile 
```
This will automatically generate a password, and the secret will be stored by its MD5.

#### Updatable Secrets
To allow future updating of the secret, or to choose the name and password:
```
PASS=password123 dr SERCICENAME store myname < myfile 
```
You can use this from the first upload to choose a nice name and password. 
You can also re-use the automatically generated ones to update something entered with 
the simple method in the previous section.
Updating like this means clients will get the latest secret without any code/config changes.

You can also invalidate the old password by using the same name but a new password.
It will overwrite the old encrypted file.

#### Retrieving Secrets
Retrieve using the ssdownload script as shown in the output of simplesecrets.
ssdownload is available from [GitHub](https://raw.github.com/j842/scripts/master/ssdownload).
It can be installed and used without this Docker container.


## Use without dr

### Installation

Create a data volume to store the configuration, e.g.
```
docker volume create --name simplesecrets-config
```

Configure it
```
S3KEY=abcde S3SECRET=1234 BUCKET=mybucket docker run --name=simplesecrets -i -v simplesecrets-config:/config \
       -e "S3KEY=\${S3KEY}" -e "S3SECRET=\${S3SECRET}" -e "BUCKET=\${BUCKET}" \
       j842/simplesecrets simplesecrets-config
docker rm simplesecrets
```

### Running

```
PASS=password docker run --name=simplesecrets -i -v simplesecrets-config:/config -e "PASS=\${PASS}" \
       j842/simplesecrets simplesecrets secretname
docker rm simplesecrets
```
