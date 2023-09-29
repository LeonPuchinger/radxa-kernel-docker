# Radxa Kernel Docker

Build the vendor kernel for Radxa SBC's using Docker.
Cross-compilation works on x86 (tested).
The build process has only been tested on the Rock 5 (Model B) on kernel version `stable-5.10-rock5`.
I have not tested any other configurations, however, they may still work with this container image.
Instructions on how to customize kernel versions and target hardware can be found below.

## Usage

```
docker build -t radxa-kernel .
mkdir out
docker run --rm -it -v $(pwd)/out:/sdk/out:ro radxa-kernel
```

The build process fetches the latest sources at runtime, so the image does not have to be rebuilt in order to compile a different version of the kernel.
The built binaries as well as debian packages can be found in `out/`.

## Customizing the Build

The build process can be customized to compile for a different version or device.
To do this, set the `KERNEL_VERSION` and `DEVICE` environment variables for the container.
In case these variables are not explicitly set, they assume their default values (which are shown before starting the build).
The kernel match the branch names in the [Radxa kernel repository](https://github.com/radxa/kernel) and can be obtained from there.

Example:

```
docker run --rm -it -v $(pwd)/out:/sdk/out:ro -e KERNEL_VERSION=linux-5.10-gen-rkr4.1 radxa-kernel
```
