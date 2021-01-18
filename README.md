# AutoAPI Swift SDK

The AutoAPI Swift SDK purpose is to help developers serialise [AutoAPI](https://high-mobility.com/learn/tutorials/getting-started/auto-api-guide/) data in Swift, so they wouldn't have to worry about parsing and generating the bytes themselves.
The SDK is generated based on the AutoAPI [spec](https://github.com/highmobility/auto-api).

Table of contents
=================
<!--ts-->
   * [Features](#features)
   * [Integration](#integration)
   * [Requirements](#requirements)
   * [Getting Started](#getting-started)
      * [Examples](#examples)
   * [Contributing](#contributing)
   * [License](#license)
<!--te-->


## Features

**Serialising**: The library is designed to serialise AutoAPI data to and from Swift types.

**Support for Updates**: Updates to the AutoAPI spec (non-binary) will work with older versions of the library and the new types of data are accessible.


## Integration

The library is distributed as a *Swift Package*, allowing it to be used with Xcode's built-in SPM or directly in a `Package.swift`.  

For using the package through Xcode, it can be added in `File > Swift Packages > ...` or going to project settings and selecting `Swift Packages` in the top-center.  
When targeting a Swift package, the `Package.swift` file must include `.package(url: "https://github.com/highmobility/auto-api-swift", .upToNextMinor(from: "[__version__]")),` under *dependencies*.  


## Requirements

AutoAPI Swift SDK requires Xcode 11.0 or later and is compatible with apps targeting iOS 10.0 or above.


## Getting started

Get started by reading the [iOS AutoAPI guide](https://high-mobility.com/learn/documentation/mobile-sdks/ios/autoapi/) in high-mobility.com.  

Check out the [spec](https://github.com/highmobility/auto-api/tree/master/SPEC.md) for more details on the structure and logic, or some other libs generatated on that spec: [Android](https://github.com/highmobility/hm-java-auto-api), [Elixir](https://github.com/highmobility/hm-auto-api-elixir).  

### Examples

There are 3 sample apps available on Github.com to showcase usage of AutoAPI (and HMKit):

- [Scaffold](https://github.com/highmobility/hm-ios-scaffold) 
  - Demonstrates the most basic usage of AutoAPI.
- [Data Viewer](https://github.com/highmobility/hm-ios-data-viewer)
  -  Tries to parse and show the AutoAPI data received from a vehicle. Limited functionality to send commands.
- [AutoAPI Explorer](https://github.com/highmobility/hm-ios-auto-api-explorer)
  - Incorporates all the "abilities" of the previous sample apps along with more commands to send to the vehicle and takes a shot at a nice(r) UI.


## Contributing

We would love to accept your patches and contributions to this project. Before getting to work, please first discuss the changes that you wish to make with us via [GitHub Issues](https://github.com/highmobility/auto-api-swift/issues), [Spectrum](https://spectrum.chat/high-mobility/) or [Slack](https://slack.high-mobility.com/).

The generator used to create this lib, based on the AutoAPI spec, will be open-sourced in the near future. Until then, changes to the Swift interface need to go through our private generator. If you'd like to make changes to the AutoAPI, please see [here](https://github.com/highmobility/auto-api).

Releases are done by tagged commits (as required by SPM, please read more about it [here](https://swift.org/getting-started/#using-the-package-manager) and [here](https://github.com/apple/swift-package-manager/tree/master/Documentation)).

See more in [CONTRIBUTING.md](https://github.com/highmobility/auto-api-swift/tree/master/CONTRIBUTING.md)


## License

This repository is using MIT license. See more in [LICENSE](https://github.com/highmobility/auto-api-swift/blob/master/LICENSE)
