# Artifacts from the CoNEXT '21 Paper (conditionally accepted) "Determination of Throughput Guarantees for Processor-based SmartNICs"

This repository can be used to **repeat** the evaluation from the paper and can be **reused** to [analyze new XDP/BPF programs](#creating-and-analyzing-new-programs) for there worst-case throughput capacity.

Repeating the full evaluation takes several days and requires special hardware (Netronome SmartNIC, Barefoot Tofino Switch).
The evaluation is therefore structured into individual steps to enable repeating only parts of the evaluation when not having all required hardware or having only limited time.
Any step can be ommitted, since this repository contains all intermediate data.

The implementation of the main approach from the paper is described in the [Tools & Data Formats Overview](#the-nfp-estimator).

This document starts with the [minimal evaluation setup](#getting-started), presents a [small evaluation example](#small-evaluation-example), individually describes all the evaluations steps, details how to [create and analyze new programs](#creating-and-analyzing-new-programs), presents the [full evaluation setup](#full-evaluation-setup) and closes with a description of the individual [tools and data formats](#overview-tools-data-formats).

### Without Hardware

Without a Netronome SmartNIC, one can still repeat some of the evaluation steps, since all intermediate data is included in this repository (`data-paper/`).

When having only very limited time, the [small evaluation example](#small-evaluation-example) shows how to determine throughput gurantees for a small example program.

With enough time, but without a Netronome SmartNIC, the following is possible.

- Instead of Step 1: precompiled example programs are provided in `data-paper/programs/` (bpf bytecode and nfp assembly).
- [Step 2](#1-compiling-bpf-example-programs-to-nfp-assembly): predicting the throughput does not require access to a SmartNIC
- Instead of Step 3: throughput measurements are provided in `data-paper/measured-throughput/`
- Instead of Step 4: throughput measurements are provided in `data-paper/measurements-section4`
- [Step 5](#5-analyzing-the-measured-data): processing the raw measurement data can be done with a mix of new and existing data


## Getting Started

All evaluation steps require at least a single computer running the [docker image](#docker-image) or [Ubuntu 20.04](#installing-ubuntu-2004-with-dependencies).
Some steps need up to three computers, a Netronome Agilio LX 2x40 GbE NIC, and a Barefoot Tofino based Edgecore Wedge 100BF-32X switch.

### Docker Image

- Execution time: ~25 minutes
- Disk space: ~5 GiB

Those evaluation steps which require no special hardware can be executed within the following Docker environment.

Build the docker image with:

    sudo docker build -t nfp-pred-artifacts:latest - < Dockerfile

Start an interactive shell in the Docker image with:

    sudo docker run -it --rm -u $(id -u):$(id -g) -v $(pwd):/nfp-pred-artifacts -w /nfp-pred-artifacts nfp-pred-artifacts:latest

The tools in the repository still need compiling by executing within the Docker image:

    make

This docker image can now be used for the [small evaluation example](#small-evaluation-example) as well as evaluations steps [2](#2-predicting-the-throughput-of-the-example-programs) and [5](#5-analyzing-the-measured-data).


### Installing Ubuntu 20.04 with Dependencies

- Execution time: at least 25 minutes

All evaluation steps which use the Netronome SmartNIC can not be executed with Docker or any other virtualization environment.
Instead, bare metal Ubuntu 20.04 is needed.

Since the modified nfp kernel driver does not work with newer kernels, do not install an Ubuntu HWE kernel, but use the original Ubuntu 5.4.x kernel from Ubuntu 20.04.

Please install the following packets on all computers.

    apt-get install --no-install-recommends git build-essential cmake libjudy-dev libpcap-dev ruby libtrollop-ruby binutils-dev libiberty-dev libelf-dev pbzip2 texinfo openssh-client bison flex libssl-dev z3 wget clang llvm libprotobuf-dev protobuf-compiler libtool libgc-dev libfl-dev libgmp-dev libboost-dev libboost-iostreams-dev libboost-graph-dev pkg-config python3 python3-scapy python3-ipaddr python3-ply python3-pip tcpdump sudo linux-headers-generic python2 gawk graphviz gnuplot texlive-full

This repository needs to be cloned into the users home directory on each computer and the tools need to be compiled with the following command.

    make

### Setup with Netronome SmartNIC and Tofino Switch

Some of the evaluation steps require a Netronome SmartNIC and Tofino switch.
There setup is described in the [full evaluation setup](#full-evaluation-setup).

## Small Evaluation Example

- Required hardware: 1 computer with the [docker image](#docker-image) or [manually installed dependencies](#installing-ubuntu-2004-with-dependencies)
- Execution time: ~30 seconds
- Input: data-paper/programs/xdp-quic-lb.asm
- Output: paper-small-eval-example.pdf
- Output: data-small-eval-example/predictions/xdp-quic-lb.k*.ereport

This minimal example executes the main approach from the paper to analyze the throughput bounds of the QUIC LB (IPv4) example program.

    ./0-small-eval-example.sh

After running this command, the results can be seen in the generated paper (`paper-eval-small-example.pdf`) in Table 1 and Table 2.
The analysis time in Table 2 row number 3 (QUIC LB (IPv4)) should show a different value compared to the original paper (`paper.pdf`).
The calculated naïve bound and slowest estimated sat. path in Table 1 should remain unchanged.
Additionally, the output of the 20 individual prediction runs can be found in  data-small-eval-example/predictions/.


## Repeating the Evaluation Steps

The evaluation is structured into individual steps to enable repeatibility when having limited hardware access or limited time.
Without a Netronome SmartNIC, one can still execute steps [2](#2-predicting-the-throughput-of-the-example-programs) and [5](#5-analyzing-the-measured-data) which include running the main approach from the paper.
Since all intermediate data is included in this repository (`data-paper/`), any step can be independently executed.

### 1. Compiling BPF Example Programs to NFP Assembly

When omitting this step, precompiled output resides in `data-paper/programs/`.

- Required Hardware: [1 computer](#installing-ubuntu-2004-with-dependencies) with Netronome Agilio CX (eth1), [modified nfp driver](#loading-the-nfp-kernel-driver), [modified nic-firmware](#compiling-the-nic-firmware), sudo without password
- Executen time: ~11 minutes
- Input: examples/*.c examples/*.p4 examples/*.sh
- Output: data-repeated/programs/*.asm
- Output: data-repeated/programs/*.bpf.o

This step compiles the example programs to bpf bytecode and Netronome nfp assembly.

    ./1-compile-examples.sh

### 2. Predicting the Throughput of the Example Programs

When omitting this step, the predictions used in the paper reside in `data-paper/predictions/`.

- Required Hardware: 1 computer (preferably Core i7-7700 with 16 GiB RAM) with the [docker image](#docker-image) or [manually installed dependencies](#installing-ubuntu-2004-with-dependencies)
- Execution Time: ~8 days
- Input: data-{paper,repeated}/programs/*.asm
- Output: data-repeated/predictions/*.ereport

This step performs the main approach from the paper.
It takes as input the nfp assembly of a bpf program and enumerates paths through this program ordered from lowest overestimated throughput to highest overestimated throughput.

    ./2-predict-throughput.sh data-paper/programs  # !! runs for ~8 days

To use your own compiled nfp assembly, run:

    ./2-predict-throughput.sh data-repeated/programs  # !! runs for ~8 days

This script executes different variants of the main approach on all example programs and repeats each configuration over 20 runs resulting in a total of 5420 runs.
The resulting .ereport files should always list the same program paths over multiple runs.However, the analsyis time will slightly differ between multiple runs, and will probably differ even more from the results in the paper unless you are using a Core i7-7700 with 16 GiB RAM.

Instead, one can analyze a single program for its slowest program path by executing:

    ./build/nfp-estimator -k -S -c 1 -f <asm-file>

The output in the `.ereport` files from this step is explained in the [tool description](#the-ereport-format).


### 3. Measuring the Throughput of the Example Programs

When omitting this step, the throughput measurements used in the paper reside in `data-paper/measured-throughput/`.

- Required Hardware: The Full [throughput measurement setup](#throughput-measurement-setup)
- Execution Time: ~36 hours
- Input: data-{paper,repeated}/predictions/*.ereport
- Input: data-{paper,repeated}/programs/*.bpf.o
- Output: data-repeated/measured-throughput/*.dat.tar
- Output: data-repeated/measured-throughput/*.log.bz2

This step measures the actually achievable throughput capacity of the program paths from the ereports.

For this step, passwordless ssh and sudo to and on host-rx, the switch, and host-tx is needed as described in the [throughput measurement setup](#throughput-measurement-setup).
When executing one of the following commands, please substitute the hostnames and users with the appropriate values from your setup.

    ./3-measure-throughput.sh data-paper/programs data-paper/predictions user@host-rx:nfp-pred-artifacts user@switch:nfp-pred-artifacts user@host-tx:nfp-pred-artifacts

You can instead use your own compiled programs or ereports by substituting one or both directories as shown below.

    ./3-measure-throughput.sh data-repeated/programs data-repeated/predictions user@host-rx:nfp-pred-artifacts user@switch:nfp-pred-artifacts user@host-tx:nfp-pred-artifacts

This step may cause kernel crashes on host-rx when switching between NIC firmwares.
To continue the measurement after a reboot, please comment out the successful commands in `./scripts/estimate-asm.sh` and remember to reload the modified [NFP kernel driver](#loading-the-nfp-kernel-driver).


### 4. Throughput Measurements for Section 4

When omitting this step, the measurements used in the paper reside in `data-paper/measurements-section4/`.

- Required Hardware: The Full [throughput measurement setup](#throughput-measurement-setup)
- Execution time: ~13 hours
- Input: examples/xdp-drop.c
- Input: examples/xdp-slow.c
- Input: examples/xdp-lookup4.c
- Input: examples/xdp-lookup8.c
- Input: examples/xdp-lookup12.c
- Output: data-repeated/measurements-section4/*.dat.tar
- Output: data-repeated/measurements-section4/*.log.bz2

    ./4-measurements-section4.sh user@host-rx:nfp-pred-artifacts user@switch:nfp-pred-artifacts user@host-tx:nfp-pred-artifacts

As these measurements frequently load different firmware variants, this will cause kernel crashes and hangs.
To continue the measurement after a reboot, please comment out the successful commands.


### 5. Analyzing the Measured Data

- Required hardware: 1 computer with the [docker image](#docker-image) or [manually installed dependencies](#installing-ubuntu-2004-with-dependencies)
- Execution time: ~30 minutes
- Input: data-{paper,repeated}/predictions/*.ereport
- Input: data-{paper,repeated}/measured-throughput/*.dat.tar
- Input: data-{paper,repeated}/measurements-section4/*.dat.tar
- Output: paper-repeated.pdf
- Output: paper/plot/*.{dat,tex,lines}

This step takes the raw measurement data and computes the numbers and plots presented in the paper.

    ./5-analyze-data.sh <data-from-step-2> <data-from-step-3> <data-from-step-4>

To run this step with the existing data used in the paper:

    ./5-analyze-data.sh data-paper/predictions data-paper/measured-throughput data-paper/measurements-section4

To run this step with your data which was generated by you in the previous steps:

    ./5-analyze-data.sh data-repeated/predictions data-repeated/measured-throughput data-repeated/measurements-section4

When repeating this step with identical input data, the results in `paper/plot/*.{dat,tex,lines}` should be unchanged and the numbers and figures in the paper (`paper-repeated.pdf`) should match the numbers in the original paper (`paper.pdf`).


## Creating and Analyzing new Programs

This section describes how to create a new program, predict and measure its throughput, and finally analyze the resulting measurements.
Throughput this section, the new program is named `xdp-my-prog`, please substitute this in all commands for your actual program name.

### Creating & Compiling a new XDP Program

Create and edit the C source-code of your new program as `examples/xdp-my-prog.c`.
A guide on writing BPF XDP programs is available e.g. at [https://docs.cilium.io/en/stable/bpf/](https://docs.cilium.io/en/stable/bpf/), but be aware that XDP, nfp, and our modified NIC firmware support only a subset of the BPF functionality.
To start the creation of a new program, the following template can be used:

    #include <linux/bpf.h>
    
    int act_main(struct xdp_md *ctx) {
    	return XDP_DROP;
    }

Our modified NIC firmware supports at most one BPF_MAP_TYPE_ARRAY map and no maps of any other type.
The key size must be 4 bytes and the total size (value_size * max_entries) can not exceed 1 GiB.
Such a map can be defined with:

    #include <stdint.h>
    #include "bpf_helpers.h"
    
    struct my_value_struct {
    };
    
    struct bpf_map_def SEC("maps") table = {
    	.type = BPF_MAP_TYPE_ARRAY,
    	.key_size = sizeof(uint32_t),
    	.value_size = sizeof(struct my_value_struct),
    	.max_entries = MY_NUMBER_OF_ENTRIES,
    };

The program can then be compiled into an ELF file.

    make out/xdp-my-prog.bpf.o

Once the program is compiled in can be tested without a SmartNIC by attaching it to the loopback interface.

    sudo ./build/bpf -cXeG -f out/xdp-my-prog.bpf.o lo

To offload the program to the SmartNIC use the following command.

    sudo ./build/bpf -cXoe -f out/xdp-my-prog.bpf.o eth1

To resume normal operation of the NIC remove the program.

    sudo ./build/bpf -c eth1
    sudo ./build/bpf -c lo

Predicting the throughput of the program needs the program compiled to nfp assembly.

    sudo ./build/bpf -cXoep -f out/xdp-my-prog.bpf.o eth1 > xdp-my-prog.asm

### Predicting the Throughput of a Program

To identify the program path with the worst bit rate.

    ./build/nfp-estimator -k -c 1 -f xdp-my-prog.asm

To instead identify the program path with worst packet rate.

    ./build/nfp-estimator -i -c 1 -f xdp-my-prog.asm

The output of the `nfp-estimator`s is in the [ereport](#the-ereport-format) format.

The `nfp-estimator` will enumerate all program paths, unless either `-c <count>` specifies a number of to be iterated paths, or `-T <seconds> specifies a timeout.

Loop bounds are not analyzed by the `nfp-estimator` itsef, and therefore need to be specified with `-U <unroll_limit>`.

We provide different NIC firmware variants, which execute the program on varying number of processing cores. For correct ordering of paths, the number of used cores needs to be specified with `-w <cores>`.

For the paper we repeated the prediction over 20 runs to gain statistical significant values for the execution time.
To ease the measurement of actual throughput, we reduced the number of processing cores to `-w 5` for programs which do not access the shared DRAM through the BPF map.
This value can not be reduced for programs accessing the BPF map and has to remain at `-w 50`, since this would lead to a different ordering of paths.

The following commands execute 20 runs of predictions with the settings needed to continue analyzing the data in the next steps.
Please substitute `<count>` for the appropriate value and append `-U <unroll limit>` if needed.

    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-1.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-2.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-3.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-4.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-5.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-6.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-7.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-8.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-9.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-10.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-11.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-12.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-13.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-14.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-15.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-16.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-17.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-18.ereport
    ./build/nfp-estimator -k -w <count> -S -T 3600 -f xdp-my-prog.asm -o xdp-my-prog.k-19.ereport

### Measuring the Throughput of a Program on 5 Cores

Please skip this step in case your program accesses the shared DRAM through a BPF map.

The NIC usually executes BPF/XDP programs on 50 processing cores.
However, a program path with perfect throughput can not be measured on 50 cores, since the processing cores are no longer the bottleneck.
Measuring the throughput is easier when executing the program only on 5 cores, since 5 cores will always be the bottleneck when compared to the MAC part of the NIC.
The throughput of processing-bottlenecked programs scales linearly with the number of cores.
A measurement taken with 5 cores can therefore simply multiplied by 10 to get the throughput of 50 cores.
This is however only feasible for programs which do not use the BPF map, since the DRAM is shared among all processing cores.
Programs which do use the BPF map need to be measured on 50 cores as described in [Measuring the Throughput of a Program on 50 Cores](#measuring-the-throughput-of-a-program-on-50-cores)


To measure the actually achievable throughput of a program, several things are nedded: The program compiled to an ELF object, an ereport which includes all to be measured paths, and the [throughput measurement setup](#throughput-measurement-setup).

Before measuring, the modified [NFP Kernel driver](#loading-the-nfp-kernel-driver) and the correct variant of the modified NIC firmware is needed.

To measure processor-bottlenecked programs on 1 core per island with a total of 5 cores, load the firmware as follows.
Please replace `user@host-rx` with the correct username and host.

    ./tasks/load-nfp-firmware.rb -c user@host-rx:nfp-pred-artifacts wpi1

To then measure the throughput of all paths from the ereport execute the following task.
Please replace `user@host-rx` with the correct username and host.
Both MAC address values need to match the interfaces of the Netronome SmartNIC on host-rx, either change the MAC addresses of your NIC or replace these values with the correct MAC addresses.

    ./tasks/measure-xdp-ereport.rb -c user@host-rx:nfp-pred-artifacts -c user@switch:nfp-pred-artifacts -c user@host-tx:nfp-pred-artifacts -l . xdp-my-prog.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b

This task tries to measure the achievable throughput for each example packet from the ereport.
However, some example packets are not suitable for measuring, since they cannot be forwarded by a Tofino switch.
The task therefore checks whether packets arrive and whether these are identical to the expected packets.
Therefore, some paths may be skipped during measurement.

The task produces two output files: a log file and a `.dat.tar` file which contains the raw measured throughput values.
This `.dat.tar` will be used to compare measured to predicted throughput in the final step and its format is explained in [Tools & Scripts Overview](#the-dattar-format).

### Measuring the Throughput of a Program on 50 Cores

Please use the previous step instead in case your program does not access the shared DRAM through a BPF map.

Some program paths can achieve a throughput which is limited by the MAC part of the NIC.
When measuring these paths, we actually measure only the capabilities of the NICs MAC part.
This step therefore measures only the slow paths of a program and skips all fast paths.

To measure the actually achievable throughput of a program, several things are nedded: The program compiled to an ELF object, an ereport which includes all to be measured paths, and the [throughput measurement setup](#throughput-measurement-setup).

Before measuring, the modified [NFP Kernel driver](#loading-the-nfp-kernel-driver) and the correct variant of the modified NIC firmware is needed.

To measure processor-bottlenecked programs on 10 core per island with a total of 50 cores, load the firmware as follows.
Please replace `user@host-rx` with the correct username and host.

    ./tasks/load-nfp-firmware.rb -c user@host-rx:nfp-pred-artifacts wpi10

To then measure the throughput of all paths from the ereport execute the following task.
Please replace `user@host-rx` with the correct username and host.
Both MAC address values need to match the interfaces of the Netronome SmartNIC on host-rx, either change the MAC addresses of your NIC or replace these values with the correct MAC addresses.

    ./tasks/measure-xdp-ereport-slow.rb -c user@host-rx:nfp-pred-artifacts -c user@switch:nfp-pred-artifacts -c user@host-tx:nfp-pred-artifacts -l . 1333 xdp-my-prog.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b

This task tries to measure the achievable throughput for those example packets from the ereport which belong to a slow path.
However, some example packets are not suitable for measuring, since they cannot be forwarded by a Tofino switch.
The task therefore checks whether packets arrive and whether these are identical to the expected packets.
Therefore, not only fast paths but some additional paths may be skipped during measurement.

The task produces two output files: a log file and a `.dat.tar` file which contains the raw measured throughput values.
This `.dat.tar` will be used to compare measured to predicted throughput in the final step and its format is explained in [Tools & Scripts Overview](#the-dattar-format).

### Analyzing the Predicted and Measured Throughput

The final step is analyzing and comparing the predicted and measured throughput.

Create a script which describes the location of the `.ereport` and `.dat.tar` files.
Name the script `analyze-xdp-my-prog.rb` and insert the following content.
Please substitute the number in the ereports section with the numer of recorded `nfp-estimator` runs and replace the measurement filename with the correct name while ommiting the `.dat.tar` file extension.

    #!./scripts/analyze-nfp-pred.rb --ruleset
    
    data "xdp-my-prog", {
    	ereports: {
    		k: 20,
    	},
    	measurements: {
    		k: "measure-xdp-ereport-xdp-my-prog.k-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
    	},
    }

Do not forget to make the script executable.

    chmod a+x analyze-xdp-my-prog.rb

The script can now be instructed to produce the analysis results.

    ./analyze-xdp-my-prog.rb numbers-xdp-my-prog.k.tex
    ./analyze-xdp-my-prog.rb rate-xdp-my-prog.k.tex
    ./analyze-xdp-my-prog.rb progress-xdp-my-prog.k.tex

The results can be viewed with the help of the following latex document.

    \documentclass{article}

    \usepackage{units}

    \input{numbers-xdp-my-prog.k.tex}
    \input{rate-xdp-my-prog.k.tex}
    \input{progress-xdp-my-prog.k.tex}

    \newcommand{\mdata}[3]{%
    	\csname #1X#2X#3\endcsname%
    }

    \begin{document}
    Estimated naive bound:           \mdata{rate.xdp.my.prog.k}{early.rate}{G2} \\
    Can be improved by:              \mdata{numbers.xdp.my.prog.k}{improve.rate}{.1} \\
    Estimated slowest sat. path:     \mdata{rate.xdp.my.prog.k}{first.rate}{G2} \\
    Underestimates real throughput:  \mdata{rate.xdp.my.prog.k}{prediction.error}{.2} \\
    Slowest measured path:           \mdata{rate.xdp.my.prog.k}{measured.worst.rate.mean}{G2} \\
    99\% confidence interval:   $\pm$\mdata{rate.xdp.my.prog.k}{measured.worst.rate.c99diff}{G2} \\

    Analysis time naive bound:       \mdata{numbers.xdp.my.prog.k}{early.time.mean.s}{2} \\
    99\% confidence interval:   $\pm$\mdata{numbers.xdp.my.prog.k}{early.time.c99diff.ms}{2} \\
    Analysis time slowest sat. path: \mdata{numbers.xdp.my.prog.k}{first.time.mean.s}{2} \\
    99\% confidence interval:   $\pm$\mdata{numbers.xdp.my.prog.k}{first.time.c99diff.ms}{2} \\
    Analysis time all paths:         \mdata{numbers.xdp.my.prog.k}{total.time.mean.s}{2} \\
    99\% confidence interval:   $\pm$\mdata{numbers.xdp.my.prog.k}{total.time.c99diff.ms}{2} \\
    Analysis aborted after:          \mdata{numbers.xdp.my.prog.k}{min.time.s}{2} \\
    \end{document}


## Full Evaluation Setup

### Loading the NFP Kernel Driver

Execution Time: ~30 seconds

We use a modified variant of the Netronome SmartNIC kernel driver, which exposes the SmartNICs DRAM as an BPF array.
This driver is needed for all evaluation steps which use the Netronome SmartNIC.

The kernel module is build and loaded by the following script.
This module needs to be loaded again after every reboot.

    ./X-load-nfp-drv.sh

The modified kernel driver only works when also loading our modified NIC firmware with e.g.:

    ./scripts/load-nfp-firmware.rb -v wpi10

For details on our modifactions see the description of [patched variants of existing tools](#patched-variants-of-existing-tools).


### Compiling the NIC Firmware

Precompiled firmware is provided in `nfp-firmware/`.

Execution Time: ~20 minutes
Required propietary tools: nfp-toolchain_6.3.0-4917-2_amd64.deb

We use modified variants of the Netronome NIC BPF firmware, which expose the SmartNICs DRAM as an BPF array and leave queue selection up to the BPF program.

We use 10 different variants of this firmware which runs the offloaded BPF programs on a varying number of processing cores.
The variants utilize 1 to 10 workers per island (wpi) on 5 islands which results in a total of 5 to 50 used processing cores.

The naming scheme for these variants is as follows.

- `wpi1`: 5 processing cores
- `wpi2`: 10 processing cores
- `wpi3`: 15 processing cores
- `wpi4`: 20 processing cores
- `wpi5`: 25 processing cores
- `wpi6`: 30 processing cores
- `wpi7`: 35 processing cores
- `wpi8`: 40 processing cores
- `wpi9`: 45 processing cores
- `wpi10`: 50 processing cores

Although Netronome [open sourced](#https://github.com/Netronome/nic-firmware) the firmware, a proprietary compiler needs to be [obtained](#mailto:help@netronome.com?subject=Linux toolchain for CoreNIC - Request) from Netronome to build the firmware.

All variants are for the 2x40, 2x25, 2x25 (used with 10 GbE), and 2x10 NICs are build by the following script.

    ./Y-build-nic-firmware.sh

All measurement scripts load the appropriate firmware.
To manually load a firmware onto the NIC, do the following.

    ./scripts/load-nfp-firmware.rb -v <variant>

To e.g., load the firmware variant which executes BPF program on 50 processing cores do:

    ./scripts/load-nfp-firmware.rb -v wpi10

Be aware, that firmware loading may unexpectedly fail or cause kernel crashes.
Please check `dmesg` for success and reboot the computer on failure.

For details on our modifactions see the description of [patched variants of existing tools](#patched-variants-of-existing-tools).


### Throughput Measurement Setup

The throughput measurements require three computers: a computer which executes the BPF programs (host-rx), a computer which sends packets (host-tx) and a third computer (not shown in figure) which orchestrates the measurement and stores the resulting data.
To overload host-rx with packets, a Barefoot Tofino based switch amplifies the number of packets through recirculation.

The following figure shows the connection of host-tx and host-rx to the switch.
When using different switch port numbers or link speeds, changes need to be done in `scripts/accelerator.p4`, `scripts/accelerator_setup.py`, `tasks/measure-xdp-ereport.rb`, `tasks/measure-xdp-ereport-slow.rb`, `tasks/measure-xdp-ereport-workaround.rb`, and `tasks/measure-xdp-wpi-workaround.rb`.

              +-------+  2 x 25 GbE  +----------------+
     host-tx  |  eth1 |--------------| Port 2/0 (140) |
              |  eth2 |--------------| Port 23/0 (52) | Barefoot Tofino
              +-------+              |                | based
                                     |                | EdgeCore Wedge 100BF-32X
     host-rx  +-------+              |                |
       with   |  eth1 |--------------| Port 29 (144)  |
    Netronome |  eth2 |--------------| Port 30 (152)  |
    Agilio CX +-------+  2 x 40 GbE  +----------------+
     2x40 GbE

Each computer needs a copy of this repository as described in the previous subsection.

The Tofino switch also needs a copy of this repository, need the same packages to be installed, but does not need the tools to be compiled.

Additionally, the Tofino switch needs to have the Barefoot SDE in version 9.0.0 and the environment variables `SDE` and `SDE_INSTALL` need to point to the installed SDE.
The scripts `p4_build.sh` and `run_pd_rpc.py` need to be obtained from Intel and placed in a directory from the `PATH` variable.

Ensure that the switch can execute the accelerator by trying on the switch:

    ./scripts/accelerator.sh

Some scripts assume the Netronome Agilio CX 2x40 GbE to be eth1 and eth2 on host-rx and to have the MAC addresses 00:15:4d:13:12:9a and 00:15:4d:13:12:9b.
Either replace these MAC addresses in `scripts/measure-ereports.sh` and `scripts/measure-wpi.sh` with the correct values or change the MAC addresses of your NIC with this command:

    sudo ip link set addr 00:15:4d:13:12:9a dev eth1
    sudo ip link set addr 00:15:4d:13:12:9b dev eth2

All measurements are started from the orchestrating computer which connects to the other computer to remotely execude commands.
The orchestrating computer therefore needs to be able to connect to all other computers through SSH without password login, e.g., by using SSH public key authentication.
Additionally, the user on the remote hosts needs to be able to run commands with sudo without being asked for a password.
The ability to execute remote commands can be tested with the following commands.

    ./tasks/test-remote.rb -c <user>@<host-rx>:nfp-pred-conext
    ./tasks/test-remote.rb -c <user>@<host-tx>:nfp-pred-conext
    ./tasks/test-remote.rb -c <user>@<tofino-switch>:nfp-pred-conext


## Overview Tools & Data Formats

### The _nfp-estimator_

The main approach from the paper is implemented as a tool called the _nfp-estimator_.
It is implemented in C++ and its source can be found in `src/estimator/` and `src/mainf_nfp-estimator.cpp` and is further explained in a separate [subsection](#nfp-estimator-source).
After compiling the _nfp-estimator_ with `make build/nfp-estimator`, it can be executed with `./build/nfp-estimator`.

The purpose of the _nfp-estimator_ is to enumerate program paths sorted from slowest to fastest path.
Only programs in plaintext nfp assembly are analyzed.

    ./build/nfp-estimator -k -f <prog.asm> # enumerate by bit rate
    ./build/nfp-estimator -i -f <prog.asm> # enumerate by packet rate

Additional enumeration modes besides `-k` and `-i` can be viewed when executing `./build/nfp-estimator --help`.
Enumerated paths are always output in the [`.ereport`](#the-ereport-format) format.

#### Options

The _nfp-estimator_ takes several options and some of them are necessary to properly analyze a program.

##### `-U <unroll_limit>`

Programs which contain bounded loops are analyzed by unrolling all loops.
When analyzing a program which contains a loop without specifying an unroll limit, the analysis will abort with an error.
Passing a too large unroll limit still yields valid results, but may cause overly long analysis times.

The simplest case is a program with only a single loop or all loops having the same loop bound.
The `<unroll_limit>` can be passed as a single number which is then applied to all loops within the program.

When having multiple loops with different loop bounds, the unroll limit is specified individually for each basic block in the form `-U <unroll_limit>:<basic_block>,<unroll_limit>:<basic_block>,...`, where basic blocks are identified by the location of there first instruction as shown in the [CFG](#displaying-the-cfg).

##### `-w <workers>`

Specifies the number of processing cores on which the program is executed.

##### `-c <count>`

Stops enumerating paths after `<count>` paths.

##### `-T <timeout>`

Stops analysis after the specified number of seconds.

#### Displaying the CFG

The CFG of a program can be displayed with the help of graphviz.

    ./build/nfp-estimator -g -f <prog.asm> | dot -Tpdf > prog-cfg.pdf

Instructions are combined into basic blocks and edges are annotated with the minimum packet size requìred for this edge.
Solid edges correspond to taken branch instructions and dashed edges correspond to not-taken branch instructions.
All paths end on the pseudo instruction `fin` which always resides at location 15000.

#### _nfp-estimator_ Source

The source code of the _nfp-estimator_ resides in `src/estimator/` and `src/main_nfp-estimator.cpp`.

The most important source files are:

- `src/estimator/cfg.cpp`: CFG analysis and path enumeration
- `src/estimator/instr.cpp`: nfp instruction behavior and costs
- `src/estimator/state.cpp`: execution state and cost tracking
- `src/estimator/expr.hpp`: expressions for the Z3 SMT solver
- `src/estimator/sat_checker.cpp`: executes the Z3 SMT solver

### The `.ereport` format

The [_nfp-estimator_](#the-nfp-estimator) outputs enumerated paths in the `.ereport` format.
`.ereport` files can optionally be bzip2 compressed.
Each section in an `.ereport` starts with four dashes, as shown in the following examples.

- `####`: four dashes followed by a newline signal the performance of the next path, before this path is checked for satisfiablity
- `#### (8)`: a number of unsatisfiable paths with performance numbers for the best path
- `#### ->0--15--24->577->15000`: a satisfiable path, where `->` denotes branches taken and `--` denotes branches not taken

Each section header is followed by some performance numbers, possibly an example packet and some statistics.

Performance numbers are given in mean cycles from which the throughput can be calculated.
The SmartNIC runs all processing cores and the DRAM memory engine at 800 MHz.

    processing cores packet rate = 800000000 / <max cycles> * <#cores>
                DRAM packet rate = 800000000 / <DRAM cycles>
    processing cores    bit rate = 800000000 / <max cycles/b> * 8 * <#cores>
                DRAM    bit rate = 800000000 / <DRAM cycles/b> * 8

The following is an example packet which triggers the satisfiable path.
Some parts of the packet are irrelevant and can be set to any value without triggering a different path.

    |0x0000| -- | -- | -- | -- |
    |0x0004| -- | -- | -- | -- |
    |0x0008| -- | -- | -- | -- |
    |0x000c| 08 | 00 | -- | -- |
    |0x0010| -- | -- | -- | -- |
    |0x0014| -- | -- | -- | 11 |
    |0x0018| -- | -- | -- | -- |
    |0x001c| -- | -- | -- | -- |
    |0x0020| -- | -- | -- | -- |
    |0x0024| 00 | 50 | -- | -- |
    |0x0028| -- | -- | d4 | -- |
    |0x002c| -- | -- | -- | 09 |
    |0x0030| 08 | 04 | 10 | 45 |
    |0x0034| 51 | 54 | 10 | 54 |
    |0x0038| 04 | -- | -- | -- |

Such an example packet can be transmitted by the following command which uses the NIC on teh1 and sends the packets to 00:15:4d:13:12:9a.
The example packet is feed to this command through STDIN.

    sudo ./build/gen-packets -E eth1 00:15:4d:13:12:9a

#### `./scripts/ereport.rb`

`.ereport` files can be processed by the `./scripts/ereport.rb` tool.
Most importantly, this tool and all measurements scripts identify satisfiable paths by a hash of the example packet.
To e.g., list all paths with there hashs and example packets, one per line:

    ./scripts/ereport.rb --packets <prog.k.ereport>

### The `.dat.tar` format

All throughput measurements are stored in tar archives, where member files of a tar archive corresponds to individual measurements of for example different paths through a program.

To list the member files of such an archive do:

    ./build/read -ljf <file.dat.tar>

To show the content of one member file:

    ./build/read -jf <file.dat.tar> -x <member-file>

Each line in such a file is a packet rate measured over a small amount of time.
To get a summary over the content of a member file:

    ./build/statistics -jf <file.dat.tar> -x <member-file>

## Patched Variants of Existing Tools

We use modified variants of different tools.
The modifications are provided in the `patches/` directory and can be applied with `git am`.

### nfp-drv-kmods

Can be checked out into `build/nfp-drv-kmods/` with `make build/nfp-drv-kmods`.

- Source: [https://github.com/Netronome/nfp-drv-kmods](#https://github.com/Netronome/nfp-drv-kmods)
- Based on commit: 89a77d5aaf5eca56d92fee6bc88bde7fac47645a
- `patches/nfp-drv-kmods-89a77d5a-0001-use-array-ptr-from-gprB_23.patch`

### nic-firmware

Can be checked out into `build/nic-firmware/` with `make build/nic-firmware`.

- Source: [https://github.com/Netronome/nic-firmware](#https://github.com/Netronome/nic-firmware)
- Based on commit: 3b81141487ef3ffa0ca732f412b7a7fd029f6f0a
- `nic-firmware-3b811414-0001-enable-BPF-flavor.patch`
- `nic-firmware-3b811414-0002-remove-non-BPF-functionality-from-datapath.patch`
- `nic-firmware-3b811414-0003-1Gb-Array-in-gprB_23.patch`

The NIC firmware only compiles when `git branch` shows the current checkout to be on a branch.

### p4c-xdp

Can be checked out into `build/p4c/extensions/p4c-xdp` with `make build/p4c/extensions/p4c-xdp`.

- Source: [https://github.com/vmware/p4c-xdp](#https://github.com/vmware/p4c-xdp)
- Based on commit: 43f166c017c5428d662ca6717ede9ff359ca5dd4
- `p4c-xdp-43f166c0-0001-removed-output-port-table.patch`

