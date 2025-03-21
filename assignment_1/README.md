# Assignment_1

## Structure of Files
- **teacher.cpp** -> The base code provided by the teacher.
- **adjust.cpp** -> The modified version of the base code with improvements.
- **output_text.html** -> The result of running the modified code.
- **HKA_EIT_Logo_Gesamt.png** -> Another output generated by the modified code.

## Comparison of Changes
### **Original Code:**
```cpp
while((rc=recv(s,recv_buf,bufsz-2,0))>0)
{
    recv_buf[rc]='\0';
    printf("%s",recv_buf);
}

printf("\nDONE!");
closesocket(s);
return 0;
```

### **Modified Code:**
```cpp
// Open file for writing
FILE *file = fopen(site, "wb");
if (!file)
{
    file = fopen("output_text.html","wb");
}

bool headerEnded = false;
while ((rc = recv(s, recv_buf, sizeof(recv_buf), 0)) > 0)
{
    recv_buf[rc] = '\0';
    printf("%s", recv_buf);
    
    if (!headerEnded)
    {
        char *headerEnd = strstr(recv_buf, "\r\n\r\n");
        if (headerEnd)
        {
            headerEnd += 4;
            int headerSize = headerEnd - recv_buf;
            fwrite(headerEnd, 1, rc - headerSize, file);
            headerEnded = true;
        }
    }
    else
    {
        fwrite(recv_buf, 1, rc, file);
    }
}

fclose(file);
closesocket(s);
#ifdef _WIN32
WSACleanup();
#endif
printf("\nDONE!");
printf("\nDownload completed: output\n");
return 0;
```

---

## Explanation of the Changes

### **1. Opening and Writing to an Output File**
#### **Original Code:**
- The original code only printed the received data to the console.
- There was no mechanism to save the data into a file.

#### **Modified Code:**
- The modified code attempts to open a file to store the received data:
  ```cpp
  FILE *file = fopen(site, "wb");
  if (!file)
  {
      file = fopen("output_text.html","wb");
  }
  ```
- If `site` (which likely contains a file name) cannot be opened, it defaults to `output_text.html`.
- This ensures that the received data is saved for further processing.

### **2. Handling HTTP Headers in the Response**
#### **Original Code:**
- The original implementation simply printed the received data without handling the HTTP response headers.

#### **Modified Code:**
- The HTTP response from a server typically contains headers before the actual content (HTML, images, etc.).
- These headers need to be stripped before saving the actual content.
- The following logic detects the end of headers:
  ```cpp
  char *headerEnd = strstr(recv_buf, "\r\n\r\n");
  ```
- The `\r\n\r\n` sequence marks the boundary between headers and content.
- If found, the headers are skipped, and only the actual content is written to the file:
  ```cpp
  headerEnd += 4; // Move past the header delimiter
  int headerSize = headerEnd - recv_buf;
  fwrite(headerEnd, 1, rc - headerSize, file);
  headerEnded = true;
  ```
- After the headers are stripped, the rest of the data is written directly to the file.

### **3. Writing Data to the File in Chunks**
#### **Original Code:**
- The original code printed data directly from `recv()` without distinguishing between headers and content.

#### **Modified Code:**
- The `recv()` function is used inside a loop to handle data in chunks:
  ```cpp
  while ((rc = recv(s, recv_buf, sizeof(recv_buf), 0)) > 0)
  ```
- If headers are still present, they are checked and removed.
- Once headers are processed, all subsequent data is written directly to the file:
  ```cpp
  fwrite(recv_buf, 1, rc, file);
  ```

### **4. Closing the File and Cleaning Up**
#### **Original Code:**
- The original code only closed the socket.

#### **Modified Code:**
- The modified code properly closes the file:
  ```cpp
  fclose(file);
  ```
- On Windows, additional cleanup is done:
  ```cpp
  #ifdef _WIN32
  WSACleanup();
  #endif
  ```
- A confirmation message is printed:
  ```cpp
  printf("\nDownload completed: output\n");
  ```