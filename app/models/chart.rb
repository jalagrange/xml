class Chart 

  
attr_accessor :title, :series, :to

  def initialize(title = nil, series = [], to = nil)
      @title, @series, @to = title, series, to
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
