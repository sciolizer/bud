require 'test_common'

require 'tc_errors'
require 'tc_aggs'
require 'tc_attr_rewrite'
require 'tc_callback'
require 'tc_channel'
require 'tc_collections'
require 'tc_delta'
require 'tc_exists'
require 'tc_inheritance'
require 'tc_interface'
require 'tc_joins'
require 'tc_mapvariants'
require 'tc_nest'
require 'tc_schemafree'
require 'tc_terminal'
require 'tc_timer'
require 'tc_wc'
require 'tc_module'
require 'tc_temp'
require 'tc_threaddeploy'; 
#require 'tc_forkdeploy'
puts "tc_forkdeploy temporarily disabled"
require 'tc_dbm'
require 'tc_meta'
require 'tc_foreground'
require 'tc_metrics'
if defined? Bud::HAVE_TOKYOCABINET
  require 'tc_tc'
end
#require 'tc_bust'
puts "tc_bust temporarily disabled"
require 'tc_new_executor'
require 'tc_sort'
#require 'tc_semistructured' -- removed because using structs now