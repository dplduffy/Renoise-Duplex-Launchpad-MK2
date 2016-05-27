--[[----------------------------------------------------------------------------
-- Duplex.LaunchpadMK2
----------------------------------------------------------------------------]]--

--[[

Inheritance: LaunchpadMK2 > MidiDevice > Device

A device-specific class 

--]]


--==============================================================================

class "LaunchpadMK2" (MidiDevice)

LaunchpadMK2_COLOR_HEX = 
{
  {0x00,0x00,0x00}, --BLACK
  {0x80,0x80,0x80}, --GREY_LO
  {0xC0,0xC0,0xC0}, --GREY_MD
  {0xFF,0xFF,0xFF}, --WHITE
  {0xF0,0x80,0x80}, --ROSE
  {0xFF,0x00,0x00}, --RED_HI
  {0xB2,0x22,0x22}, --RED
  {0x8B,0x00,0x00}, --RED_LO
  {0xFF,0x8C,0x00}, --ORANGE_HI
  {0xFF,0xA5,0x00}, --ORANGE
  {0xF5,0xDE,0xB3}, --TAN
  {0xFF,0xFF,0x00}, --YELLOW HI
  {0xAD,0xFF,0x2F}, --YELLOW GREEN
  {0x00,0xFF,0x00}, --LIME
  {0x98,0xFB,0x98}, --LIME GREEN
  {0x00,0x80,0x00}, --GREEN HI
  {0x00,0x64,0x00}, --GREEN LO
  {0x00,0xFF,0x7F}, --GREEN SPRING
  {0x00,0xFA,0x9A}, --SPRING
  {0x22,0x8B,0x22}, --FOREST GREEN
  {0x00,0xFF,0x7F}, --SPRING TURQUOISE
  {0xE0,0xFF,0xFF}, --TURQUOISE CYAN
  {0x00,0xCC,0x99}, --CYAN HI
  {0x53,0xC6,0x8C}, --CYAN
  {0x39,0xAC,0x73}, --CYAN LO
  {0x80,0xFF,0xCC}, --CYAN SKY
  {0x00,0xFF,0xFF}, --SKY HI
  {0x00,0xCC,0xCC}, --SKY LO
  {0xB3,0xFF,0xFF}, --SKY OCEAN
  {0x00,0xCC,0xFF}, --OCEAN HI
  {0x00,0xA3,0xCC}, --OCEAN LO
  {0x00,0x66,0xFF}, --BLUE HI
  {0x00,0x00,0x99}, --BLUE LO
  {0xCC,0x99,0xFF}, --BLUE ORCHID
  {0x99,0x99,0xFF}, --ORCHID HI
  {0x73,0x33,0xFF}, --ORCHID
  {0xFF,0x99,0xFF}, --ORCHID MAGENTA
  {0xFF,0x66,0xFF}, --MAGENTA HI
  {0xFF,0x00,0xFF}, --MAGENTA
  {0xFF,0xCC,0xFF}, --MAGENTA_LO
  {0xFF,0xCC,0xCC}, --MAGENTA_PINK
  {0xFF,0x33,0x99}, --PINK_HI
  {0xCC,0x33,0x99}, --PINK_LO
}

LaunchpadMK2_COLOR_DEC = 
{
  0;
  1;
  2;
  3;
  4;
  5;
  6;
  7;
  9;
  10;
  12;
  13;
  16;
  17;
  20;
  21;
  22;
  25;
  27;
  29;
  32;
  33;
  34;
  35;
  36;
  37;
  39;
  40;
  41;
  43;
  45;
  47;
  48;
  49;
  50;
  52;
  53;
  54;
  55;
  56;
  57;
  59;
}

LaunchpadMK2_NUM_COLORS = 43;


function LaunchpadMK2:__init(display_name, message_stream, port_in, port_out)
  TRACE("LaunchpadMK2:__init", display_name, message_stream, port_in, port_out)

  self.colorspace = {1,1,1}
  
  MidiDevice.__init(self, display_name, message_stream, port_in, port_out)

end

--------------------------------------------------------------------------------

-- clear display before releasing device:
-- all LEDs are turned off, and the mapping mode, buffer settings, 
-- and duty cycle are reset to defaults

function LaunchpadMK2:release()
  TRACE("LaunchpadMK2:release()")

  self:send_cc_message(0,0) 
  MidiDevice.release(self)

end

--------------------------------------------------------------------------------

--- override default Device method
-- @see Device.output_value

