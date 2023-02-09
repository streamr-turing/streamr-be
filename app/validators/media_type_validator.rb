class MediaTypeValidator < ActiveModel::Validator
  def validate(record)
    unless ['movie', 'tv'].include?(record.media_type)
      record.errors.add :base, "Invalid mediaType supplied: must be 'movie' or 'tv'"
    end
  end
end