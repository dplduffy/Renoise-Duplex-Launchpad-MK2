--[[----------------------------------------------------------------------------
-- Duplex.LaunchpadMK2 
----------------------------------------------------------------------------]]--

duplex_configurations:insert {

  -- configuration properties
  name = "GridPieFull",
  pinned = true,

  -- device properties
  device = {
    class_name = "LaunchpadMK2",
    display_name = "Launchpad MK2",
    device_port_in = "Launchpad MK2",
    device_port_out = "Launchpad MK2",
    control_map = "Controllers/LaunchpadMK2/Controlmaps/LaunchpadMK2.xml",
    thumbnail = "Controllers/LaunchpadMK2/LaunchpadMK2.bmp",
    protocol = DEVICE_PROTOCOL.MIDI,
  },

  applications = {
    GridPie = {
	    mappings = {
	      grid = {
          group_name = "Grid",
        },
	      v_prev = {
          group_name = "Controls",
          index = 1,
        },
	      v_next = {
          group_name = "Controls",
          index = 2,
        },
	      h_prev = {
          group_name = "Controls",
          index = 3,
        },
	      h_next = {
          group_name = "Controls",
          index = 4,
        },
    	},
      options = {
        follow_pos = 2
      },
    },
    Navigator = {
      mappings = {
        blockpos = {
          group_name = "Triggers",
        },
      },
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