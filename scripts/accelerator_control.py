
def main():
    import sys
    import os
    import socket

    class OpSyntaxError(Exception):
        pass

    def err(str):
        raise OpSyntaxError(str)

    def to_int(s):
        try:
            return int(s,0)
        except ValueError:
            err("invalid int '"+str+"'")

    def to_hexint(s):
        try:
            return int(s, 16)
        except ValueError:
            err("invalid int '"+str+"'")

    def settokens(port, tokens, xtokens):
        try:
            bfrt.accelerator.pipe.Egress.out_control.add_with_set_tokens(port, tokens, xtokens)
        except BfRtTableError:
            bfrt.accelerator.pipe.Egress.out_control.mod_with_set_tokens(port, tokens, xtokens)

    def opsettokens(port, argv):
        if len(argv) < 2:
            err("too few arguments to 'set <port> tokens'")
        tokens = to_int(argv.pop(0))
        xtokens = to_int(argv.pop(0))
        settokens(port, tokens, xtokens)

    def opsetrate(port, argv):
        if len(argv) < 1:
            err("too few arguments to 'set <port> rate'")
        rate = to_int(argv.pop(0))
        tokens = (rate<<11)//1000000000
        xtokens = ((rate<<16)//1000000000)&0x1f
        settokens(port, tokens, xtokens)

    def opsetincsrc(port, argv):
        if len(argv) < 1:
            err("too few arguments to 'set <port> incsrc'")
        inc = to_int(argv.pop(0))
        try:
            bfrt.accelerator.pipe.Egress.mod_pkt.add_with_inc_src(port, inc)
        except BfRtTableError:
            bfrt.accelerator.pipe.Egress.mod_pkt.mod_with_inc_src(port, inc)

    def opset(argv):
        if len(argv) < 2:
            err("too few arguments to 'set'")
        port = to_int(argv.pop(0))
        control = argv.pop(0)
        if control == "tokens":
            opsettokens(port, argv)
        elif control == "rate":
            opsetrate(port, argv)
        elif control == "incsrc":
            opsetincsrc(port, argv)
        else:
            err("unkown control: '"+control+"'")

    def opdstforward(dst, argv):
        if len(argv) < 1:
            err("too few arguments to 'dst <mac> forward'")
        port = to_int(argv.pop(0))
        try:
            bfrt.accelerator.pipe.Ingress.static_switching.add_with_to_port(dst, port)
        except BfRtTableError:
            bfrt.accelerator.pipe.Ingress.static_switching.mod_with_to_port(dst, port)

    def opdstaccelerate(dst, argv):
        if len(argv) < 1:
            err("too few arguments to 'dst <mac> accelerate'")
        port = to_int(argv.pop(0))
        try:
            bfrt.accelerator.pipe.Ingress.static_switching.add_with_to_mcast(dst, port)
        except BfRtTableError:
            bfrt.accelerator.pipe.Ingress.static_switching.mod_with_to_mcast(dst, port)

    def opdst(argv):
        if len(argv) < 2:
            err("too few arguments to 'dst'")
        dst = to_hexint(argv.pop(0).replace(":", ""))
        mode = argv.pop(0)
        if mode == "forward":
            opdstforward(dst, argv)
        elif mode == "accelerate":
            opdstaccelerate(dst, argv)
        else:
            err("unkown control: '"+control+"'")

    def op(argv):
        op = argv.pop(0)
        if op == "set":
            opset(argv)
        elif op == "dst":
           opdst(argv)
        else:
            err("unknown op: '"+op+"'")

    lsock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    try:
        os.unlink("/run/swappctl.sock")
    except FileNotFoundError: 
        pass
    lsock.bind("/run/swappctl.sock")
    lsock.listen(1)

    while True:
        fd, addr = lsock.accept()
        buf = ""
        while True:
            d = fd.recv(65536)
            if len(d) == 0:
                break
            buf += d.decode("utf-8", 'ignore')
        cmds = str(buf).split("\n")
        for c in cmds:
            try:
                op(c.split(" "))
            except OpSyntaxError as e:
                try:
                    fd.send(bytes(str(e), encoding='utf8'))
                except OSError:
                    pass
                break
        fd.close()

main()
