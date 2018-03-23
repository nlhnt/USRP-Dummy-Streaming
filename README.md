# USRP RIO Streaming

Example demostrating how to stream dummy data from the USRP RIO FPGA to the host. The example
was developed using the receiver of a USRP-2945R. Host and FPGA were carefully simplified to
the minimum dependencies so it can be compile with other targets.

For now the code streams at discrete decimation steps of 200 MHz a sequential, incrementing
ramp of U64 that starts at 0. In the host you will see the ramp skip values depending on the
requested decimation. The minimum value decimation value is 2 which yiels a u64 at 200/2 MHz
for a total of 8 bytes at 100 MHz or 800 MB/s.

The codes also has a U64 LSFR that has not been tied to the **target to host** FIFO and
may not trully implement an LSFR :). The code implements a [Fibonacci](https://en.wikipedia.org/wiki/Linear-feedback_shift_register#Fibonacci_LFSRs) but it has not been validated. For now the code only
streams a sequential ramp. 

### Things to remember:
* Reserving the space in disk for the async tdms requires admin priviliges. Make sure you launch
LabVIEW accordingly.

### System BOM
* Hardware
	- PXIe-8135
	- PXIe-8374
	- X310, USRP-29xxR

* Software
	- LabVIEW 2016 (32 bits)
	- LabVIEW FPGA 2016
	- NI-USRP
	- NIFlexRIO

### Other Notes
* Drivers can be found at: http://www.ni.com/downloads/drivers/
