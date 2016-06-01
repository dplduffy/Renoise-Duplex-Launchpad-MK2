--[[----------------------------------------------------------------------------
-- Duplex.LaunchpadMK2
----------------------------------------------------------------------------]]--

duplex_configurations:insert {

  -- configuration properties
  name = "PushKeyboard",
  pinned = true,

  -- device properties
  device = {
    class_name = "LaunchpadMK2",
    display_name = "Launchpad MK2",
    device_port_in = "Launchpad MK2",
    device_port_out = "Launchpad MK2",
    control_map = "Controllers/LaunchpadMK2/Controlmaps/LaunchpadMK2_PushKeyboard.xml",
    thumbnail = "Controllers/LaunchpadMK2/LaunchpadMK2.bmp",
    protocol = DEVICE_PROTOCOL.MIDI,
  },

  applications = {
    KeyboardLarge = {
      application = "Keyboard",
      mappings = {
        key_grid = {
          group_name = "LargeGrid",
          --orientation = ORIENTATION.VERTICAL,
        },
        octave_up = {
          group_name = "Controls",
          index = 1
        },
        octave_down = {
          group_name = "Controls",
          index = 2
        },
        cycle_layout = {
          group_name = "Controls",
          index = 7
        },

      },
      palette = {
        key_pressed = {
          color = {0x00,0xFF,0x00}
        },
        key_released = {
          color = {0x66,0xFF,0xFF}
        },
        key_released_content = {
          color = {0xFF,0x00,0xFF}
        },
        key_released_selected = {
          color = {0x00,0x00,0x00}
        },
      },
      options = {
      },
      hidden_options = {  -- display minimal set of options
        "channel_pressure","pitch_bend","release_type","button_width","button_height","mod_wheel","velocity_mode","keyboard_mode"
      },
    },
    Instrument = {
      mappings = {
        prev_scale = {
          group_name = "Controls",
          index = 3,
        },
        next_scale = {
          group_name = "Controls",
          index = 4,
        },
        set_key = {
          group_name = "Triggers",
          orientation = ORIENTATION.VERTICAL
        },
      }
    },
    TrackSelector = {
      mappings = {
        prev_track = {
          group_name = "Controls",
          index = 5,
        },
        next_track = {
          group_name = "Controls",
          index = 6,
        },

      }
    },
    Transport = {
      mappings = {
        edit_mode = {
          group_name = "Controls",
          index = 8,
        },
      },
    },
  }
}

