require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RubyKmlHerd" do
  before do
    @kh = KMLHerd.new
    @pm1 = @kh.add_placemark('a', 0, 0, 'test')
    @pm2 = @kh.add_placemark('b', 4, 4, 'test')
    @pm3 = @kh.add_placemark('c', 10, 10, 'test')
  end

  it "adds placemarks to kml" do
    @kh.kml.should include('<name>a</name>')
    @kh.kml.should include('<coordinates>0,0</coordinates>')
    @kh.kml.should include('<name>b</name>')
    @kh.kml.should include('<coordinates>4,4</coordinates>')
    @kh.kml.should include('<name>c</name>')
    @kh.kml.should include('<coordinates>10,10</coordinates>')
  end

  it 'calculates distance correctly' do
    lat1 = @pm1.geometry.coordinates[0]
    lon1 = @pm1.geometry.coordinates[1]
    lat2 = @pm2.geometry.coordinates[0]
    lon2 = @pm2.geometry.coordinates[1]
    KMLHerd::lat_lon_dist(lat1, lon1, lat2, lon2).should eq(628.7577973618929)
  end
end
