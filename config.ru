# encoding: utf-8
require 'yaml'

data = YAML.load_file('face.yml')
faces = []
data.each do |category, subcategories|
  subcategories.each do |subcategory, subcategory_faces|
    faces.concat(subcategory_faces)
  end
end

server = Proc.new do |env|
  [200, {"Content-Type" => "text/plain", "Content-Encoding" => "utf-8"}, [faces.sample]]
end

run server
