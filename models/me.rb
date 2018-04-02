class Me
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :about, type: String
  field :blog_uri, type: String
  field :photo_uri, type: String
  field :skills, type: Array
  field :experience, type: Hash
  field :education, type: Hash

  def as_json(*)
    {
      "id": id.to_s,
      "board": board,
      "state": state,
      "mines": mines,
      "mine_places": mine_places
    }
  end
end
