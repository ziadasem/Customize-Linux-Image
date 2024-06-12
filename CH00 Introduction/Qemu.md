# Qemu
in this document, an installation of Qemu is a requirement for this course for those who don't have the hardware.

## 1. What is Qemu
Qemu (Quick emulator) is an emulator that can be used to emulate different boards with their different processors' architectures. including:
* qemu-system-arm -32bit ARM processor
* qemu-system-mips - MIPS
* qemu-system-x86 - x86 processor
* qemu-system-ppc - ppc processor

for every architecture, it emulates a set of machines  which can be viewed by passing the following command:
`<qemu-architecutre> -machine help` 

```bash
ziad@ziadpc:~/toolchain_playground/crosstool-ng$ qemu-system-arm -machine help
Supported machines are:
akita                Sharp SL-C1000 (Akita) PDA (PXA270)
ast2500-evb          Aspeed AST2500 EVB (ARM1176)
ast2600-evb          Aspeed AST2600 EVB (Cortex-A7)
borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
canon-a1100          Canon PowerShot A1100 IS (ARM946)
cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
collie               Sharp SL-5500 (Collie) PDA (SA-1110)
connex               Gumstix Connex (PXA255)
cubieboard           cubietech cubieboard (Cortex-A8)
....
```
searching for Raspberry pi
```bash
ziad@ziadpc:~/toolchain_playground/crosstool-ng$ qemu-system-arm -machine help | grep rasp
raspi0               Raspberry Pi Zero (revision 1.2)
raspi1ap             Raspberry Pi A+ (revision 1.1)
raspi2b              Raspberry Pi 2B (revision 1.1)
```

## 2. Emulator or Simulator?
In the explanation of Qemu, the term `emulator` is used, However, you may encounter the term `simulator`. what is the difference between them and why choose qemu?

both emulators and simulators serve the same purpose but in different methods. an emulator, it tries to mimic the full hardware (CPU, memory, and other hardware components) and mimic the exact performance of the target such that it is possible to replace the target device. on the other hand, the simulator tries to mimic the functionality and characteristics of the target system at a higher level.

in the context of language, the definition of emulator and simulator is:
>**emulate**: to try to equal or excel; imitate with effort to equal or surpass 

>**simulate**: to give or assume the appearance or effect of often with the intent to deceive

the definitions give a clear summary of the difference between them; one tries to be exact, and the other (simulator) tries to deceive.

### Emulator
the main advantage of the emulator is it can replace the target, such that it mimics all of its components.

**Purpose**:
to replace the real device.

**Main Features**:

* reproduction of the target environment with great accuracy, including both software and hardware characteristics  (high Fidelity).
* Can run the same binary code intended for the target device without modification by translation of the binary code on the host to its equivalent code on the target (Binary translation).
* Ideal for testing low-level functionality, hardware-specific features, and performance.


**Advantages**:

* High accuracy and fidelity to the target device.
* Useful for debugging hardware-related issues.
* Can run a wide range of applications, including those that interact closely with the hardware.

**Disadvantages**:

* Can be resource-intensive and slower than running on actual hardware.
* Sometimes challenging to set up and configure.

**When to use**:

when you need to test your application against the hardware, or the application requires hardware access, for example, mobile applications that require GPS or Camera, or Embedded Board that requires access hardware via kernel and device drivers.

**Use Cases**:
* Mobile app development (e.g., Android emulators).
* Embedded systems development.

**Examples**:

* [android emulator](https://developer.android.com/studio/run/emulator): emulates an android real device with its sensors and hardware.
* [wineHQ](https://www.winehq.org/): run windows on Linux machine


### Simulator

a simulator simulates the software environment such as variables and configuration, without interacting with the hardware, hence is no need for binary translation. so that it is faster than the emulators.

**Purpose**:

For analysis and study

**Main features**:

* Provide a high-level representation of the target environment.
* Typically requires code modification or recompilation to run in the simulated environment.
* Ideal for testing software logic, user interfaces, and general application behavior.

**Advantages**:

* Faster and less resource-intensive than emulators since no need for binary translation.
* Easier to set up and use.
* Good for rapid testing and development cycles.

**Disadvantages**:

* Lower accuracy compared to emulators.
* Cannot test hardware-specific features or performance accurately.
* Limited in running applications that require deep hardware integration.

**When to use**:

when you need to test your application against other applications, for example, two applications send data to each other, no need for the overhead of hardware emulation for this case, also on testing user interface such as screen resolution, or when you are not sure about which hardware is the best for your application and you want to test it in the best environment.

**Use Cases**:
* Mobile app development (e.g., IOS simulators).
* Educational purposes for learning system behavior.
* Flight Simulator, no need to mimic the hardware of the aircraft.

**Examples**:

* [flight simulator](https://www.flightsimulator.com/): Microsoft Flight Simulator is the next generation of one of the most beloved simulation franchises. 
* [MATLAB](https://www.mathworks.com/products/matlab.html): used for designing, modelling  and simulating systems and their behaviors in an environment
* [proteus software](www.labcenter.com): The Proteus Design Suite combines ease of use with a powerful feature set to enable the rapid design, testing, and layout of professional printed circuit boards.

in the end, we will require software that mimics the hardware of the board due to our applications that will make use of the hardware (memory for booting and other hardware for device drivers). hence we will choose an emulator as a solution for our case and we will choose `Qemu`.

### Is qemu an emulator?

if its name doesn't answer this question (Quick emulator), then this section will answer it.

**Main Features**:

* The main feature of an emulator is to mimic hardware, `Qemu` is developed for this purpose and to enable virtualization.

* Qemu Can emulate various CPU architectures, making it highly versatile for cross-platform tasks.

* QEMU can emulate an entire system, including the CPU, memory, peripherals, and other hardware components. This allows you to run software for one architecture on a completely different architecture (e.g., running ARM software on an x86 machine).


these selected features show that Qemu **mimics the hardware of the target**, hence it is an emulator.


## 3. Installing and discovering Qemu
we will use qemu-system-arm, so we will install it
```bash
sudo apt update
sudo apt install qemu-system-arm
```

Note for installing Qemu for other architectures, install `sudo apt install qemu-system-<architecture>`

**An example of running the Qemu command**
an example of a command, may not work on your device since it refers to specific files in the author's OS.
```
qemu-system-arm -machine vexpress-a9 -m 256M -drive file=rootfs.ext4,sd -net nic -net use -kernel zImage -dtb vexpress- v2p-ca9.dtb -append "console=ttyAMA0,115200 root=/dev/mmcblk0" -serial stdio -net nic,model=lan9118 -net tap,ifname=tap0
```

**The options used in the preceding command line are as follows**:

Note: These options will be discussed in detail later.

* `-machine vexpress-a9`: Creates an emulation of an Arm Versatile Express development board with a Cortex A-9 processor

*  `-m 256M`: -m for memory. Populates it with 256 MiB of RAM
* `-drive file=rootfs.ext4,sd`: Connects the SD interface to the local file in the author's machine **rootfs.ext4** (which contains a filesystem image) 
* `-kernel zImage`: Loads the Linux kernel from the local file named `zImage`

* `-dtb vexpress-v2p- ca9.dtb`: Loads the device tree from the local file vexpress-v2p-ca9.dtb

* -append "...": Appends this string as the kernel command line

* -serial stdio: Connects the serial port to the terminal that launched QEMU, usually so that you can log on to the emulated machine via the serial console
* `-net nic,model=lan9118`: Creates a network interface
* `-net tap,ifname=tap0`: Connects the network interface to the virtual network interface, tap0 to make the machine accessible

