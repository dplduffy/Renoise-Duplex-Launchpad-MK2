--[[----------------------------------------------------------------------------
-- Duplex.LaunchpadMK2 
----------------------------------------------------------------------------]]--

duplex_configurations:insert {

  -- configuration properties
  name = "Matrix + Navigator + Transport",
  pinned = true,
  
  -- device properties
  device = {
    class_name = "LaunchpadMK2",
    display_name = "Launchpad MK2",
    device_port_in = "Launchpad MK2",
    device_port_out = "Launchpad MK2",
    control_map = "Controllers/LaunchpadMK2/Controlmaps/LaunchpadMK2_Matrix.xml",
    thumbnail = "Controllers/LaunchpadMK2/LaunchpadMK2.bmp",
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
        prev_seq_page = {
          group_name = "Controls",
          index = 1,
        },
        next_seq_page = {
          group_name = "Controls",
          index = 2,
        },
        prev_track_page = {
          group_name = "Controls",
          index = 3,
        },
        next_track_page = {
          group_name = "Controls",
          index = 4,
        },
      },
    },
    Navigator = {
      mappings = {
        blockpos = {
          group_name = "Navigator",
        }
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
      }
    },

  }
}


