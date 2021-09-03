#include <core.p4>
#include <tna.p4>

header ethernet_h {
	bit<48> dst_addr;
	bit<16> src_u;
	bit<32> src_l;
	bit<16> ether_type;
}

struct my_ingress_headers_t {
	ethernet_h   ethernet;
}

struct my_ingress_metadata_t {
}

parser IngressParser(packet_in pkt,
	out my_ingress_headers_t         hdr,
	out my_ingress_metadata_t        meta,
	out ingress_intrinsic_metadata_t ig_intr_md)
{
	state start {
		pkt.extract(ig_intr_md);
		pkt.advance(PORT_METADATA_SIZE);
		transition parse_ethernet;
	}

	state parse_ethernet {
		pkt.extract(hdr.ethernet);
		transition accept;
	}
}


control Ingress(
	inout my_ingress_headers_t                      hdr,
	inout my_ingress_metadata_t                     meta,
	in    ingress_intrinsic_metadata_t              ig_intr_md,
	in    ingress_intrinsic_metadata_from_parser_t  ig_prsr_md,
	inout ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md,
	inout ingress_intrinsic_metadata_for_tm_t       ig_tm_md)
{

	action to_port(PortId_t port) {
		ig_tm_md.ucast_egress_port = port;
	}

	action to_mcast(bit<16> grp_id) {
		ig_tm_md.ucast_egress_port = 9w0x1ff;
		ig_tm_md.rid = 5;
		ig_tm_md.mcast_grp_a = grp_id;
	}

	table static_switching {
		key = {
			hdr.ethernet.dst_addr: exact;
		}
		actions = {
			to_port;
			to_mcast;
			NoAction;
		}
		default_action = NoAction;
		size = 128;
		const entries = {
			0x00154d135dda : to_port(140); // inp1/1
			0x00154d135ddb : to_port(141); // inp1/2
			0x00154d1379f0 : to_port(24);  // inp2/1
			0x00154d1379f1 : to_port(8);   // inp2/2
			0x00154d135f1e : to_port(24);  // inp3/1
			0x00154d135f1f : to_port(8);   // inp3/2
			//0x00154d1382b7 : to_port(136); // inp4/1
			//0x00154d1382b8 : to_port(137); // inp4/2
			0x00154d1382b7 : to_mcast(136);  // inp4/1
			0x00154d1382b8 : to_mcast(137);  // inp4/2
			//0x00154d13129a : to_port(144); // inp5/1
			//0x00154d13129b : to_port(152); // inp2/2
			0x00154d13129a : to_mcast(144);  // inp5/1
			0x00154d13129b : to_mcast(152);  // inp2/2
		}
	}

	apply {
		static_switching.apply();
	}
}


control IngressDeparser(packet_out pkt,
	inout my_ingress_headers_t                      hdr,
	in    my_ingress_metadata_t                     meta,
	in    ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md)
{

	apply {
		pkt.emit(hdr);
	}
}


struct my_egress_headers_t {
	ethernet_h   ethernet;
}

struct my_egress_metadata_t {
	bit<32> ts;
	bit<1>  pause_control;
	bit<32> ts_skip;
	bit<32> ts_last;
	bit<1>  token_control;
	bit<16> ts_tokens;
	bit<8>  ts_xtokens;
	bit<32> ts_epoch;
	bit<32> src_inc;
}


parser EgressParser(packet_in pkt,
	out my_egress_headers_t         hdr,
	out my_egress_metadata_t        meta,
	out egress_intrinsic_metadata_t eg_intr_md)
{
	state start {
		pkt.extract(eg_intr_md);
		transition parse_ethernet;
	}

	state parse_ethernet {
		pkt.extract(hdr.ethernet);
		transition accept;
	}
}


