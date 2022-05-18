# sof-essx8336-debian-fix
> Fixes to get ESSX8336 audio working for Intel Gemini Lake systems in Debian

## Problem
I found myself needing to support a new hardware platform for our [GrandCare devices](https://www.grandcare.com/). Everything was working fine, 
except that I simply could not get the audio to work. The more I dug into the issue, the more people I found with the exact same problems. 
They seem to stem from a very new sound device from Everest Semiconductor called the ESSX8336 for the Intel Gemini Lake chipset. This device 
apparently has flawless Windows drivers, but Linux not so much. After a few days of google and 
[getting in the weeds with the SOF folks](https://github.com/thesofproject/linux/issues/2955), I was able to boil the issue down to a few main 
points:

* The kernel has a compatible module that provides support for the ESSX8336, but it is disabled in pretty much all of the major distro kernel configs (including Debian, which was the one I cared about).
* The SOF topologies for the device don't seem to be part of any of the distro packages of [sof-bin](https://github.com/thesofproject/sof-bin).
* The ALSA mixer controls for the device are convoluted and hard to understand, making it difficult to get sound to work properly even after you get the driver working.

## Fix
Most of the fixes came courtesy of [yangxiaohua2009](https://github.com/yangxiaohua2009) (who seems to have some insight into the underlying 
hardware) in the repo [custom-kernel](https://github.com/yangxiaohua2009/custom-kernel). I have tweaked them a bit to make them a little more
Debian friendly, namely by using the sid kernel source to build the updated kernel. Here are the details of what worked:

* Built and packaged the latest sid kernel (5.17.6) with the `CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH=m` config parameter enabled.
* Installed the latest [sof-bin](https://github.com/thesofproject/sof-bin) binaries and topologies.
* Added a script to set basic ALSA values to get input and output working at resonable levels.
* Added a script to fix pulseaudio to properly detect the device and use it.