function LaunchpadMK2:output_value(pt,xarg,ui_obj)
  TRACE("LaunchpadMK2:output_value(pt,xarg,ui_obj)",pt,xarg,ui_obj)
  
    --if xarg.skip_echo then
        --- parameter only exist in the virtual ui
    --  return Device.output_value(self,pt,xarg,ui_obj)
    --else
  
    --print("launchpad output value...",rprint(pt.color))

    --default color is off
    local rslt = 0
    local skip_hardware = false
    local compare_array = {} 
    local sysex_num = nil
    local sysex_color = {}
    
    sysex_num = self:extract_midi_cc(xarg.value)
    if (sysex_num == nil) then
        sysex_num = self:extract_midi_note(xarg.value)
    end

    --print(sysex_num)
    
    for i=1, 3 do
      sysex_color[i] = math.floor((pt.color[i]/255)*63)
    end
    
    --print('1',pt.color[1])
    --print('2',pt.color[2])
    --print('3',pt.color[3])
    --print('sys1',sysex_color[1])
    --print('sys2',sysex_color[2])
    --print('sys3',sysex_color[3])
    
    local smallest_val = 675
    local smallest_key = 0
    
    for i=1, LaunchpadMK2_NUM_COLORS do
        compare_array[i] = find_color_difference(pt.color,LaunchpadMK2_COLOR_HEX[i])
        if compare_array[i] < smallest_val then
            smallest_val = compare_array[i]
            smallest_key = i
        end
    end
    
    rslt = LaunchpadMK2_COLOR_DEC[smallest_key]
    
    --print("rslt",rslt)
    --self:send_sysex_message(0x00,0x20,0x29,0x02,0x18,0x0B,sysex_num,sysex_color[1],sysex_color[2],sysex_color[3])
    
    return rslt,skip_hardware
end

function find_color_difference(array1,array2)
    local compare_array = {}
    local compare_num = nil
    
    for i=1,3 do
        compare_array[i]=math.abs(array1[i]-array2[i])
    end
    
    compare_num = (compare_array[1]+compare_array[2]+compare_array[3])
    return compare_num
end

--------------------------------------------------------------------------------
-- A couple of sample configurations
--------------------------------------------------------------------------------

-- setup "Mixer" as the only app for this configuration

--[[
duplex_configurations:insert {

  -- configuration properties
  name = "Mixer",
  pinned = false,

  -- device properties
  device = {
    class_name = "Launchpad",
    display_name = "Launchpad",
    device_port_in = "Launchpad",
    device_port_out = "Launchpad",
    control_map = "Controllers/Launchpad/Launchpad.xml",
    thumbnail = "Launchpad.bmp",
    protocol = DEVICE_PROTOCOL.MIDI,
  },

  applications = {
    Mixer = {
      mappings = {
        levels = {
          group_name = "Grid",
        },
        mute = {
          group_name = "Controls",
        },
        master = {
          group_name = "Triggers",
        }
      },
      options = {
        invert_mute = 1
      }
    }
  }
}
]]

--------------------------------------------------------------------------------

-- Here's how to make a second Launchpad show up as a separate device 
-- Notice that the "display name" is different

--[[
duplex_configurations:insert {

  -- configuration properties
  name = "Matrix + Transport",
  pinned = true,
  
  -- device properties
  device = {
    class_name = "Launchpad",
    display_name = "Launchpad (2)",
    device_port_in = "Launchpad (2)",
    device_port_out = "Launchpad (2)",
    control_map = "Controllers/Launchpad/Launchpad.xml",
    thumbnail = "Launchpad.bmp",
    protocol = DEVICE_PROTOCOL.MIDI,
  },

  applications = {
    Matrix = {
      mappings = {
        matrix = {
          group_name = "Grid",
        },
        triggers = {
          group_name = "Triggers",
        },
        sequence = {
          group_name = "Controls",
          index = 1,
        },
        track = {
          group_name = "Controls",
          index = 3,
        }
      },
      options = {
        --switch_mode = 4,
      }
    },
    Transport = {
      mappings = {
        edit_mode = {
          group_name = "Controls",
          index = 5,
        },
        start_playback = {
          group_name = "Controls",
          index = 6,
        },
        loop_pattern = {
          group_name = "Controls",
          index = 7,
        },
        follow_player = {
          group_name= "Controls",
          index = 8,
        },
      },
      options = {
        pattern_play = 3,
      },
    },

  }
}

]]
