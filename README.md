# USRP RIO Streaming

Example demostrating how to stream dummy data from the USRP RIO FPGA to the host. The example
was developed using the receiver of a USRP-2945R. Host and FPGA were carefully simplified to
the minimum dependencies so it can be compile with other targets.

For now the code streams at discrete decimation values of 200 MHz and sequential, incrementing
ramp of U62 that starts at 0. In the host you will see the ramp skip values depending on the
requested decimation. The minimum value decimation value is 2 which yiels a u64 at 200/2 MHz
for a total of 8 bytes at 100 MHz or 800 MB/s.

* Hardware
	- PXIe-8135
	- PXIe-8374

* Software
	- LabVIEW 2016
	- LabVIEW FPGA 2016
	- NI-USRP
	- NIFlexRIO
	
* Drivers can be found at: http://www.ni.com/downloads/drivers/
