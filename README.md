# drunner/simplesecrets
A dService that provides a simple secret storage and retrieval mechanism backed by S3.
Docker and dRunner are not needed for secret download/retrieval.

Intended primarily for bootstrapping before Crypt, Consul, Keywhiz or similar is installed.
SimpleSecrets allows you to store encrypted secrets in S3. They can be retrieved without
authentication via a [simple bash script](https://raw.github.com/j842/scripts/master/ssdownload).
Because the encrypted file is publicly available, security relies completely on the encryption,
which uses GPG and the CAST5 cipher. Use a strong passphrase or let SimpleSecrets generate one for you.

## Use with [dRunner](https://github.com/j842/drunner)

### Install

```
drunner install drunner/simplesecrets
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
S3KEY=abcde S3SECRET=1234 BUCKET=mybucket simplesecrets configure
```

### Storing Secrets

#### Simple Method
Now you can store secrets. If you don't care about the name or password:
```
simplesecrets store < myfile
```
This will automatically generate a password, and the secret will be stored by its MD5.

#### Updatable Secrets
To allow future updating of the secret, or to choose the name and password:
```
PASS=password123 simplesecrets store myname < myfile
```
You can use this from the first upload to choose a nice name and password.
You can also re-use the automatically generated ones to update something entered with
the simple method in the previous section.
Updating like this means clients will get the latest secret without any code/config changes.

You can also invalidate the old password by using the same name but a new password.
It will overwrite the old encrypted file.

### Retrieving Secrets
Retrieve using the [ssdownload script](https://drunner.s3.amazonaws.com/ssdownload)
using the arguments shown in the output of simplesecrets.
ssdownload can be installed and used without this dService.

Examples:
```
PASS=password123 ssdownload BUCKET NAME > myfile
PASS=password123 ssdownload BUCKET NAME OUTPUTFILE
```
If OUTPUTFILE is specified then the exit code is 3 if the file is unchanged (suitable for Ansible use).
