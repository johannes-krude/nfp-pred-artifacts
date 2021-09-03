def setup_port(nr, speed, fec=0):
    print("enabling port {}".format(nr))
    pal.port_add(nr, speed, None)
    pal.port_enable(nr)

def setup_port_noautoneg(nr, speed, fec=0):
    print("enabling port without auto-negotiation {}".format(nr))
    pal.port_add(nr, speed, None)
    pal.port_an_set(nr, 2)
    pal.port_enable(nr)

def setup_multicast(group, ports):
    mcg = mc.mgrp_create(group)
    node = mc.node_create(5, devports_to_mcbitmap(ports), lags_to_mcbitmap([]))
    mc.associate_node(mcg, node, xid=0, xid_valid=False)

# inp1
setup_port(140, pal.port_speed_t.BF_SPEED_25G)
setup_port(141, pal.port_speed_t.BF_SPEED_25G)

# buffalo2
setup_port(24, pal.port_speed_t.BF_SPEED_100G)
setup_port(8, pal.port_speed_t.BF_SPEED_100G)

# inp5
setup_port_noautoneg(144, pal.port_speed_t.BF_SPEED_40G)
setup_port_noautoneg(152, pal.port_speed_t.BF_SPEED_40G)

# inp4
setup_port(136, pal.port_speed_t.BF_SPEED_25G)
setup_port(137, pal.port_speed_t.BF_SPEED_25G)

# CPU ports
setup_port(64, pal.port_speed_t.BF_SPEED_10G)
setup_port(66, pal.port_speed_t.BF_SPEED_10G)

# multicast
for i in [132,164,180,56,40,24,8,4,20,36,52,184,168,144,128,64]:
    setup_multicast(i+0, [i+0, 68])
    setup_multicast(i+1, [i+1,196])
    setup_multicast(i+2, [i+2, 68])
    setup_multicast(i+3, [i+3,196])
for i in [140,156,172,188,48,32,16,0,12,28,44,60,176,160,152,136]:
    setup_multicast(i+0, [i+0,196])
    setup_multicast(i+1, [i+1, 68])
    setup_multicast(i+2, [i+2,196])
    setup_multicast(i+3, [i+3, 68])
