## TASKS FOR SCALAGOS WEEK 1 SESSION 2
- Create s3 bucket from the cli. Name for s3 bucket should be yourname_scalagos
- Create an Iam user
- Attach a Policy to read S3 bucket AmazonS3ReadOnlyAccess to the user
- Create Access Keys for the User


## STEPS

### INSTALL AWS CLI & AWS ROOT USER CONFIGURATION
Created a bash script to install aws cli via docker or locally. 

- clone or fork this repository
- cd into "wk1s2" folder in your terminal
- to run script, grant execution rights to files in this folder using this command: "chmod +x *"
- for local installation, run this "./main.sh --no-docker aws", this command auto-detects your OS type and begins the installation process 
- for docker, run this "./main.sh --docker aws" [I chose this approach]
- after the amazon/aws-cli iamge is pulled, it creates a container for you. If you prefer a custom name for your container, there is a prompt to enter a name
- next up is aws configuration, this prompts you for an access key, secret key, region, and output --- I chose json for output
- if previous step was successful, you should see your container running in your docker desktop


### CREATE S3 BUCKET -- DOCKER APPROACH
Successfully pulled amazon/aws-cli image and spun up container. Let's create our S3 bucket!

- start docker container, cause it quits once the previous step is done. Use command "docker start [name-of-container]". 
- create an S3 bucket inside container using command "docker exec [name-of-container] aws s3 mb s3://[name-of-bucket]"
- view all your S3 buckets using command "docker exec [name-of-container] aws s3 ls"

P/S: for bucket name avoid using underscores

### CREATE IAM USER -- DOCKER APPROACH
S3 bucket created successfully! Created a script to create user, setup user login profile, assign access keys, and attach policies

- create IAM user using command "./main.sh --user-setup aws" and follow the prompts

P/S: Find proof of work in process_shots folder here: https://drive.google.com/drive/folders/15DOfazMQCqS85AnDDZB-JybhNZeSC5R-?usp=drive_link

### The End!


