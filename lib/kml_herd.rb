class KMLHerd

  require 'placemark'
  require 'cluster'

  def add_placemark(name, lat, lng, desc=nil)
    @pms ||= []
    pm = Placemark.new(name, lat, lng, desc)
    @pms << pm
    pm
  end

  def remove_placemark(pm)
    @pms.select! { |pms| pms != pm }
    pm
  end

  def cluster_pm(pm_from, pm_to)
    if pm_from.class != Cluster && pm_to.class != Cluster
      cls = Cluster.new('cluster', pm_from.lat, pm_from.lng, 'cluster', pm_from)
      @pms[@pms.find_index(pm_from)] = cls
      pm_from = cls
    elsif pm_to.class == Cluster && pm_from.class != Cluster
      pm_from, pm_to = pm_to, pm_from
    elsif pm_from.class == Cluster && pm_to.class == Cluster
      return
    end
    pm_from.add_placemark(pm_to)
    pm_from.lat = (pm_from.lat + pm_to.lat)/2
    pm_from.lng = (pm_from.lng + pm_to.lng)/2
    remove_placemark(pm_to)
  end

  def kml
    kml_file ||= KMLFile.new
    folder ||= KML::Folder.new(:name => 'Folder')
    @pms.each do |pm|
      folder.features << pm
    end
    kml_file.objects << folder
    kml_file.render
  end

  def placemarks
    @pms
  end

  def cluster!(zoom_level)
    self.placemarks.each do |pm_from|
      self.placemarks.each do |pm_to|
        if pm_from != pm_to
          if KMLHerd::lat_lng_dist(pm_from.lat, pm_from.lng,
                                   pm_to.lat, pm_to.lng) < 640 # for zoom 2 for now
            cluster_pm(pm_from, pm_to)
          end
        end
      end
    end
    self
  end

  def self.lat_lng_dist(lat1, lng1, lat2, lng2)
    # using 'haversine' formula with earth radius of 6371 km
    # see http://www.movable-type.co.uk/scripts/latlong.html for examples
    delta_lat = (lat2-lat1)/180.0 * Math::PI
    delta_lng = (lng2-lng1)/180.0 * Math::PI

    a = Math.sin(delta_lat/2) * Math.sin(delta_lat/2) +
        Math.cos((lat1/180.0 * Math::PI)) *
        Math.cos((lat2/180.0 * Math::PI)) *
        Math.sin(delta_lng/2) * Math.sin(delta_lng/2);

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    6371 * c
  end
end