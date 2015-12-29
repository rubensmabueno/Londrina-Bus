class StopSerializer < ActiveModel::Serializer
  attributes :id, :text

  def text
    "#{object.code} - #{object.title}"
  end
end
