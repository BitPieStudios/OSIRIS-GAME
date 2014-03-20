class Scene < Sequel::Model(:scenes)
	one_to_many :next_scenes, :key => :parent_id, :class => self
end
