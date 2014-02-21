require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RubyKmlHerd" do
  before do
    @kh = KMLHerd.new
    @kh.add_placemark('a', 0, 0, 'test')
    @kh.add_placemark('b', 4, 4, 'test')
    @kh.add_placemark('c', 10, 10, 'test')
  end

  it "adds placemarks to kml" do
    @kh.kml.should include('<name>a</name>')
    @kh.kml.should include('<coordinates>1,1</coordinates>')
    @kh.kml.should include('<name>b</name>')
    @kh.kml.should include('<coordinates>2,2</coordinates>')
    @kh.kml.should include('<name>c</name>')
    @kh.kml.should include('<coordinates>10,10</coordinates>')
  end

end
