## 1. Run Verification Tool
The verification tool only works on Gradle projects that are using JDK8. The verification tool uses SpotBugs and Meta Infer to check for issues in the Java code.
It can be run using the following command:
```bash
./run.sh ${path_to_project}
```
For example, to run the verification tool on a project that is on the Desktop, the command would be:
```bash
./run.sh ~/Desktop/project
```

This builds a Docker image with the necessary dependencies and runs the verification tool on the Java code in the 
specified project directory, printing the results to the terminal.

TODO Decide whether to analyse whole project or just the file specified in the command line.

## 2. Output
The output of the verification tool will be displayed in the terminal. The output will include any issues found in the 
Java code, along with the line number and description of the issue. 

### Passing Verification
Below is an example output of the verification tool that has passed all checks:
```bash
./run.sh src/Main.java 
```
```
Starting verification for Main.java...
Running verification for Main...

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

### Failed Verification
Given this Java code:
```java
public class Main {
    int test() {
        String s = null;
        return s.length();
    }
}
```
The output will report a null pointer dereference in the `test()` method of the `Main` class as follows:
```bash
./run.sh src/Main.java 
```
```
Starting verification for Main.java...
Running verification for Main...

SpotBugs
Scanning archives (1 / 1)
2 analysis passes to perform
Pass 1: Analyzing classes (12 / 12) - 100% complete
Pass 2: Analyzing classes (1 / 1) - 100% complete
Done with analysis
FAILED X
Main.java:4:4 NP: Null pointer dereference of ? in Main.test() (H) 
```

In this example output, the verification tool has found an issue in the `Main.java` file on line 4, column 4. The issue is a 
null pointer dereference in the `test()` method of the `Main` class.

This issues can be easily fixed by adding a null check before calling the `length()` method on the `s` variable:
```java
public class Main {
    int test() {
        String s = null;
        return s == null ? 0 : s.length();
    }
}
```

## Documentation links
https://spotbugs.readthedocs.io/en/latest/running.html#output-options
https://fbinfer.com/docs/hello-world