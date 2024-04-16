package project;

public class NullDereference {
    void issue() {
        String str = null;
        int length = str.length(); // Will throw a NullPointerException
    }
}
