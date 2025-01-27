module V1
  class BrandSerializer
    include JSONAPI::Serializer

    attributes :name
  end
end
