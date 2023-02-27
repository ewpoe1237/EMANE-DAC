# DAC Robot Swarm Emulator Testbed

This repository houses the EMANE testbeds for the DAC 6.5 robotic swarm resilience project. The testbeds in this repository are intended to be run in conjunction with [ARGoS](https://www.argos-sim.info/core.php), a robotic swarm emulator. More information regarding the integration of ARGoS and EMANE can be found [here](git@github.com:NESTLab/ARGoS-EMANE.git).

## Installing this testbed
This testbed requires EMANE and its corresponding software to run, directions for installing EMANE can be found [here](https://github.com/adjacentlink/emane/wiki/Install). (EMANE version 1.3.3 was used, future versions are likely to work, but no guarantees or support are provided.)

## Using this testbed
The testbeds included in this repo use the [letce2](https://github.com/adjacentlink/letce2-tutorial) system for configuring and running EMANE experiments.

A startup script titled `run-emane.sh` is provided to streamline the process. This script must be provided an action to perform (build, start, stop, or clean) and an experiment number. For details on other optional arguments, `run-emane.sh help` can be used.

## Experiment Key
*exp-01*: Experiment Number: 1

This testbed used for integration testing between EMANE, ARGoS, and SysML. It consists of a basic testbed with three mobile nodes and a static gateway node. This experiment uses a basic "basewave" wireless model for testing. The basewave uses an rfPipe waveform with the default configuration listed on the EMANE wiki.

*exp-02*: Experiment Number: 2

This testbed an extension of *exp-01* used for further integration testing. The configuration is identical with the except of 10 mobile nodes rather than 3. *exp-02* still uses the generic "basewave" wireless model.
