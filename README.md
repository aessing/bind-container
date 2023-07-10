# Bind Name Server Container

[BIND](https://bind.isc.org/) BIND is an open source DNS software system including an authoritative server or a recursive resolver.

As the ISC only published a container with BIND9 DNS server for AMD64, this repository builds a Docker container for other architectures / platforms, based on [Alpine Linux](https://www.alpinelinux.org).

### :hammer_and_wrench: Configuration

You can mount the following volumes:

| Volume          | Description                                               |
| --------------- | --------------------------------------------------------- |
| /etc/bind       | For the server configuration (your named.conf lives here) |
| /var/cache/bind | This is the working directory                             |
| /var/lib/bind   | This is the place where the secondary zones are placed    |

You can expose the following ports:

| Port    | Description                                                                                                                                                                                                                                                                          |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 53/udp  | The most popular port and protocol of DNS is UDP 53                                                                                                                                                                                                                                  |
| 53/tcp  | Is used as fallback. Bind9 uses TCP when it is unable to communicate on UDP, typically when the packet size is too large to push through in a single UDP packet.                                                                                                                     |
| 443/tcp | If you want to use DNS over HTTPS (DoH), you can expose this port. To get this running, you have to configure it in your named.conf and provide the certificates.                                                                                                                    |
| 80/tcp  | You can also use DNS over HTTPS (DoH) without certificates over port 80. To get this running, you have to configure it in your named.conf. Please note, that the traffic is not encrypted. This is only for testing purposes, or when you offload the encryption to a reverse proxy. |
| 853/tcp | If you want to use DNS over TLS (DoT), you can expose this port. To get this running, you have to configure it in your named.conf and provide the certificates.                                                                                                                      |

## :eyeglasses: Documentation

For further information, how to configure Bind9, please visit the [Bind9 documentation](https://bind9.readthedocs.io/en/latest/).

## :rocket: Deployment

I added a Kubernetes deployment file to deploy the container to a Kubernetes cluster. You can find the file in the `kubernetes` folder.
The deployment.yaml file is just an example and uses Traefik as a reverse proxy. You can and probably have to change the deployment file to your needs.

---

## :ambulance: Support Information

For further information about this project, how to [contribute](docs/CONTRIBUTING.md), or how to get in touch, please have a look at the [support document](docs/SUPPORT.md) of this repository. The repository also contains information about [security related topics](docs/SECURITY.md), [licensing](LICENSE), and more.

## :man_judge: Disclaimer

THE CONTENT OF THIS REPOSITORY IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE CONTENT OF THIS REPOSITORY OR THE USE OR OTHER DEALINGS IN THE REPOSITORY.
