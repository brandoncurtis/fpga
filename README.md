# Field-Programmable Gate Arrays (FPGAs)
_one non-computer scientist attempts to figure them out!_
_these demonstrations use the GadgetFactory Papilio Duo with LogicStart, GadgetFactory DesignLab, Xilinx ISE 14.7, all running on Ubuntu 16.04 x64 LTS_

### Repository File Structure

**setup** contains additional files to help with setup and installation, described below.

**constraints** contains the User Constraint File (.ucf) for each board.  The .ucf describes how the variables defined and used in the .vhd file are connected to the physical pins on the board.

**Switches_LEDs** folder containing an implementation of the first 'Hello World'–style VHDL programming example in the [Intro to Spartan FPGA eBook](https://github.com/hamsternz/IntroToSpartanFPGABook) by Mike Field, hamster@snap.net.nz. It requires the Papilio Duo with LogicStart board.  When you have the sketch working, flipping the switches on the LogicStart board cause the corresponding LEDs to light up.  See how very basic .vhd and .ucf files are put together to create a working FPGA sketch!

### Installation and Setup

0. `sudo mkdir /opt/xilinx` — create the folder we'll be downloading and installing into.  You can install anywhere, but this is where I'm installing for demonstration purposes.

0. `sudo chown -R <yourusername>: /opt/xilinx` — make sure you own everything in the installer folder.

0. `tar -xvf ~/Downloads/Xilinx_ISE_DS_Lin_14.7_1015_1.tar -C /opt/xilinx/` — After downloading, unpack [Xilinx ISE](http://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/design-tools.html); for Ubuntu, you'll want the enormous (6.09 GB) 'Full Installer for Linux'.  [A torrent](https://thepiratebay.se/torrent/14572824) is also available.

0. `cd /opt/xilinx/Xilinx_ISE_DS_Lin_14.7_1015_1` — enter the installer folder.

0. `sudo ./xsetup` — run the installer. I installed to `/opt/xilinx`, so all of the ISE files live in `/opt/xilinx/14.7`.  Choose 'ISE WebPACK' from the list of available options, and uncheck 'cable drivers' and 'license key'; we'll take care of them below.

0. `sudo chown -R <yourusername>: /opt/xilinx` — once again, make sure you own everything in the installer folder.

0. `source /opt/xilinx/14.7/ISE_DS/settings64.sh` — sourcing this script, which is basically equivalent to running it in the current shell. Note that we are [sourcing this script, not running it directly](http://superuser.com/questions/176783/what-is-the-difference-between-executing-a-bash-script-and-sourcing-a-bash-scrip), so there is no need to change its permissions to make it executable.

0. `/opt/xilinx/14.7/ISE_DS/ISE/bin/lin64/ise` — start the Xilinx ISE. You'll get a license error, but that's cool.  In the license manager, select the free Webpack license; this is supposed to open a page in your default browser, but at least in Firefox this fails (potentially because [ISE ships with old versions of several C libraries](https://wiki.archlinux.org/index.php/Xilinx_ISE_WebPACK), but I haven't explored this).  That's fine, because you can [download a license for free from the Xilinx site](http://xilinx.com/getlicense) as described in [GadgetFactory: Install Xilinx Free ISE Webpack](http://gadgetfactory.net/learn/2013/10/23/install-xilinxs-free-ise-webpack/).  Select your manually-downloaded license file in the license manager.

0. `/opt/xilinx/14.7/ISE_DS/ISE/bin/lin64/ise` — restart the Xilinx ISE and verify that you no longer get the licensing error.

0.  Open the [Intro to Spartan FPGA Book](https://github.com/hamsternz/IntroToSpartanFPGABook) and work through the initial Switches_LEDs example.  The GadgetFactory Papilio Duo contains the same Xilinx Spartan-6 FPGA as the Papilio Pro, so you'll select [the same FPGA settings](http://forum.gadgetfactory.net/index.php?/topic/2363-xlinx-ise-webtools-on-papilio-duo/) when setting up your FPGA sketch in ISE: `Spartan-6, device = XC6SLX9, package = TQG144, speed = 2`.  The key file's you'll be creating are called 'constraints.ucf' and 'Switches_LEDs.vhd'; see my finished examples in the Switches_LEDs folder of this repo.

0.  Work through the example until you have successfully generated the bitfile that will be written to the FPGA.

0.  `sudo mkdir /opt/papilio` — create the folder where we'll install the software we need to load the bitfile to the FPGA.

0. Download [the Papilio Loader v2](http://forum.gadgetfactory.net/index.php?/files/file/10-papilio-loader-gui/), [DesignLab IDE](http://forum.gadgetfactory.net/index.php?/files/file/236-papilio-designlab-ide/), and the [Papilio Loader source from Github](https://github.com/GadgetFactory/Papilio-Loader) into a folder and unzip them all.  I unzipped DesignLab IDE to `/opt/papilio/designlab`, Papilio Loader to `/opt/papilio/papilio-loader`, and the Papilio Loader source Github repo to `/opt/papilio/papilio-loader-repo`.

0. `sudo chown -R <yourusername>: /opt/papilio` — make sure you own everything in the installer folder.

0. `sudo /opt/papilio/designlab/ubuntu-setup.sh` — Run the DesignLab install script.  We don't need the DesignLab IDE to write the bitfile to the FPGA, but the DesignLab installer sets some device access rules and installs drivers for the FTDI USB-to-serial interface that we need to use Papilio Loader.

0.  Connect the Papilio Duo to your computer using a mini-USB cable as described in the [DsignLab QuickStart](http://gadgetfactory.net/learn/2015/01/14/designlab-quickstart-duo-fpga/).  Run `lsusb` and it should appear as `ID 0403:7bc0 Future Technology Devices International, Ltd`.  Run dmesg, and if your FTDI drivers installed correctly, you should see something like this:
<pre><code>
[27488.670773] ftdi_sio 3-1:1.1: FTDI USB Serial Device converter detected
[27488.670858] usb 3-1: Detected FT2232H
[27488.670863] usb 3-1: Number of endpoints 2
[27488.670869] usb 3-1: Endpoint 1 MaxPacketSize 512
[27488.670874] usb 3-1: Endpoint 2 MaxPacketSize 512
[27488.670878] usb 3-1: Setting MaxPacketSize 512
[27488.671173] usb 3-1: FTDI USB Serial Device converter now attached to ttyUSB1
</pre></code>
If it's not appearing, try rebooting and reloading the FTDI drivers with `modprobe --first-time ftdi_sio`.  Writing the Papilio Duo device ID to the `new_id` file with `/bin/sh -c 'echo 0403 7bc0 > /sys/bus/usb-serial/drivers/ftdi_sio/new_id` may help too; it doesn't hurt, though I haven't analyzed whether it's required (will update soon!).

0. `cd /opt/papilio/papilio-loader-repo/papilio-prog && make clean && ./autogen && ./configure && make && cp papilio-prog /opt/papilio/papilio-loader/programmer/linux32/ && chmod -R u+x /opt/papilio/papilio-loader/programmer/linux32/`
— recompile the `papilio-prog` executable from the Github source files, copy it over into the prebuilt papilio-loader tree, and make it executable.  There are [instructions available for using the Papilio Loader](http://papilio.cc/index.php?n=Papilio.PapilioLoaderV2) and it comes with `papilio-prog` precompiled, but as described in [this forum post](http://forum.gadgetfactory.net/index.php?/topic/2138-getting-started-libftdi-on-ubuntu-1404lts/) the precompiled `papilio-prog` executable is broken in 64-bit Ubuntu and this prevents Papilio Loader from functioning.

0. `/opt/papilio/papilio-loader/papilio-loader.sh` — run the Papilio Loader GUI.  Select the bitfile you created back in ISE and set it to autodetect the target board and write directly to the FPGA.  Write it!  As described in the [Papilio Loader instructions](http://papilio.cc/index.php?n=Papilio.PapilioLoaderV2), writing directly to the FPGA means that the configuration is only temporary until the device loses power.  After power-cycling, whatever is currently written to the SPI flash is auto-loaded to the FPGA, which is, in the case of a factory-fresh Papilio Duo, a sketch that flashes LED1 on the LogicStart board and another green LED on the Papilio Duo mainboard.

0. CONGRATULATIONS.  You've joined the proud, the few, the FPGA DIYers!

### Additional Resources

- [EEVblog #496 - What Is An FPGA?](https://www.youtube.com/watch?v=gUsHwi4M4xE)
- [EEVblog #193 - FPGA Implementation Tutorial](https://www.youtube.com/watch?v=7AFGcAyK7kE)
- [EEVblog #636 - FPGA Demo Boards - DE0 Nano](https://www.youtube.com/watch?v=XZpYfm7jOt8)
- [FPGAs; Lesson 1: Concept Guide and Step by Step Tutorial to Flash LEDs](https://www.youtube.com/watch?v=pDE2qenDXKQ) - Nick Williams also uses VHDL (2015-01)
- [FPGAs; Lesson 2: Interconnecting VHDL modules; Top Level Design and much more](https://www.youtube.com/watch?v=uhxTgUSZvYE) - more advanced concepts with Nick Williams (2015-02)
- [FPGA 101 - Making awesome stuff with FPGAs](https://www.youtube.com/watch?v=Er9luiBa32k)
- [Lec-39 introduction to fpga](https://www.youtube.com/watch?v=CLUoWkJUnN0)

### Update Log

2016-06-15: after extensive installation and configuration testing in a clean Ubuntu 16.04 VM, removed this step from the installation guide:

0. `nano /opt/xilinx/14.7/ISE_DS/settings64.sh` — this settings script sets some environmental variables in preparation for launching Xilinx ISE; make the changes highlighted as `### BC CHANGES` in the `settings64.sh` file included in this repo's `setup` folder.  I have NOT evaluated these changes in-depth.  They come from [this YouTube video](https://www.youtube.com/watch?v=hvD4j9x4rBM), and they appear to work!  If you're using a 32-bit system, you'd do all of this to `settings32.sh` instead.

Added a BASH command for untaring the Xilinx ISE download.
 
