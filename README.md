## USRP RIO Streaming

Example demostrating how to stream dummy data from the USRP RIO FPGA to the host. The example
was developed using the receiver of a USRP-2945R. Host and FPGA were carefully simplified to
the minimum dependencies so it can be compile with other targets.

For now the code streams at discrete decimation steps of 200 MHz a sequential, incrementing
ramp of U64 that starts at 0. In the host you will see the ramp skip values depending on the
requested decimation. The minimum value decimation value is 2 which yields u64s at 200/2 MHz
for a total of 8 bytes at 100 MHz or 800 MB/s.

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

### References
* Drivers can be found at: http://www.ni.com/downloads/drivers/

### Notes
The codes has a U64 LSFR that has not been tied to the **target to host** FIFO and
may not trully implement an LSFR :). The LabVIEW FGPA implements a [Fibonacci LSFR](https://en.wikipedia.org/wiki/Linear-feedback_shift_register#Fibonacci_LFSRs) but  has not been validated. For now the code only
streams a sequential ramp. 

If you are running on a command line with access to vim you can use the following command to diff inside your repo:

```
git difftool --tool=lvdiff
```
Be aware that you will need to do some local .gitconfig changes, all documented in: [LVCompareWrapper.sh](https://github.com/NISystemsEngineering/USRP-RIO-Streaming/blob/master/LVCompareWrapper.sh). This git LVCompare.exe integration is experimental so please use with patience and care. Some lines will look like they were written by a noob, this is due to a combination of making the script as clear as possible as well as really being noob writing bash scripts.

What does vim has to do with this script? vimdiff is the default difftool if the extension of a file is not __.vi__

## License
[MIT License](https://github.com/NISystemsEngineering/USRP-RIO-Streaming/blob/master/LICENSE.md)
