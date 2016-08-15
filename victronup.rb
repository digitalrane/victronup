#!/usr/bin/ruby

require "serialport"
require "bunny"

if ARGV.size < 1 then
  puts "Usage: #{$0} /dev/ttyUSB0 (or other serial device)"
  exit( 1 )
end

port = ARGV[0]

BAUD = 115200
DATABITS = 8
STOPBITS = 1
PARITY = SerialPort::NONE

serial = SerialPort.new( port, BAUD, DATABITS, STOPBITS, PARITY )

def update( data, value )

  puts "Updating #{ data } with #{ value }"

end

while true do

  line = serial.gets( "\r\n" )

  if line then

    ( data, value ) = line.chomp.chomp.encode( "UTF-8", :invalid => :replace ).split( /\t/ )

    if data and value

      case data
      when 'CS'
        update( 'state', value )
      when 'MODE'
        update( 'mode', value )
      when 'AC_OUT_V'
        update( 'acvolts', "#{ value.to_f / 1000 }V" )
      when 'VPV'
        update( 'pvvolts', "#{ value.to_f / 1000 }V" )
      when 'AC_OUT_I'
	update( 'acamps', "#{ value }A" )
      when 'V'
	update( 'dcvolts', "#{ value.to_f / 1000 }V" )
      when 'AR'
        update( "alarm", value )
      when 'ERR'
        update( "error", value )
      when 'I'
        update( "batteryamps", "#{ value }mA" )
      when 'IL'
        update( "loadamps", "#{ value }mA" )
      when 'PPV'
        update( "solarwatts", "#{ value }W" )
      when 'LOAD'
        update( "loadstatus", value )
      when 'H19'
        update( "yieldtotal", "#{ value.to_f / 100}kWh" ) 
      when 'H20'
        update( "yieldtoday", "#{ value.to_f / 100}kWh" )
      when 'H22'
        update( "yieldyesterday", "#{ value.to_f / 100}kWh" )
      when 'H21'
        update( "maxpowertoday", "#{ value }W" )
      when 'H23'
        update( "maxpoweryesterday", "#{ value }W" )
      else
        puts "Unknown field: #{ data }"
      end
    end
  end


  sleep 0.01
end
