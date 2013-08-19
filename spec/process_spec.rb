require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path('../../lib/procinfo', __FILE__)

describe 'Process' do
  %w(self children).each do |arg|
    describe "#stats(:#{arg})" do
      before do
        @stats = Process.stats(arg.to_sym)
      end

      it 'should return a Process::ProcStats instance' do
        @stats.must_be_instance_of(Process::ProcStats)
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

  describe '#stats(nil)' do
    it "should raise ArgumentError" do
      lambda { Process.stats(nil) }.must_raise(ArgumentError)
    end
  end

  describe '#stats' do
    before do
      @stats = Process.stats
    end

    it "should default to :self and return ProcStats instance" do
      @stats.must_be_instance_of(Process::ProcStats)
    end
  end

  describe '#stats_for_self' do
    it 'should be a private method' do
      lambda { Process.stats_for_self }.must_raise(NoMethodError)
    end
  end

  describe '#stats_for_children' do
    it 'should be a private method' do
      lambda { Process.stats_for_children }.must_raise(NoMethodError)
    end
  end
end
