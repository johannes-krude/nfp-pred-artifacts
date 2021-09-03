# Artifacts from the ConNEXT '21 Paper (submitted)

This Repository contains the artifacts for the ConNEXT '21 Paper (submitted) ["Determination of Throughput Guarantees for Processor-based SmartNICs"]().

The evaluation in the paper can be repeated using the artifacts in this repository.
Repeating the full evaluation takes several days and requires special hardware (Netronome SmartNIC, Barefoot Tofino Switch).
The Evaluation is therefore structured individual steps to enable repeating only parts of the evaluation when not having all required hardware or having only limited time.
Any step can be ommitted, since this repository contains all intermediate data.

When having no hardare access and only very limited time, the [small evaluation example](#small-evaluation-example) shows how to determine throughput gurantees for a small example program.

This documents starts with the [evaluation setup](#evaluation-setup), describes a [small evaluation example](#small-evaluation-example), individually describes all the evaluations steps, and closes with a [description](#overview-tools-scripts) of the individual tools contained in this repository.


## Evaluation Setup

All evaluation steps require at least a single computer running Ubuntu 20.04.
Some steps need up to three computers, a Netronome Agilio LX 2x40 GbE NIC, and a Barefoot Tofino based Edgecore Wedge 100BF-32X switch.

### Docker Image

- Time: TODO + 5 minutes

Those evaluation steps which require no special hardware can be executed within the following Docker environment.

Build the docker image with:

    sudo docker build -t nfp-pred-artifacts:latest - < Dockerfile

Start an interactive shell in the Docker image with:

    sudo docker run -it -u $(id -u):$(id -g) -v $(pwd):/nfp-pred-artifacts -w /nfp-pred-artifacts nfp-pred-artifacts:latest

The tools in the repository still need compiling by executing within the Docker image:

    make

This docker image can now be used for the [small evaluation example](#small-evaluation-example) as well as evaluations steps [2](#2-predicting-the-throughput-of-the-example-programs) and [5](#5-analyzing-the-measured-data).


### Installing Ubuntu 20.04 with Dependencies

- Time: TODO + 5 minutes 

All evaluation steps which use the Netronome SmartNIC can not be executed with Docker or any other virtualization environment.
Instead, bare metal Ubuntu 20.04 is needed.

Since the modified nfp kernel driver does not work with newer kernels, do not install an Ubuntu HWE kernel, but use the original Ubuntu 5.4.x kernel from Ubuntu 20.04.

Please install the following packets on all computers.

    apt-get install --no-install-recommends git build-essential libjudy-dev libpcap-dev ruby libtrollop-ruby binutils-dev libiberty-dev libelf-dev pbzip2 texinfo openssh-client bison flex libssl-dev z3 wget clang llvm python sudo linux-headers-generic gnuplot texlive-full

This repository needs to be cloned into the users home directory on each computer and the tools need to be compiled with the following command.

    make

### Throughput measurement setup

The throughput measurements require three computers: a computer which executes the BPF programs (host-rx), a computer which sends packets (host-tx) and a third computer (not shown in figure) which orchestrates the measurement and stores the resulting data.
To overload host-rx with packets, a Barefoot Tofino based switch amplifies the number of packets through recirculation.

The following figure shows the connection of host-tx and host-rx to the switch.
When using different switch port numbers or link speeds, changes need to be done in `scripts/accelerator.p4`, `scripts/accelerator_setup.py`, `tasks/measure-xdp-ereport.rb`, `tasks/measure-xdp-ereport-slow.rb`, `tasks/measure-xdp-ereport-workaround.rb`, and `tasks/measure-xdp-wpi-workaround.rb`.

              +-------+  2 x 25 GbE  +----------+
     host-tx  |  eth1 |--------------| Port 2/0 |
              |  eth2 |--------------| Port 2/1 | Barefoot Tofino
              +-------+              |          | based
                                     |          | EdgeCore Wedge 100BF-32X
     host-rx  +-------+              |          |
       with   |  eth1 |--------------| Port 29  |
    Netronome |  eth2 |--------------| Port 30  |
    Agilio CX +-------+  2 x 40 GbE  +----------+
     2x40 GbE

Each computer needs a copy of this repository as described in the previous subsection.

The Tofino switch also needs a copy of this repository, need the same packages to be installed, but does not need the tools to be compiled.
Additionally, the Tofino switch needs to have the Barefoot SDE in version 9.0.0 and the environment variables `SDE` and `SDE_INSTALL` need to point to the installed SDE.
TODO!!!

All measurements are started from the orchestrating computer which connects to the other computer to remotely execude commands.
The orchestrating computer therefore needs to be able to connect to all other computers through SSH without password login, e.g., by using SSH public key authentication.
Additionally, the user on the remote hosts needs to be able to run commands with sudo without being asked for a password.
The ability to execute remote commands can be tested with the following commands.

    ./tasks/test-remote.rb -c <user>@<host-rx>:nfp-pred-conext
    ./tasks/test-remote.rb -c <user>@<host-tx>:nfp-pred-conext
    ./tasks/test-remote.rb -c <user>@<tofino-switch>:nfp-pred-conext



### Loading the NFP Kernel driver

We use a modified variant of the Netronome SmartNIC kernel driver, which exposes the SmartNICs DRAM as an BPF array.
This driver is needed for all evaluation steps which use the Netronome SmartNIC.

The kernel module is build and loaded by the following script.
This module needs to be loaded again after every reboot.

    ./X-load-nfp-drv.sh

### Compiling the NIC Firmware


## Small Evaluation Example

- Required hardware: 1 computer
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

- Required Hardware: 1 computer with Netronome Agilio CX (eth1), modified nfp driver, modified nic-firmware, sudo without password
- Time: TODO
- Input: examples/*.c examples/*.p4 examples/*.sh
- Output: data-repeated/programs/*.asm
- Output: data-repeated/programs/*.bpf.o

This step compiles the example programs to bpf bytecode and Netronome nfp assembly.

    ./1-compile-examples.sh

When omitting this step, precompiled output resides in `data-paper/programs/`.

### 2. Predicting the Throughput of the Example Programs

- Required Hardware: 1 computer (preferably Core i7-7700 with 16 GiB RAM)
- Time: ~10 days
- Input: data-{paper,repeated}/programs/*.asm
- Output: data-repeated/predictions/*.ereport

This step performs the main approach from the paper.
It takes as input the nfp assembly of a bpf program and enumerates paths through this program ordered from lowest overestimated throughput to highest overestimated throughput.

    ./2-predict-throughput.sh data-paper/programs  # !! runs for ~10 days

To use your own compiled nfp assembly, run:

    ./2-predict-throughput.sh data-repeated/programs  # !! runs for ~10 days

This script executes different variants of the main approach on all example programs and repeats each configuration over 20 runs resulting in a total of 5420 runs.
The resulting .ereport files should always list the same program paths over multiple runs.However, the analsyis time will slightly differ between multiple runs, and will probably differ even more from the results in the paper unless you are using a Core i7-7700 with 16 GiB RAM.

Instead, one can analyze a single program for its slowest program path by executing:

    ./build/nfp-estimator -k -S -c 1 -f <asm-file>

The output in the `.ereport` files from this step is explained in the [tool description](#ereport).

When omitting this step, the predictions used in the paper reside in `data-paper/predictions/`.

### 3. Measuring the Throughput of the Example Programs

When omitting this step, the throughput measurements used in the paper reside in `data-paper/measured-throughput/`.

### 4. Throughput Measurement for Section 4

When omitting this step, the measurements used in the paper reside in `data-paper/measurements-section4/`.

### 5. Analyzing the Measured Data

- Required hardware: 1 computer
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


## Overview Tools & Scripts

