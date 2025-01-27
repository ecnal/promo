module V1
  class CategorySerializer
    include JSONAPI::Serializer

    attributes :name
  end
end
