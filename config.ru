# encoding: utf-8
require 'yaml'
require 'json'

data = YAML.load_file('face.yml')
faces_data = {}
data.each do |category, subcategories|
  subcategories.each do |subcategory, subcategory_faces|
    subcategory_faces.each do |face|
      faces_data[face] = {category: category, subcategory: subcategory}
    end
  end
end
faces = faces_data.keys

plaintext_endpoint = Proc.new do |env|
  [200, {"Content-Type" => "text/plain", "Content-Encoding" => "utf-8"}, [faces.sample]]
end

json_endpoint = Proc.new do |env|
  face = faces.sample
  json = {face: face}.merge(faces_data[face]).to_json
  [200, {"Content-Type" => "application/json", "Content-Encoding" => "utf-8"}, [json]]
end

map('/') { run plaintext_endpoint }
map('/.json') { run json_endpoint }
