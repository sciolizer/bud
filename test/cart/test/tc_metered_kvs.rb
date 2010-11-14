require 'rubygems'
require 'bud'
require 'test/unit'
require 'test/test_lib'
require 'test/kvs_workloads'

require 'lib/useful_combos'


class TestKVS < TestLib
  include KVSWorkloads

  def ntest_metered_testandset
    v = MeteredBestEffortReplicatedKVS.new("localhost", 23456)
    assert_nothing_raised(RuntimeError) {v.run_bg}
    add_members(v, "localhost:23456")
    workload3(v)
  end

  def ntest_wl2
    # reliable delivery fails if the recipient is down
    v = TKV.new("localhost", 12347, nil) # {'visualize' => true})
    assert_nothing_raised(RuntimeError) {v.run_bg}
    sleep 1
    add_members(v, "localhost:12347", "localhost:12348")
    if v.is_a?  ReliableDelivery
      sleep 1
      workload1(v)
      assert_equal(0, v.bigtable.length)
    end
    
  end

  def test_wl3
    # the metered kvs succeeds on the naive workload
    v = MeteredBestEffortReplicatedKVS.new("localhost", 12350, {'dump' => true})
    assert_nothing_raised(RuntimeError) {v.run_bg}
    add_members(v, "localhost:12350")
    workload1(v)
    advance(v)
    advance(v)
    advance(v)

    assert_equal(1, v.bigtable.length)
    assert_equal("bak", v.bigtable.first[1])
  end


  def test_wl4
    # the metered kvs also succeeds on a disorderly workload
    v = MeteredBestEffortReplicatedKVS.new("localhost", 12351)
    assert_nothing_raised(RuntimeError) {v.run_bg}
    add_members(v, "localhost:12351")
    workload2(v)

    soft_tick(v)
    soft_tick(v)
    soft_tick(v)
    soft_tick(v)
    soft_tick(v)
    soft_tick(v)
    soft_tick(v)

    assert_equal(1, v.bigtable.length)
    assert_equal("bak", v.bigtable.first[1])
  end
  
end

