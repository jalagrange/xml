class ProcessSpace < ActiveRecord::Base

  belongs_to :project
  belongs_to :software

  def self.disk_free(project, software)
    p = []
    diskfree = `du -k -d=1 /Users/juanlagrange/Sites/xml/data/projects/'#{project.name}'/proc/'#{software.name}'/*`
    folders = diskfree.split(/\n/)
    spaces = folders.collect {|x| x.split(' ') }
    for  space in spaces do
      p << ProcessSpace.new(
      :name => space[1],
      :size => space[0]
      )
    end
    p
  end

end
