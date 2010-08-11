class Sequence < ActiveRecord::Base

belongs_to :project
belongs_to :formato


  def self.disk_free(project, formato)
    s = []
    diskfree = `du -k -d=1 /Users/juanlagrange/Sites/xml/data/projects/'#{project.name}'/original/'#{formato.name}'/*`
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
