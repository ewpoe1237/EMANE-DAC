# Running Experiment-00 Without EMANE Manager
Since the first experiment (exp-00) in this repository does not rely on robot locations to calculate pathloss, it can be run without the intermediate EMANE-Manager script. This page describes the process to start up the shared platform in this manner.

## Setting up the EMANE Experiment
### Configuring EMANE
By default, `exp-00` is configured to initialize with 3 nodes and the special Gateway node. Nodes can be added or removed by modifying the [experiment.cfg](../exp-00/experiment.cfg) file.

The format of a node instantiation block is as follows:
```
[nem-#:precomputed-node]
@id=#
```
Where # is replaced with the next available number (between 1-253, inclusive)

### Building EMANE
Once configured, the `run-emane.sh` file can be used to build the experiment with:
```
sudo ./run-emane.sh build 0
```
The experiment can be confirmed built by verifying the `exp-00` directory has a subdirectory for each NEM

## Running EMANE
The EMANE experiment can be run by envoking:
```
sudo ./run-emane.sh start 0
```
Each network node will start an LXC container that can be accessed via `ssh`.
To access `nem-1` the command is simply `ssh nem-1`. NEMs with IDs between 1 and 15 have their access IP addresses stored in `/etc/hosts`.

## Running emanerelayd (ARGoS Interface Program)
The EMANE relay program (emanerelayd) is by default configured to not run automatically on each NEM to allow for manual debugging. To start the program, it must be run on each NEM. The command must be ran from inside each LXC and must be provided the ID number of the NEM currently logged into. The program can be ran with the `-d, --daemonize` argument to run it disconnected from the currently terminal.

Once the program is running, it will wait until ARGoS connects to it, then resume running. This connection occurs after ARGoS is signaled in the next step.

## Bypassing EMANE-Manger
During ARGoS startup, the EMANE-Manager is expected to signal that it is ready to begin. Since the EMANE-Manager can be bypassed due to not needing locations. ARGoS can be resumed by sending the appropriate signal once the above setup is complete.
```
kill -CONT ${ARGoS_PID}
```

## Shutting Down EMANE
When ready to shutdown EMANE, the following command can be used:
```
sudo ./run-emane.sh stop 0
```
This will kill all EMANE processes and shutdown all created LXCs.