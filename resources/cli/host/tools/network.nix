{ 
  pkgs,
  config,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # network
    nftables
    xray
    #v2ray
    dae
    v2raya

    # inner net
    zerotierone
  ];

  services.zerotierone = {
    enable = true;
  };

  services.dae = {
    #enable = true;
  };

  services.v2raya = {
    enable = true;
  };

  services.zxray = {
    #enable = true;
    # enableIPv6 = false;
    xrayConfigFile = /etc/xray/config.json;
    nftRuleset = ''
      table inet v2raya {
          set whitelist {
              type ipv4_addr
              flags interval
              auto-merge
              elements = {
                  0.0.0.0/32,
                  10.0.0.0/8,
                  100.64.0.0/10,
                  127.0.0.0/8,
                  169.254.0.0/16,
                  172.16.0.0/12,
                  192.0.0.0/24,
                  192.0.2.0/24,
                  192.88.99.0/24,
                  192.168.0.0/16,
                  198.51.100.0/24,
                  203.0.113.0/24,
                  224.0.0.0/4,
                  240.0.0.0/4
              }
          }

          set interface {
              type ipv4_addr
              flags interval
              auto-merge
          }
          chain tp_out {
              meta mark & 0x80 == 0x80 return
              meta l4proto { tcp, udp } fib saddr type local fib daddr type != local jump tp_rule
          }

          chain tp_pre {
              iifname lo mark & 0xc0 != 0x40 return
              meta l4proto { tcp, udp } fib saddr type != local fib daddr type != local jump tp_rule
              meta l4proto { tcp, udp } mark & 0xc0 == 0x40 tproxy ip to 127.0.0.1:52345
          }

          chain output {
              type route hook output priority mangle - 5; policy accept;
              meta nfproto ipv4 jump tp_out
          }

          chain prerouting {
              type filter hook prerouting priority mangle - 5; policy accept;
              meta nfproto ipv4 jump tp_pre
          }

          chain tp_rule {
              meta mark set ct mark
              meta mark & 0xc0 == 0x40 return
              iifname br-* return
              iifname docker* return
              iifname veth* return
              iifname wg* return
              iifname ppp* return

              meta l4proto { tcp, udp } th dport 53 jump tp_mark
              meta mark & 0xc0 == 0x40 return

              ip daddr @interface return
              ip daddr @whitelist return
              jump tp_mark
          }

          chain tp_mark {
              tcp flags & (fin | syn | rst | ack) == syn meta mark set mark | 0x40
              meta l4proto udp ct state new meta mark set mark | 0x40
              ct mark set mark
          }
      }
   '';

  };
}
