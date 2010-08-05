class Sequence < ActiveRecord::Base



  def self.disk_free()
    s = []
    diskfree = `du -h /Users/juanlagrange/Sites/xml/data/proyects`
    folders = diskfree.split(/\n/)
    sequences = folders.collect {|x| x.split(' ') }
    for  sequence in sequences do
      s << Sequence.new(
      :name => sequence[1],
      :size => sequence[0]
      )
    end
    s
  end

end
