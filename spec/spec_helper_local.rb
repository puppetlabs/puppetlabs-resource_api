# see https://stackoverflow.com/a/42596812/4918, h/t @domcleal
class ResourceReference
  def initialize(ref)
    @ref = ref
  end

  def inspect
    @ref
  end
end
