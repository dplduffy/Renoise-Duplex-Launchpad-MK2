--[[----------------------------------------------------------------------------
-- Duplex.LaunchpadMK2
----------------------------------------------------------------------------]]--

--[[

Inheritance: LaunchpadMK2 > MidiDevice > Device

A device-specific class 

--]]


--==============================================================================

class "LaunchpadMK2" (MidiDevice)

LaunchpadMK2_COLOR = 
{
  {0x00,0x00,0x00,0}, --BLACK
  {0x80,0x80,0x80,1}, --GREY
  {0xFF,0xFF,0xFF,3}, --WHITE
  {0xF0,0x80,0x80,4}, --ROSE
  {0xFF,0x00,0x00,5}, --RED
  {0x8B,0x00,0x00,7}, --DARK_RED
  {0xFF,0x8C,0x00,9}, --ORANGE
  {0xF5,0xDE,0xB3,12}, --TAN
  {0xFF,0xFF,0x00,13}, --YELLOW
  {0xAD,0xFF,0x2F,17}, --YELLOW GREEN
  {0x00,0xFF,0x00,21}, --GREEN
  {0x66,0xFF,0x99,29}, --GREEN SPRING
  {0x66,0xFF,0xCC,33}, --SPRING
  {0x66,0xFF,0xFF,37}, --LIGHT LIGHT BLUE
  {0x00,0xFF,0xFF,41}, --LIGHT BLUE
  {0x00,0x00,0xFF,45}, --BLUE
  {0x99,0x33,0xFF,49}, --BLUE PURPLE
  {0xFF,0x00,0xFF,53}, --PINK PURPLE
  {0xFF,0x33,0x99,57}, --BRIGHT PINK
}

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
    
    --This code uses sysex to output color values to the launchpad
    --it didn't work very well because the RGB color on the screen
    --never really lined up with the color the Launchpad displayed
    --due to LED differences.
    
    --local sysex_num = nil
    --local sysex_color = {}
    --sysex_num = self:extract_midi_cc(xarg.value)
    --if (sysex_num == nil) then
    --    sysex_num = self:extract_midi_note(xarg.value)
    --end
    
    --for i=1, 3 do
    --  sysex_color[i] = math.floor((pt.color[i]/255)*63)
    --end
    
    print('num',self:extract_midi_note(xarg.value))
    print('1',pt.color[1])
    print('2',pt.color[2])
    print('3',pt.color[3])
    --print('sys1',sysex_color[1])
    --print('sys2',sysex_color[2])
    --print('sys3',sysex_color[3])
    
    local skip_hardware = false  --set to true to use sysex values
    local output_color = 0
    
    local smallest_compare = 765
    
    for i=1, table.maxn(LaunchpadMK2_COLOR) do
      local compare_value = 0
        for j=1,3 do
          local temp_compare = 0
          temp_compare = math.abs(pt.color[j]-LaunchpadMK2_COLOR[i][j])
          compare_value = temp_compare+compare_value
        end
      if compare_value < smallest_compare then
        smallest_compare = compare_value
        output_color = LaunchpadMK2_COLOR[i][4]
      end
    end
    
    --self:send_sysex_message(0x00,0x20,0x29,0x02,0x18,0x0B,sysex_num,sysex_color[1],sysex_color[2],sysex_color[3])
    
    return output_color,skip_hardware
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
