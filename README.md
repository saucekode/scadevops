# TASKS FOR SCALAGOS WEEK 1 SESSION 2
- Create s3 bucket from the cli. Name for s3 bucket should be yourname_scalagos
- Create an Iam user
- Attach a Policy to read S3 bucket AmazonS3ReadOnlyAccess to the user
- Create Access Keys for the User


## STEPS

#### INSTALL AWS CLI & AWS ROOT USER CONFIGURATION
Created a bash script to install aws cli via docker or locally. 

- clone or fork this repository
- cd into *wk1s2* folder in your terminal
- to run script, grant execution rights to files in this folder using this command: ```chmod +x *```
- for local installation, run this -- ```./main.sh --no-docker aws```, this command auto-detects your OS type and begins the installation process 
- for docker, run this: ```./main.sh --docker aws``` [I chose this approach]
- after the amazon/aws-cli iamge is pulled, it creates a container for you. If you prefer a custom name for your container, there is a prompt to enter a name
- next up is aws configuration, this prompts you for an access key, secret key, region, and output --- I chose json for output
- if previous step was successful, you should see your container running in your docker desktop


#### CREATE S3 BUCKET -- DOCKER APPROACH
Successfully pulled amazon/aws-cli image and spun up container? Let's create our S3 bucket!

- start docker container, cause it quits once the previous step is done. Use: ```docker start name-of-container```
- create an S3 bucket inside container: ```docker exec name-of-container aws s3 mb s3://name-of-bucket```
- view all your S3 buckets: ```docker exec name-of-container aws s3 ls```

P/S: for bucket name avoid using underscores

#### CREATE IAM USER -- DOCKER APPROACH
S3 bucket created successfully! Created a script to create user, setup user login profile, assign access keys, and attach policies

- create IAM user using command ```./main.sh --user-setup aws``` and follow the prompts

P/S: Find proof of work in process_shots folder here: https://drive.google.com/drive/folders/1OgapZuOJmXghctvdvrl-Y825A8LuYug3?usp=drive_link


# TASKS FOR SCALAGOS WEEK 2 SESSION 1
- Research and host a simple website on S3

## STEPS
Similar to Task 1, I will be using the CLI, which will run from Docker. Hosting my static files on an S3 bucket from my local machine requires syncing with AWS. The challenge is that I'm running this from Docker, so it needs to have a copy of my files. This is why we need to use a Docker volume.


#### CREATE A DOCKER VOLUME APPROACH
To sync my static files with AWS, I need to get a copy of them stored in a Docker volume, mount the volume to a target directory in a Docker container, and then perform the sync.

- create docker volume: ```docker volume create name-of-volume```
- Spin up new container and mount volume to target directory in container:
```docker run -it -v ~path-to-file-locally:target-directory-in-container --name name-of-container amazon/aws-cli configure```

P/S: If static files is stored in user-specific directory like Desktop, Documents, etc, use the ~ when running this command to avoid permission issues.

- sync target directory in Docker container to AWS s3 bucket:
``` aws s3 sync /target-directory-in-docker-container s3://bucket-name ```
- Log into console to confirm


#### SETUP STATIC WEBSITE
Still in the console: 
- on the created s3 bucket, under properties, enable static website
- input default page for your website, mine was index.html. Proceed to save.
- url generated, here's mine: https://bit.ly/3KMmy4f


#### SETUP BUCKET POLICY
Under permissions:
- turn off *Block all public access*, to enable access to your website
- add a bucket policy to allow your website to be viewed by anyone:
``` 
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicReadGetObject",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::amaka-scalagos/*"
            }
        ]
    }
```
P/S: Find proof of work in process_shots folder here: https://drive.google.com/drive/folders/1-_MATmvnXjuC8XgU4jIpvVJ8soVKs8HA?usp=drive_link


### The End!


