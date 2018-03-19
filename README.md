# libopencm3-miniblink

This repository contains miniblink examples for any and all boards we can find.

It is intended to be a basic starting point for people who want to test that
their compiler toolchain, flash programming and/or debugger are all working as
expected.

It contains _only_ basic blinky examples, one for each board.  If you are
looking for full examples that setup complicated clocks, or use onboard
peripherals, you are in the *wrong* place.

# Building

Just run ```make```.

If necessary, this will checkout and build the libopencm3 repository, and
then generate a blinky for every known board in the bin directory.

If you want to see exactly what it did, run ```make V=1```

# Flashing

Unfortunately, flashing these examples is a _very_ openended task.  Below are
some examples that might be helpful, but this is not an exhaustive list.

## Using [OpenOCD](http://openocd.org/)
OpenOCD can support a multitude of debug interfaces and targets. Unfortunately
this makes it's config more verbose than some tools.

The general form is
```
$ openocd -f interface/<your debugger>.cfg -f target/<your target>.cfg \ 
     -c "program file.elf verify reset exit"
```

For boards with integrated debuggers, you can sometimes shortcut with a "board.cfg" file instead.

```
$ CMD="program ${ELF_FILE} verify reset exit"
$ openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "${CMD}"
$ openocd -f board/stm32l4discovery.cfg -c "${CMD}"
```

## Using [st-flash](https://github.com/texane/stlink)
st-flash or st-util can be used with STM32 targets only, with STLink
debugger hardware.

```
$ st-flash write path/to/yourfile.bin 0x800000
```

# Next steps

If you _are_ looking for more complicated examples, the [Original libopencm3-examples](http://github.com/libopencm3/libopencm3-examples)
is still relevant, though it's not well maintained, particularly for newer hardware.

Other places to look are the [USB Gadget-Zero Tests](https://github.com/libopencm3/libopencm3/tree/master/tests/gadget-zero) are also good at testing your USB hardware.  You may also find interesting pieces at https://github.com/karlp/libopencm3-tests and there's also a showcase listed on https://github.com/libopencm3/libopencm3/wiki/Showcase


