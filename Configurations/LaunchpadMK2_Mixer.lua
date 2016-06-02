--[[----------------------------------------------------------------------------
-- Duplex.LaunchpadMK2
----------------------------------------------------------------------------]]--

duplex_configurations:insert {

  -- configuration properties
  name = "Mixer + Navigator + Transport",
  pinned = true,

  -- device properties
  device = {
    class_name = "LaunchpadMK2",
    display_name = "Launchpad MK2",
    device_port_in = "Launchpad MK2",
    device_port_out = "Launchpad MK2",
    control_map = "Controllers/LaunchpadMK2/Controlmaps/LaunchpadMK2_Mixer.xml",
    thumbnail = "Controllers/LaunchpadMK2/LaunchpadMK2.bmp",
    protocol = DEVICE_PROTOCOL.MIDI,
  },

  applications = {
    Mixer = {
      mappings = {
        levels = {
          group_name = "Grid",
        },
        mute = {
          group_name = "Grid",
        },
        solo = {
          group_name = "Grid",
        },
        master = {
          group_name = "Grid",
        },
        page = {
          group_name = "Controls",
          index = 3
        },
      },
      options = {
        invert_mute = 1,
        page_size = 2,
        follow_track = 1,
      }
    },
    Navigator = {
      mappings = {
        blockpos = {
          group_name = "Triggers",
        }
      }
    },
    Transport = {
      mappings = {
        goto_previous = {
          group_name= "Controls",
          index = 1,
        },
        goto_next = {
          group_name= "Controls",
          index = 2,
        },
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


