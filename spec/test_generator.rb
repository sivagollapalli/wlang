require 'spec_helper'
module WLang
  describe Generator do
    
    let(:generator){ WLang::Generator.new }
    
    subject{ generator.call(source) }

    describe '[:proc, ...]' do
      let(:source)  { [:proc, [:static, "Hello world"]] }
      let(:expected){ %q{lambda{|d1,b1| b1 << ("Hello world") }} }
      it{ should eq(expected) }
    end

    describe '[:wlang, ...]' do
      let(:source)  { [:wlang, "$", [:proc, [:static, "Hello world"]]]      }
      let(:expected){ %q{_buf << (d0.wlang("$", [lambda{|d1,b1| b1 << ("Hello world") }]))} }
      it{ should eq(expected) }
    end

  end
end