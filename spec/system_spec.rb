require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path('../../lib/procinfo', __FILE__)

describe 'Process' do
  describe '#uname' do
    before do
      @uname = System.uname
    end

    it 'should return a System::SystemInfo instance' do
      @uname.must_be_instance_of(System::SystemInfo)
    end

    %w(sysname nodename release).each do |field|
      it "should return non-nil #{field}" do
        @uname.sysname.wont_be_nil
      end
    end
  end
end
