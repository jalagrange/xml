class Chart 

  
attr_accessor :title, :series

  def initialize(title = nil, series = [])
      @title, @series = title, series
  end

  def show
    puts title
    @series.each do |ser|
      puts "\t#{ser.legend} (#{ser.units})"
      ser.data.each do |item|
        puts "\t\t#{item}"
      end
    end
  end

  
end
