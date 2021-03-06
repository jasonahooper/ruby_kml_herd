require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RubyKmlHerd" do
  before do
    @kh = KMLHerd.new
    @pm1 = @kh.add_placemark('a', 0, 0, 'test')
    @pm2 = @kh.add_placemark('b', -1, -1, 'test')
    @pm3 = @kh.add_placemark('c', 2, 2, 'test')
    @pm4 = @kh.add_placemark('d', 4, 4, 'test')
    @pm5 = @kh.add_placemark('e', 10, 10, 'test')
  end

  it "adds placemarks to kml" do
    @kh.kml.should include('<name>a</name>')
    @kh.kml.should include('<coordinates>0,0</coordinates>')
    @kh.kml.should include('<name>b</name>')
    @kh.kml.should include('<coordinates>-1,-1</coordinates>')
    @kh.kml.should include('<name>c</name>')
    @kh.kml.should include('<coordinates>2,2</coordinates>')
    @kh.kml.should include('<name>d</name>')
    @kh.kml.should include('<coordinates>4,4</coordinates>')
    @kh.kml.should include('<name>e</name>')
    @kh.kml.should include('<coordinates>10,10</coordinates>')
  end

  it 'keeps a record of the placemarks' do
    @kh.placemarks.count.should be(5)
  end

  it 'removes placemarks' do
    pm4 = @kh.add_placemark('z', 11, 11, 'test')
    @kh.kml.should include('<name>z</name>')
    @kh.kml.should include('<coordinates>11,11</coordinates>')
    @kh.remove_placemark(pm4)
    @kh.kml.should_not include('<name>z</name>')
    @kh.kml.should_not include('<coordinates>11,11</coordinates>')
  end

  it 'calculates distance correctly' do
    lat1 = @pm1.lat
    lng1 = @pm1.lng
    lat2 = @pm4.lat
    lng2 = @pm4.lng
    lat3 = @pm5.lat
    lng3 = @pm5.lng
    KMLHerd::lat_lng_dist(lat1, lng1, lat2, lng2).should be(628.7577973618929)
    KMLHerd::lat_lng_dist(lat2, lng2, lat1, lng1).should be(628.7577973618929)
    KMLHerd::lat_lng_dist(lat2, lng2, lat3, lng3).should be(939.7843092932496)
  end

  it 'clusters nearby points for a zoom level' do
    pms = @kh.placemarks.count
    @kh.cluster!(2)
    @kh.placemarks.count.should_not be(pms)
    @kh.placemarks[0].class.should be(Cluster)
    @kh.kml.should_not include('<name>a</name>')
    @kh.kml.should_not include('<coordinates>0,0</coordinates>')
    @kh.kml.should_not include('<name>b</name>')
    @kh.kml.should_not include('<coordinates>-1,-1</coordinates>')
  end

  it 'de-clusters and re-clusters the same data in the same way' do
    @kh.cluster!(2)
    pms = @kh.placemarks.count
    @kh.cluster!(2)
    @kh.placemarks.count.should be(pms)
  end
end
