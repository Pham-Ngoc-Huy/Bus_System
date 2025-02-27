//============================================================================
// Name        : gethttp.cpp
// Author      : Bussysteme
// Version     : WiSe 2425
//============================================================================

#ifdef _WIN32
#include <windows.h>
#include <winsock.h>
#else
#include <stddef.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/un.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#define SOCKADDR_IN struct sockaddr_in
#define SOCKADDR struct sockaddr
#define HOSTENT struct hostent
#define SOCKET int
int WSAGetLastError() { return errno; }
int closesocket(int s) { return close(s); }
#endif

#include <iostream>
#include <fstream>
#include <cstring>

void perr_exit(const char *msg, int ret_code) {
    printf("%s, Error: %d\n", msg, ret_code);
    exit(ret_code);
}

int main() {
    char *site, *host;
    const int bufsz = 4096;
    char url[1024], send_buf[bufsz], recv_buf[bufsz];
    long rc;
    SOCKET s;
    SOCKADDR_IN addr;
#ifdef _WIN32
    WSADATA wsa;
#endif
    HOSTENT *hent;

#ifdef _WIN32
    if (WSAStartup(MAKEWORD(2, 0), &wsa))
        perr_exit("WSAStartup failed", WSAGetLastError());
#endif

    addr.sin_family = AF_INET;
    addr.sin_port = htons(80);

    // User input
    printf("\nEnter HTTP URL: ");
    scanf("%s", url);

    // Extract host and file path
    if (strncmp("http://", url, 7) == 0)
        host = url + 7;
    else
        host = url;

    if ((site = strchr(host, '/')) != nullptr)
        *site++ = '\0';
    else
        site = (char *)"/";

    printf("Host: %s\n", host);
    printf("File Path: /%s\n", site);

    // Resolve host IP
    if ((addr.sin_addr.s_addr = inet_addr(host)) == INADDR_NONE) {
        if (!(hent = gethostbyname(host)))
            perr_exit("Cannot resolve Host", WSAGetLastError());
        memcpy(&addr.sin_addr.s_addr, hent->h_addr, 4);
    }

    // Create socket
    s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0) perr_exit("Cannot create Socket", WSAGetLastError());

    // Connect to server
    if (connect(s, (SOCKADDR *)&addr, sizeof(SOCKADDR)))
        perr_exit("Cannot connect", WSAGetLastError());

    printf("Connected to %s...\n", host);

    // Send HTTP GET request
    snprintf(send_buf, sizeof(send_buf), "GET /%s HTTP/1.1\r\nHost: %s\r\nConnection: close\r\n\r\n", site, host);
    printf("Request:\n%s\n", send_buf);

    if (send(s, send_buf, strlen(send_buf), 0) < 0)
        perr_exit("Cannot send data", WSAGetLastError());

    // Open file for writing
    std::ofstream file(site, std::ios::binary);
    if (!file.is_open()) {
        perror("Error opening file for writing");
        closesocket(s);
        return 1;
    }

    // Receive response & save file
    printf("Downloading file...\n");

    bool header_passed = false;
    std::string header;
    while ((rc = recv(s, recv_buf, sizeof(recv_buf) - 1, 0)) > 0) {
        recv_buf[rc] = '\0';

        if (!header_passed) {
            header.append(recv_buf, rc);
            size_t pos = header.find("\r\n\r\n");
            if (pos != std::string::npos) {
                header_passed = true;
                file.write(header.data() + pos + 4, rc - (pos + 4));
            }
        } else {
            file.write(recv_buf, rc);
        }
    }

    file.close();
    closesocket(s);

    printf("\nDownload complete! File saved as: %s\n", site);
    return 0;
}
