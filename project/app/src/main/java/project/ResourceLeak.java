package project;

import java.io.FileInputStream;

public class ResourceLeak {
    int handleFile() throws Exception {
        FileInputStream inputStream = new FileInputStream("file.txt");
        byte[] data = new byte[1024];
        int bytesRead = inputStream.read(data);
        // Missing close() call
        return bytesRead;
    }
}
