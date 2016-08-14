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
        update( 'acvolts', "#{ value.to_i / 100 }V" )
      when 'AC_OUT_I'
	update( 'acamps', "#{ value }A" )
      when 'V'
	update( 'dcvolts', "#{ value.to_i / 1000 }V" )
      when 'AR'
        update( "alarm", value )
      end
    end
  end

  sleep 0.01
end