control Egress(
	inout my_egress_headers_t                         hdr,
	inout my_egress_metadata_t                        meta,
	in    egress_intrinsic_metadata_t                 eg_intr_md,
	in    egress_intrinsic_metadata_from_parser_t     eg_prsr_md,
	inout egress_intrinsic_metadata_for_deparser_t    eg_dprsr_md,
	inout egress_intrinsic_metadata_for_output_port_t eg_oport_md)
{

	action no_control() {
		meta.pause_control = 0;
	}

	action set_pause(bit<32> ts_skip) {
		meta.pause_control = 1;
		meta.ts_skip = meta.ts_skip;
		meta.ts_last = ts_skip + eg_prsr_md.global_tstamp[31:0];
	}

	action set_tokens(bit<16> tokens, bit<8> xtokens) {
		meta.token_control = 1;
		meta.ts_tokens = tokens;
		meta.ts_xtokens = xtokens;
		meta.ts_epoch = eg_prsr_md.global_tstamp[31:0] & (((1<<16)-1)-((1<<11)-1));
	}

	table out_control {
		key = {
			eg_intr_md.egress_port: exact;
		}
		actions = {
			set_pause;
			set_tokens;
			no_control;
		}
		default_action = no_control;
		size = 128;

		const entries = {
		#define set_rate(rate) set_tokens(((rate)<<11)/1000000000, (((rate)<<16)/1000000000)&0x1f)
			136 : set_pause(0xffffffff-(1000/40)+1);
			137 : set_pause(0xffffffff-(1000/40)+1);
			//144 : set_pause(0xffffffff-(1000/35)+1);
			//152 : set_pause(0xffffffff-(1000/22)+1);
			//144 : set_tokens(((26710000)<<11)/1000000000, (((26710000)<<16)/1000000000)&0x1f);
			//152 : set_tokens(((26710000)<<11)/1000000000, (((26710000)<<16)/1000000000)&0x1f);
			144 : set_rate(26600000);
			152 : set_rate(26600000);
		}
	}

	action add_xtoken() {
		meta.ts_tokens = meta.ts_tokens + 1;
	}

	table xtoken {
		key = {
			meta.ts_epoch: ternary;
			meta.ts_xtokens: ternary;
		}
		actions        = {
			add_xtoken;
			NoAction;
		}
		default_action = NoAction;
		size           = 31;
		// this table is (a>>11) < b for 5 bit values
		const entries = {
			(0x0000 &&& 0xf800, 0x01 &&& 0x1f) : add_xtoken();
			(0x0000 &&& 0xf000, 0x02 &&& 0x1e) : add_xtoken();
			(0x1000 &&& 0xf800, 0x03 &&& 0x1f) : add_xtoken();
			(0x0000 &&& 0xe000, 0x04 &&& 0x1c) : add_xtoken();
			(0x2000 &&& 0xf800, 0x05 &&& 0x1f) : add_xtoken();
			(0x2000 &&& 0xf000, 0x06 &&& 0x1e) : add_xtoken();
			(0x3000 &&& 0xf800, 0x07 &&& 0x1f) : add_xtoken();
			(0x0000 &&& 0xc000, 0x08 &&& 0x18) : add_xtoken();
			(0x4000 &&& 0xf800, 0x09 &&& 0x1f) : add_xtoken();
			(0x4000 &&& 0xf000, 0x0a &&& 0x1e) : add_xtoken();
			(0x5000 &&& 0xf800, 0x0b &&& 0x1f) : add_xtoken();
			(0x4000 &&& 0xe000, 0x0c &&& 0x1c) : add_xtoken();
			(0x6000 &&& 0xf800, 0x0d &&& 0x1f) : add_xtoken();
			(0x6000 &&& 0xf000, 0x0e &&& 0x1e) : add_xtoken();
			(0x7000 &&& 0xf800, 0x0f &&& 0x1f) : add_xtoken();
			(0x0000 &&& 0x8000, 0x10 &&& 0x10) : add_xtoken();
			(0x8000 &&& 0xf800, 0x11 &&& 0x1f) : add_xtoken();
			(0x8000 &&& 0xf000, 0x12 &&& 0x1e) : add_xtoken();
			(0x9000 &&& 0xf800, 0x13 &&& 0x1f) : add_xtoken();
			(0x8000 &&& 0xe000, 0x14 &&& 0x1c) : add_xtoken();
			(0xa000 &&& 0xf800, 0x15 &&& 0x1f) : add_xtoken();
			(0xa000 &&& 0xf000, 0x16 &&& 0x1e) : add_xtoken();
			(0xb000 &&& 0xf800, 0x17 &&& 0x1f) : add_xtoken();
			(0x8000 &&& 0xc000, 0x18 &&& 0x18) : add_xtoken();
			(0xc000 &&& 0xf800, 0x19 &&& 0x1f) : add_xtoken();
			(0xc000 &&& 0xf000, 0x1a &&& 0x1e) : add_xtoken();
			(0xd000 &&& 0xf800, 0x1b &&& 0x1f) : add_xtoken();
			(0xc000 &&& 0xe000, 0x1c &&& 0x1c) : add_xtoken();
			(0xe000 &&& 0xf800, 0x1d &&& 0x1f) : add_xtoken();
			(0xe000 &&& 0xf000, 0x1e &&& 0x1e) : add_xtoken();
			(0xf000 &&& 0xf800, 0x1f &&& 0x1f) : add_xtoken();
		}
	}

	Register<bit<32>, bit<9>>(512,0) last_unpaused_ts;

	RegisterAction<bit<32>, bit<9>, bit<32>>(last_unpaused_ts) check_ts = {
		void apply(inout bit<32> ts, out bit<32> rv) {
			if (meta.ts_last > ts) {
				ts = meta.ts[31:0];
			}
			rv = ts;
		}
	};
	RegisterAction<bit<32>, bit<9>, bit<32>>(last_unpaused_ts) check_ts_overflow = {
		void apply(inout bit<32> ts, out bit<32> rv) {
			if (meta.ts_last > ts || ts >= 1<<31) {
				ts = meta.ts[31:0];
			}
			rv = ts;
		}
	};

	Register<bit<32>, bit<9>>(512,0) token_epoch;
	Register<bit<16>, bit<9>>(512,0) token_counter;

	RegisterAction<bit<32>, bit<9>, bit<1>>(token_epoch) check_epoch = {
		void apply(inout bit<32> epoch, out bit<1> rv) {
			rv = 0;
			if (meta.ts_epoch != epoch) {
				rv = 1;
				epoch = meta.ts_epoch;
			}
		}
	};

	RegisterAction<bit<16>, bit<9>, bit<16>>(token_counter) new_tokens = {
		void apply(inout bit<16> tk, out bit<16> rv) {
			tk = meta.ts_tokens;
			rv = tk;
		}
	};

	RegisterAction<bit<16>, bit<9>, bit<16>>(token_counter) dec_tokens = {
		void apply(inout bit<16> tk, out bit<16> rv) {
			if (tk != 0) {
				tk = tk - 1;
			}
			rv = tk;
		}
	};

	action inc_src(bit<32> inc) {
		meta.src_inc = inc;
	}

	table mod_pkt {
		key = {
			eg_intr_md.egress_port: exact;
		}
		actions = {
			inc_src;
			NoAction;
		}
		default_action = NoAction;
		size = 128;
	}

	Register<bit<32>, bit<9>>(512,0) cur_src_inc;
	RegisterAction<bit<32>, bit<9>, bit<32>>(cur_src_inc) add_src_inc = {
		void apply(inout bit<32> inc, out bit<32> rv) {
			inc = inc + meta.src_inc;
			rv = inc;
		}
	};

	apply {
		meta.ts = eg_prsr_md.global_tstamp[31:0];
		bit<32> ts_pass = meta.ts;
		meta.pause_control = 0;
		meta.token_control = 0;
		out_control.apply();
		eg_dprsr_md.drop_ctl = 0;
		if (meta.pause_control == 1) {
			if (meta.ts_last & 0x80000000 != 0) {
				ts_pass = check_ts.execute(eg_intr_md.egress_port);
			} else {
				ts_pass = check_ts_overflow.execute(eg_intr_md.egress_port);
			}
			if (ts_pass != meta.ts) {
				eg_dprsr_md.drop_ctl = 1;
			}
		} else if (meta.token_control == 1) {
			xtoken.apply();
			bit<1> new_epoch = 0;
			new_epoch = check_epoch.execute(eg_intr_md.egress_port);
			bit<16> tokens = 1;
			if (new_epoch == 1) {
				tokens = new_tokens.execute(eg_intr_md.egress_port);
			} else {
				tokens = dec_tokens.execute(eg_intr_md.egress_port);
			}
			if (tokens == 0) {
				eg_dprsr_md.drop_ctl = 1;
			}
		}

		meta.src_inc = 0;
		mod_pkt.apply();
		bit<32> inc = add_src_inc.execute(eg_intr_md.egress_port);
		hdr.ethernet.src_l = hdr.ethernet.src_l+inc;
	}
}


control EgressDeparser(packet_out pkt,
	inout my_egress_headers_t                      hdr,
	in    my_egress_metadata_t                     meta,
	in    egress_intrinsic_metadata_for_deparser_t eg_dprsr_md)
{
	apply {
		pkt.emit(hdr);
	}
}


Pipeline(
	IngressParser(),
	Ingress(),
	IngressDeparser(),
	EgressParser(),
	Egress(),
	EgressDeparser()
) pipe;

Switch(pipe) main;
