class Sequence < ActiveRecord::Base

belongs_to :proyect
belongs_to :formato


  def self.disk_free(proyect, formato)
    s = []
    diskfree = `du -k -d=1 /Users/juanlagrange/Sites/xml/data/proyects/'#{proyect.name}'/original/'#{formato.name}'/*`
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
