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

  it 'keeps a record of the placemarks' do
    @kh.placemarks.count.should be(3)
  end

  it 'calculates distance correctly' do
    lat1 = @pm1.geometry.coordinates[0]
    lng1 = @pm1.geometry.coordinates[1]
    lat2 = @pm2.geometry.coordinates[0]
    lng2 = @pm2.geometry.coordinates[1]
    lat3 = @pm3.geometry.coordinates[0]
    lng3 = @pm3.geometry.coordinates[1]
    KMLHerd::lat_lng_dist(lat1, lng1, lat2, lng2).should be(628.7577973618929)
    KMLHerd::lat_lng_dist(lat2, lng2, lat1, lng1).should be(628.7577973618929)
    KMLHerd::lat_lng_dist(lat2, lng2, lat3, lng3).should be(939.7843092932496)
  end

  it 'clusters nearby points for a zoom level' do
    cluster = @kh.cluster(2)
    cluster.placemarks.count.should_not be(@kh.placemarks.count)
  end
end
