
## 1. Build Container Image
To build and make the Docker image available, run the following command in the terminal:
```bash
docker build -t java_verification_tool .
```
This will create a Docker image with the name `java_verification_tool` that can be used to run the verification tool.

## 2. Run Verification
Once the Docker image is built, the verification tool can be run using the following command:
```bash
./run.sh ${path_to_java_file}
```
For example, to run the verification tool on the `Example.java` file in the `src` directory, run the following command:
```bash
./run.sh src/Example.java
```
The verification tool will run and output the results to the terminal.

## 3. Output
The output of the verification tool will be displayed in the terminal. The output will include any issues found in the 
Java code, along with the line number and description of the issue. 

Below is an example output of the verification tool that has passed all checks:
```bash
./run.sh src/Example.java 
```
```
Running verification for Example.java...
Starting verification tool...
Running verification for Example...

SpotBugs
Scanning archives (1 / 1)
2 analysis passes to perform
Pass 1: Analyzing classes (12 / 12) - 100% complete
Pass 2: Analyzing classes (1 / 1) - 100% complete
Done with analysis
OK ✓

Meta Infer
OK ✓
Verification completed successfully. No issues found.
```

Below is an example that has failed some checks:
```bash
./run.sh src/Example.java 
```
```
Running verification for Example.java...
...
SpotBugs
Scanning archives (1 / 1)
2 analysis passes to perform
Pass 1: Analyzing classes (12 / 12) - 100% complete
Pass 2: Analyzing classes (1 / 1) - 100% complete
Done with analysis
OK ✓

Meta Infer
OK ✓
Verification completed successfully. No issues found.
```



## Documentation links
https://spotbugs.readthedocs.io/en/latest/running.html#output-options
https://fbinfer.com/docs/hello-world