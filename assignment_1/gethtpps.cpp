//============================================================================
// Name : gethttp.cpp
// Author : Bussysteme
// Version : WiSe 2425
//============================================================================

// Abfrage einer HTTP-URL und Ausgabe der Ergebnisse auf dem Bildschirm.
// Für MS-Compiler: Die Linker-Datei wsock32.lib muss in den Projekteinstellungen
// eingetragen werden!

// update WS09/10: Dieses Beispiel läuft auf Win und Unix.

// update WS24/25: Kleine Anpassungen.

#ifdef _WIN32
#include <windows.h>
#include <winsock.h>
#else // Hier folgen die Ersetzungen für die BSD-socks.
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
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

void perr_exit(char const *msg, int ret_code)
{
    printf("%s, Error: ", msg);
    printf("%d\n", ret_code);
    exit(ret_code);
}

int main(int argc, char **argv)
{
    char *site;
    char *host;
    const int bufsz = 4069;
    char url[1024];
    char send_buf[bufsz];
    char recv_buf[bufsz];
    long rc;
    SOCKET s;
    SOCKADDR_IN addr;
#ifdef _WIN32
    WSADATA wsa;
#endif
    HOSTENT *hent;

// Bevor man anfangen kann, muss man diese WSAStartup Funktion aufrufen.
// Initialisiert TCPIP-Stack.
#ifdef _WIN32
    if (WSAStartup(MAKEWORD(2, 0), &wsa))
        perr_exit("WSAStartup failed", WSAGetLastError());
#endif

    addr.sin_family = AF_INET;
    addr.sin_port = htons(80);

    printf("\nURL: ");
    scanf("%s", url);

    if (strncmp("http://", url, 7) == 0)
        host = url + 7;
    else
        host = url;

    if ((site = strchr(host, '/')) != 0)
        *site++ = '\0';
    else
        site = host + strlen(host); /* \0 */

    printf("Host: %s\n", host);
    printf("Site: %s\n", site);
    printf("Connecting....\n");

    if ((addr.sin_addr.s_addr = inet_addr((const char *)host)) == INADDR_NONE)
    {
        if (!(hent = gethostbyname(host)))
            perr_exit("Cannot resolve Host", WSAGetLastError());

        strncpy((char *)&addr.sin_addr.s_addr, hent->h_addr, 4);

        if (addr.sin_addr.s_addr == INADDR_NONE)
            perr_exit("Cannot resolve Host", WSAGetLastError());
    }

    s = socket(AF_INET, SOCK_STREAM, 0);
#ifdef _WIN32
    if (s == INVALID_SOCKET)
#else
    if (s < 0)
#endif
        perr_exit("Cannot create Socket", WSAGetLastError());

    if (connect(s, (SOCKADDR *)&addr, sizeof(SOCKADDR)))
        perr_exit("Cannot connect", WSAGetLastError());

    printf("Connected to %s...\n", host);

    snprintf(send_buf, sizeof(send_buf),
             "GET %s/HKA_EIT_Logo_Gesamt.png HTTP/1.1\r\n"
             "Host: %s\r\n"
             "Accept: image/png\r\n"
             "Connection: close\r\n\r\n",
             site, host);

    printf("Command sent to server: \n%s\n", send_buf);

    if ((send(s, send_buf, strlen(send_buf), 0)) < strlen(send_buf))
        perr_exit("Cannot send Data", WSAGetLastError());

    printf("----Result----\n");

    // write file for 
    FILE *file = fopen("output.png", "wb");
    if (!file)
    {
        std::cerr << "Failed to open file for writing\n";
        return 1;
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
    std::cout << "Download completed: output.png\n";
    return 0;
}
