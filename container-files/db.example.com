$ORIGIN example.com.
$TTL    3600

@       IN      SOA     nameserver.example.com. hostmaster.example.com. (
                      2023070101         ; Serial
                          604800         ; Refresh
                           86400         ; Retry
                         2419200         ; Expire
                           86400 )       ; Negative Cache TTL
;

@               3600    IN      NS      ns01.example.com.
@               3600    IN      NS      ns02.example.com.

_ntp._udp       3600    IN      SRV     0   100   123   time.example.com.

ns01                  3600    IN      A       10.0.0.132
ns02                  3600    IN      A       10.3.53.10
server01              3600    IN      A       10.129.31.124
server02              3600    IN      A       10.13.235.221
time                  3600    IN      A       10.1.33.234

; -----------------------------------------------------------------------------
; EOF