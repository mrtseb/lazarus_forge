unit firmata;

interface

const

//// Message command bytes - straight outta Pd_firmware.pde
DIGITAL_MESSAGE = $90; // send data for a digital pin
ANALOG_MESSAGE = $E0; // send data for an analog pin (or PWM)

// PULSE_MESSAGE = $A0 // proposed pulseIn/Out message (SysEx)
// SHIFTOUT_MESSAGE = $B0 // proposed shiftOut message (SysEx)

REPORT_ANALOG_PIN = $C0; // enable analog input by pin //
REPORT_DIGITAL_PORTS = $D0; // enable digital input by port pair
START_SYSEX = $F0; // start a MIDI SysEx message
SET_DIGITAL_PIN_MODE = $F4; // set a digital pin to INPUT or OUTPUT
END_SYSEX = $F7; // end a MIDI SysEx message
REPORT_VERSION = $F9; // report firmware version
SYSTEM_RESET = $FF; // reset from MIDI

// Pin modes
DIGITAL_INPUT = 0;
DIGITAL_OUTPUT = 1;
DIGITAL_PWM = 2;

type Tfirmata= object
private

      Fmessage: byte;
      Fpin:byte;
public
      constructor create;

end;

implementation

constructor Tfirmata.create;
begin

end;


(*
def _process_input(self, data):
        """Process a command byte and any additional information bytes"""
        if data < 0xF0:
            #Multibyte
            message = data & 0xF0
            pin = data & 0x0F
            if message == DIGITAL_MESSAGE:
                #Digital in
                lsb = ""
                msb = ""
                while lsb == "":
                    lsb = self.sp.read()
                while msb == "":
                    msb = self.sp.read()
                lsb = ord(lsb)
                msb = ord(msb)
                Digital.mask = lsb + (msb << 7)
            elif message == ANALOG_MESSAGE:
                #Analog in
                lsb = ""
                msb = ""
                while lsb == "":
                    lsb = self.sp.read()
                while msb == "":
                    msb = self.sp.read()
                lsb = ord(lsb)
                msb = ord(msb)
                self.analog[pin].value = msb << 7 | lsb
        elif data == REPORT_VERSION:
            major, minor = self.sp.read(2)
            self.firmata_version = (ord(major), ord(minor))
*)

end.
