class Chart 

  
attr_accessor :title, :series, :to, :from

def initialize( options = {} )
    @title = options[:title]
    @to = options[:to]
    @from = options[:from]
    @series = []
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
