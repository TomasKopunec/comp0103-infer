## 1. How to run the tool
The verification tool only works on Gradle projects that are using JDK8. The verification tool uses SpotBugs and Meta Infer to check for issues in the Java code.

The tool can be run using the `run.sh` script in two modes:
- **Single File Mode**: To run the verification tool on a single Java file.
- **Project Mode**: To run the verification tool on a Java project.

The `run.sh` script takes the following arguments:
- `${path_to_project}`: The path to the Java project or Java file to run the verification tool on.
- `${class_name}`: The class name to run (Optional, only used in Single File Mode).

The `run.sh` builds a Docker image with the necessary dependencies and runs the verification tool on the Java code in the
specified project directory, printing the results to the terminal.

**Important note**: The `run.sh` script must be run in the directory that contains the Dockerfile, 
`verify.sh`, and `add_spotbugs.sh` files.

### Single File Mode
To run the verification tool on a single Java file, use the following command:
```bash
./run.sh ${path_to_project} ${class_name}
```
For example, to run the verification tool on a project that is on the Desktop  and the class name is project.objects.Person
the command would be:
```bash
./run.sh ~/Desktop/project project.objects.Person
```

This will output all the issues found in the Java file, along with the line number and description of the issue.

For example, if the Java file has a null pointer dereference in the `Person` class, the output will be as follows:
```
Building Docker container for project
✓ Container Built
Performing analysis on class project.objects.Person
✓ Plugins initialized
SpotBugs Analysis
X Failures:
H C NP: Null pointer dereference of s in project.objects.Person.nullDereference()  Dereferenced at Person.java:[line 6]
Infer Analysis
X Failures:
app/src/main/java/project/objects/Person.java:6: error: Null Dereference
  object `s` last assigned on line 5 could be null and is dereferenced at line 6.
  4.       void nullDereference() {
  5.           String s = null;
  6. >         System.out.println(s.length());
  7.       }
  8.   }

Found 1 issue
```

### Project Mode
To run the verification tool on a Java project, use the following command:
```bash
./run.sh ${path_to_project}
```
For example, to run the verification tool on a project that is on the Desktop, the command would be:
```bash
./run.sh ~/Desktop/project
```

This will output all the issues found in the project, along with the line number and description of the issue.

For example, if the project has a null pointer dereference in the `Person` class, the output will be as follows:
```
Building Docker container for project
✓ Container Built
Performing analysis on the whole project
✓ Plugins initialized
SpotBugs Analysis
X Failures:
H C NP: Null pointer dereference of s in project.objects.Person.nullDereference()  Dereferenced at Person.java:[line 6]
Infer Analysis
X Failures:
#0
app/src/main/java/project/objects/Person.java:6: error: Null Dereference
  object `s` last assigned on line 5 could be null and is dereferenced at line 6.
  4.       void nullDereference() {
  5.           String s = null;
  6. >         System.out.println(s.length());
  7.       }
  8.   }

Found 1 issue
          Issue Type(ISSUED_TYPE_ID): #
  Null Dereference(NULL_DEREFERENCE): 1
```

## 2. Output
The output of the verification tool will be displayed in the terminal. The output will include any issues found in the 
Java code, along with the line number and description of the issue. 

### Understanding the output
The output will include the following information:
- **SpotBugs Analysis**: The issues found by SpotBugs in the Java code.
- **Infer Analysis**: The issues found by Meta Infer in the Java code.
- **Failures**: The number of issues found in the Java code.

The output will also include the following information for each issue found:
- **Issue Type**: The type of issue found in the Java code.
- **Line Number**: The line number in the Java code where the issue was found.
- **Description**: A description of the issue found in the Java code.
- **Method Name**: The name of the method where the issue was found.
- **Class Name**: The name of the class where the issue was found.
- **File Name**: The name of the file where the issue was found.

### Passing Verification
Below is an example output of the verification tool that has passed all checks on a project:
```
Building Docker container for project
✓ Container Built
Performing analysis on the whole project
✓ Plugins initialized
SpotBugs Analysis
✓ SpotBugs Passed
Infer Analysis
✓ Infer Passed
Verification completed successfully. No issues found.
```

### Failed Verification
Given this Java code:
```java
public class App {
    void example() {
        String s = null;
        System.out.println(s.length());
    }
}
```
The output will report a null pointer dereference in the `example()` method of the `App` class as follows:
```
Building Docker container for project
✓ Container Built
Performing analysis on the whole project
✓ Plugins initialized
SpotBugs Analysis
X Failures:
H C NP: Null pointer dereference of s in project.App.example()  Dereferenced at App.java:[line 9]
Infer Analysis
X Failures:
#0
app/src/main/java/project/App.java:9: error: Null Dereference
  object `s` last assigned on line 8 could be null and is dereferenced at line 9.
   7.       void example() {
   8.           String s = null;
   9. >         System.out.println(s.length());
  10.       }
  11.   }

Found 1 issue
          Issue Type(ISSUED_TYPE_ID): #
  Null Dereference(NULL_DEREFERENCE): 1
```

In this example output, the verification tool has found an issue in the `App.java` file at line 9. The issue is a 
null pointer dereference in the `example()` method of the `App` class.

This issues can be easily fixed by adding a null check before calling the `length()` method on the `s` variable:
```java
public class Main {
    int example() {
        String s = null;
        System.out.println(s == null ? 0 : s.length());
    }
}
```

## Requirements
The tool works out of box and provides cross-platform functionality using Docker. 
The only requirements is to have **Docker** installed on the machine and the project to be verified should be a **Gradle project using JDK8.**

## Documentation links
https://spotbugs.readthedocs.io/en/latest/running.html#output-options
https://fbinfer.com/docs/hello-world