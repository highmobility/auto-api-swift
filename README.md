## What is in this repository ##

**AutoAPI** parsing source code in *Swift*, that can be made into a *framework* by `swift build` (*macOS* and *Linux* only), or through *Xcode*. Using the latter allows additionally to build for *iOS*, *tvOS* or *watchOS*.  

In addition, if using this as a *dependency* with Swift Package Manager, the suitable architecture is handled by Xcode.
  
Lastly, there's a *command-line* parser for quickly debugging AutoAPI data.  

## Framework Usage ##

For *iOS*, it's recommended to build the *universal* framework - thus enabling running on a simulator as well.  
There's an `AppStoreCompatible.sh` script for thinning the framework before submission to iTC.  

For *macOS* and *Linux*, executing `swift build` and using the product is recommended (use the `--show-bin-path` option to get the output path).

For *other Apple* platforms, the *universal* framework can be made with `lipo` from *Xcode*'s simulator and device products. When creating a *universal* one, the *module maps* need to be copied as well.  

For details on the API itself, please see the [documentation](https://developers.high-mobility.com/resources/documentation/auto-api/api-structure/tutorial/).

## Parser Usage ##

Simply execute `./AutoAPICLT [input]` on the command-line.  
  
Input can be in *hex*, *base64* or "scrambled" (see the flags).  
The parser outputs only what it was able to understand.  

Flags:  
 -b64: input is in Base64 instead  
 -dc: input is like in Developer Center examples  
 -ep: expand properties  
 
 ![screenshot](assets/screenshot.png?raw=true)
