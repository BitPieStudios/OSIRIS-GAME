class Scene < Sequel::Model(:scenes)
	one_to_many :next_scenes, :key => :parent_id, :class => self

  def self.first_scene
    where('parent_id IS NULL').first
  end
end
