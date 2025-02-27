#ifdef _WIN32
#include <windows.h>
#include <winsock2.h>  // Use winsock2.h instead of winsock.h
#pragma comment(lib, "ws2_32.lib") // Link Windows socket library
#else
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h> // For close()
#define SOCKET int
#define INVALID_SOCKET (-1)
#define closesocket(s) close(s)  // Linux/macOS uses close()
#endif
#include<iostream>
#include<cstring>
void perr_exit(const char *msg, int err) {
    std::cerr << msg << " (Error code: " << err << ")\n";
    exit(EXIT_FAILURE);
}

int main() {
    const int bufsz = 4096;
    char url[1024], send_buf[bufsz], recv_buf[bufsz];
    char *site, *host;
    SOCKET s;
    struct sockaddr_in addr;
    struct hostent *hent;
    long rc;

#ifdef _WIN32
    WSADATA wsa;
    if (WSAStartup(MAKEWORD(2, 0), &wsa)) {
        perr_exit("WSAStartup failed", WSAGetLastError());
    }
#endif

    std::cout << "Enter PNG URL: ";
    std::cin >> url;

    if (strncmp(url, "http://", 7) == 0)
        host = url + 7;
    else
        host = url;

    if ((site = strchr(host, '/')) != nullptr)
        *site++ = '\0';
    else
        site = (char*)"/";

    std::cout << "Host: " << host << "\n";
    std::cout << "Site: " << site << "\n";
    std::cout << "Connecting...\n";

    if ((hent = gethostbyname(host)) == nullptr) {
        perr_exit("Failed to resolve hostname", 1);
    }

    addr.sin_family = AF_INET;
    addr.sin_port = htons(80);
    memcpy(&addr.sin_addr, hent->h_addr, hent->h_length);

    if ((s = socket(AF_INET, SOCK_STREAM, 0)) == INVALID_SOCKET) {
        perr_exit("Socket creation failed", 1);
    }

    if (connect(s, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        perr_exit("Connection failed", 1);
    }

    snprintf(send_buf, sizeof(send_buf),
             "GET /%s/HKA_EIT_Logo_Gesamt.png HTTP/1.1\r\n"
             "Host: %s\r\n"
             "Accept: image/png\r\n"
             "Connection: close\r\n\r\n",
             site, host);

    send(s, send_buf, strlen(send_buf), 0);
    printf("----Result----\n");



    FILE *file = fopen("output.png", "wb");
    if (!file) {
        std::cerr << "Failed to open file for writing\n";
        return 1;
    }

    bool headerEnded = false;
    int bytes_received;
    while ((bytes_received = recv(s, recv_buf, sizeof(recv_buf), 0)) > 0) {
        if (!headerEnded) {
            char *headerEnd = strstr(recv_buf, "\r\n\r\n");
            if (headerEnd) {
                headerEnd += 4;
                int headerSize = headerEnd - recv_buf;
                fwrite(headerEnd, 1, bytes_received - headerSize, file);
                headerEnded = true;
            }
        } else {
            fwrite(recv_buf, 1, bytes_received, file);
        }
    }


#ifdef _WIN32
    WSACleanup();
#endif

    std::cout <<"\nDownload completed: output.png\n";
    return 0;
}