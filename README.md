# comp0103-infer

Step 1: Install Dependencies
First, ensure that your system is updated and has the necessary tools to download and compile Infer.

sudo apt-get update
sudo apt-get install -y curl git build-essential openjdk-8-jdk maven

Step 2: Download and Install Infer
Download the latest version of Infer. As of my last update, you can download Infer from its GitHub repository. Check the Infer GitHub releases page for the latest version.

curl -L https://github.com/facebook/infer/releases/download/v1.1.0/infer-linux64-v1.1.0.tar.xz | tar xJ

Replace v1.1.0 with the latest version if needed. Move the extracted folder to a more permanent location:

sudo mv infer-linux64-v1.1.0 /opt/infer

Add Infer to your PATH:

export PATH=/opt/infer/bin:$PATH

Step 3: Prepare Your Java Project
Make sure your Java project is ready to be analyzed. It should be compilable with Maven.

Step 4: Run Infer
Navigate to your Java project directory and run Infer:

cd /path/to/your/java/project
infer run -- mvn compile
