# victronup
Reads messages from Victron ve.text protocol, uploads time series data

Install
_______
`bundle install`

Usage
_____
`victronup.rb /dev/ttyUSB0`
Replace /dev/ttyUSB0 with the device name for a serial device connected to the ve.direct port of a Victron product.
This code has been tested with an FT232 based TTL serial to USB connector connected to the ve.direct port directly. This should also work with a Raspberry Pi's UART connected to a ve.direct port too.

Warranty
________
This code comes with no warranty and is probably not fit for any purpose.
You'll likely blow up your inverter or charge controller if you use this, and I won't have it if you get upset with me.
I use this code however, so if you trust my judgement enough to give my code access to your expensive power equipment, please let me know what uses you concoct for this code!

License
_______
This code is in the public domain, so, you know, use it if you want to. It'd be cool if you send me patches if you make it better. Or, keep your changes to yourself, like some kind of evil wizard. Whatever.


