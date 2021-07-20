#include <stdio.h>

#ifdef _WIN32

    #include <ws2tcpip.h>
    #include <stdint.h>

    #define UDP_TOOLKIT __declspec(dllexport)
#endif

#if defined (__unix__) || defined (__APPLE__)

    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <sys/select.h>
    #include <unistd.h>

    #define UDP_TOOLKIT extern

#endif

typedef struct ipV4Address
{
    uint32_t ipv4;
    uint16_t port;
} Ipv4Address;

UDP_TOOLKIT int udp_toolkit_startup() {
#ifdef _WIN32
    WSADATA wsaData = { 0 };

    if (WSAStartup(MAKEWORD(2, 2), &wsaData)) {
        return -1;
    }

    if (LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 2) {
        WSACleanup();

        return -1;
    }
#endif
}

UDP_TOOLKIT int udp_toolkit_cleanup() {
#ifdef _WIN32
    WSACleanup();
#endif
}

UDP_TOOLKIT void udp_toolkit_print_ip(Ipv4Address* address) {
    printf("address %d port %d \n", address->ipv4, address->port);
}

UDP_TOOLKIT int udp_toolkit_create() {
    int domain   = AF_INET;
    int type     = SOCK_DGRAM;
    int protocol = IPPROTO_UDP;

    return socket(domain, type, protocol);
}

UDP_TOOLKIT int udp_toolkit_receive(int socket, Ipv4Address* address, uint8_t* buffer, int length) {
    struct sockaddr_storage source = { 0 };
    socklen_t addressLength = sizeof(source);


    int bytes = recvfrom(socket, (char*)buffer, length, 0, (struct sockaddr*)&source, &addressLength);

     if (address != NULL) {
         struct sockaddr_in* socketAddress = (struct sockaddr_in*)&source;
         address->ipv4 = socketAddress->sin_addr.s_addr;
         address->port = htons(socketAddress->sin_port);
     }

    return bytes;
}

UDP_TOOLKIT int udp_toolkit_bind(int socket, const Ipv4Address* address) {
    struct sockaddr_in addr = {
        .sin_family = AF_INET,
        .sin_port = htons(address->port),
        .sin_addr.s_addr = address->ipv4,
    };

    return bind(socket, (struct sockaddr *) &addr, sizeof(addr));
}

UDP_TOOLKIT int udp_toolkit_poll(int socket, long timeout) {
    fd_set set = { 0 };
    struct timeval time = { 0 };

    FD_ZERO(&set);
    FD_SET(socket, &set);

    time.tv_sec = timeout / 1000;
    time.tv_usec = (timeout % 1000) * 1000;

    return select(socket + 1, &set, NULL, NULL, &time);
}

UDP_TOOLKIT void udp_toolkit_close(int *socket) {
    if (socket > 0) {
        close(*socket);

        *socket = 0;
    }
}

UDP_TOOLKIT int udp_toolkit_send(int socket, const Ipv4Address* address, const uint8_t* buffer, int length) {
    struct sockaddr_in dest = {
        .sin_family = AF_INET,
        .sin_port = htons(address->port),
        .sin_addr.s_addr = address->ipv4,
    };

    return sendto(socket, (const char*)buffer, length, 0, (address != NULL ? (struct sockaddr*)&dest : NULL), sizeof(dest));
}