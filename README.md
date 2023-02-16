This is a small example for problem described in https://github.com/rabbitmq/osiris/issues/116

Start the cluster using:

```bash
$ ./create-cluster.sh
[+] Running 4/4
 ⠿ Network compose_app_net         Created
 ⠿ Container compose-rabbitmq-0-1  Healthy
 ⠿ Container compose-rabbitmq-1-1  Healthy
 ⠿ Container compose-rabbitmq-2-1  Healthy
Netid                      State                      Recv-Q                       Send-Q                                                    Local Address:Port                                                        Peer Address:Port                         Process
u_str                      ESTAB                      0                            0                                                                     * 9329243                                                                * 9329242
u_str                      ESTAB                      0                            0                                                                     * 9329242                                                                * 9329243
tcp                        ESTAB                      0                            0                                                            172.22.0.3:6058                                                          172.22.0.2:45888
tcp                        ESTAB                      0                            0                                                                 [::1]:55662                                                              [::1]:4369
tcp                        ESTAB                      0                            0                                                  [2001:3200:3200::21]:40402                                               [2001:3200:3200::20]:25672
tcp                        ESTAB                      0                            0                                                                 [::1]:4369                                                               [::1]:55662
tcp                        ESTAB                      0                            0                                                  [2001:3200:3200::21]:25672                                               [2001:3200:3200::22]:55230
```

In the previous log we see that the stream replication connections is done using ipv4 between `172.22.0.3:6058` and `172.22.0.2:45888`.

In our cluster (nomad) configuration, rabbitmq nodes cannot connect to each other using ipv4.
To have the same configuration with docker compose, I run the following iptables command:

```
$ sudo iptables -I DOCKER-USER -p tcp  --match multiport --dports 6000:6500 -j DROP
```
