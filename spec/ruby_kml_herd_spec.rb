require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RubyKmlHerd" do
  it "adds a placemark to kml" do
    binding.pry
    kh = KMLHerd.new
    kh.add_placemark('a', 1, 1, 'test')
    kh.kml.should include('<name>a</name>')
  end
end
