require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path('../../lib/procinfo', __FILE__)

describe 'Process' do
  describe '#stats' do
    before do
      @stats = Process.stats
    end

    it 'should return a Process::ProcStats instance' do
      @stats.must_be_instance_of Process::ProcStats
    end

    %w{
      user_time system_time max_rss shared_text_size unshared_data_size
      unshared_stack_size page_reclaims page_faults swaps block_input_ops
      block_output_ops msgs_sent msgs_recvd signals_recvd voluntary_switches
      involuntary_switches
    }.each do |field|
      it "should not have a nil ProcStats##{field} value" do
        @stats.send(field).wont_be_nil
      end

      it "should not have a negative ProcStats##{field} value" do
        @stats.send(field).must_be :>=, 0
      end
    end
  end
end
